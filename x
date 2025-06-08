#!/usr/bin/env node
import process from 'node:process';
import { parseArgs } from 'node:util';
import { exec } from 'node:child_process';
import { Readable } from 'node:stream';
import { finished } from 'node:stream/promises';
import { createWriteStream } from 'node:fs';
import fs from 'node:fs/promises';
import path from 'node:path';

/**
 * @type {{
 *   values: {
 *      version: boolean;
 *      help: boolean;
 *   };
 *   positionals: string[];
 * }}
 */
const { values, positionals } = parseArgs({
  options: {
    version: { type: 'boolean', short: 'v' },
    help: { type: 'boolean', short: 'h' },
  },
  allowPositionals: true,
});

if (values.help) {
  showHelpThenExit();
}
if (values.version) {
  console.log('./x 0.1.0-SNAPSHOT.1');
  process.exit(0);
}

switch (positionals[0]) {
  default:
    log(`Unknown command: ./x ${positionals[0]}`, '!');
    console.log();
  case undefined:
  case 'help':
    showHelpThenExit();
  case 'register':
    await register(positionals[1]);
    break;
  case 'check':
    await check();
    break;
}

function showHelpThenExit(code = 0) {
  console.log(`\
./x - Napkin Utilities
Usage: ./x [-v | --version] [-h | --help]
           <command> [<args>]

  register <github-handle>      Fetch GitHub profile from handle and download
                                the profile to register it to users
  check                         Check whether the typst source file valid
`);
  process.exit(code);
}

async function register(handle) {
  if (handle == null) {
    log(`Handle is not supplied to the register command`, '!');
    console.log();
    showHelpThenExit(1);
  }
  log(`Fetch \x1B[4m${handle}\x1B[0m from GitHub...`);
  const resp = await fetch(`https://api.github.com/users/${handle}`);
  const payload = await resp.json();

  const targetDir = `users/`;
  await fs.mkdir(targetDir, { recursive: true });
  const avatarMime = (await fetch(payload.avatar_url)).headers.get(
    'Content-Type',
  );
  const avatarFormat = avatarMime.replace(/^image\//, '');
  const avatarFilename = `${handle.toLowerCase()}.${avatarFormat}`;

  const avatar = await fetch(payload.avatar_url);
  const file = createWriteStream(path.join(targetDir, avatarFilename));
  await finished(Readable.fromWeb(avatar.body).pipe(file));

  await fs.writeFile(
    path.join(targetDir, `${handle.toLowerCase()}.json`),
    JSON.stringify(
      {
        login: payload.login,
        name: payload.name,
        avatar: {
          path: path.posix.relative(
            `template`,
            path.posix.join(targetDir, avatarFilename),
          ),
          format: avatarFormat,
        },
        social: {
          github: `https://github.com/${payload.login}`,
          twitter: payload.twitter_username
            ? `https://twitter.com/${payload.twitter_username}`
            : null,
        },
      },
      null,
      2,
    ) + '\n',
    { encoding: 'utf-8' },
  );
  log(`Successfully wrote metadata for \x1B[4m${payload.login}\x1B[0m`);
  log(`Update \x1B[4mtemplate/napkin-users.typ\x1B[0m...`);

  const wholeUsers = (await fs.readdir(targetDir))
    .flatMap(
      (x) =>
        x.match(
          /^([a-zA-Z\d](?:[a-zA-Z\d]|-(?=[a-zA-Z\d])){0,38})\.json$/,
        )?.[1] ?? [],
    )
    .toSorted((a, b) => a.localeCompare(b));
  await fs.writeFile(
    `template/napkin-users.typ`,
    dedent(`
    | #let users = (
    ${wholeUsers
      .map((user) =>
        [
          `|   "${user}": {`,
          `|     let metadata = json("../users/${user}.json")`,
          `|     let avatar = read(metadata.avatar.path, encoding: none)`,
          `|     (..metadata, avatar: (source: avatar, format: metadata.avatar.format))`,
          `|   },`,
        ].join('\n'),
      )
      .join('\n')}
    | )
    `),
    { encoding: 'utf-8' },
  );
}

async function check() {
  // install
  const { error } = await $(`typst compile - - > /dev/null`, {
    stdin: `
      #import "@preview/fletcher:0.5.7"
    `,
  });
  if (error) throw error;
  // build
  const files = (await fs.readdir('.')).filter((x) => x.match(/.typ$/));
  log(`Checking ${files.length} files...`);
  let counter = 0;
  await Promise.all(
    files.map(async (file) => {
      const result = await $(`typst compile ${file} - > /dev/null`);
      if (result.error) {
        throw result.error;
      }
      counter += 1;
      log(`[${counter}/${files.length}] ${file}`, 'check');
    }),
  );
}

/**
 *
 * @param command {string
 * @param options {{
 *   cwd?: string;
 *   silent?: boolean;
 *   requireValue?: boolean;
 * }}}
 *
 * @returns {Promise<{ error: unknown; stdout: string, stderr: string }>}
 */
function $(command, { cwd, stdin, silent = false, requireValue = false } = {}) {
  if (!silent) log(command, '$');
  return new Promise((resolve) => {
    const process = exec(
      command,
      {
        cwd,
        stdio: requireValue ? 'pipe' : silent ? 'ignore' : 'inherit',
        encoding: 'utf-8',
      },
      (error, stdout, stderr) => resolve({ error, stdout, stderr }),
    );
    if (stdin != null) {
      process.stdin.write(stdin);
      process.stdin.end();
    }
  });
}

/**
 *
 * @param string {string}
 * @param level {string}
 * @returns {undefined}
 */
function log(string, level = 'i') {
  const prefix =
    { $: `\x1B[33m[$]\x1B[0m`, '!': `\x1B[31m[i]\x1B[0m`, check: '✅' }[
      level
    ] ?? `\x1B[34m[${level}]\x1B[0m`;
  console.log(`    ${prefix}    ${string}`);
}

/**
 *
 * @param string {string}
 * @returns {string}
 */
function dedent(string) {
  return string
    .trim()
    .split('\n')
    .map((x) => x.trimStart().replace(/^\|(?: |$)/, '') + '\n')
    .join('');
}
