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
 *      basepath: string;
 *   };
 *   positionals: string[];
 * }}
 */
const { values, positionals } = parseArgs({
  options: {
    version: { type: 'boolean', short: 'v' },
    help: { type: 'boolean', short: 'h' },
    basepath: { type: 'string' },
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
  case 'build':
    await build(values);
}

function showHelpThenExit(code = 0) {
  console.log(`\
./x - Napkin Utilities
Usage: ./x [-v | --version] [-h | --help]
           <command> [<args>]

  register <github-handle>      Fetch GitHub profile from handle and download
                                the profile to register it to users
  build                         Build a website displaying solutions
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

  const avatar = await fetch(payload.avatar_url)
  const file = createWriteStream(path.join(targetDir, avatarFilename))
  await finished(Readable.fromWeb(avatar.body).pipe(file))

  await fs.writeFile(
    path.join(targetDir, `${handle.toLowerCase()}.json`),
    JSON.stringify(
      {
        login: payload.login,
        name: payload.name,
        avatar: {
          path: path.relative(
            `template`,
            path.join(targetDir, avatarFilename),
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
    .flatMap(x => x.match(/^([a-zA-Z\d](?:[a-zA-Z\d]|-(?=[a-zA-Z\d])){0,38})\.json$/)?.[1] ?? [])
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

async function build({ basepath = '' }) {
  const dist = 'dist/';
  log(`Clean build the website to \x1B[4m${dist}\x1B[0m...`);
  await fs.rm(dist, { recursive: true, force: true });
  await fs.mkdir(dist, { recursive: true });

  const problems = await fs.readdir('.');
  const compiledProblems = (
    await Promise.all(
      problems.map(async (filename) => {
        const group = /^([0-9]+)([A-Z]+)\.typ$/.exec(filename);
        if (!group) return null;
        const [_, chapter, problemCode] = group;
        log(`typst compile --root . -f svg ${filename} -`, '$');
        return {
          chapter,
          fullProblemCode: `${chapter}${problemCode}`,
          problemCode,
          svg: (
            await $(`typst compile --root . -f svg - -`, {
              stdin: dedent(`
                | #set page(margin: 2em, height: auto)
                | ${await fs.readFile(filename, { encoding: 'utf-8' })}
              `),
              silent: true,
              requireValue: true,
            })
          ).stdout,
        };
      }),
    )
  ).filter(Boolean);
  compiledProblems.sort((a, b) => {
    if (a.chapter != b.chapter) {
      return a.chapter - b.chapter;
    }
    return a.problemCode.localeCompare(b);
  });

  const chapters = Array.from(
    new Set(compiledProblems.map(({ chapter }) => chapter)),
  );
  for (const chapter of chapters) {
    log(`Building \x1B[4m${chapter}.html\x1B[0m...`);
    const problems = compiledProblems.filter(
      (problem) => problem.chapter === chapter,
    );
    await fs.writeFile(
      path.join(dist, `${chapter}.html`),
      dedent(`
          | <!DOCTYPE html>
          | <head>
          | <style>
          | ol { list-style: none; }
          | svg { max-width: 80em; }
          | </style>
          | <body>
          | <h1>@napkin-community/solutions &gt; Chapter ${chapter}</h1>
          | <a href=${JSON.stringify(
            path.posix.resolve('/', basepath),
          )}>Back to Chapter Selection</a>
          | <h2>Table of Contents</h2>
          | <ol>
          ${problems
            .map((problem) =>
              dedent(`
                | <li>
                | <a href="#${problem.fullProblemCode}">${problem.fullProblemCode}</a>
                | </li>
              `),
            )
            .join('\n')}
          | </ol>
          ${problems
            .map((problem) =>
              dedent(`
                | <h2 id="${problem.fullProblemCode}">${problem.fullProblemCode}</h2>
                | ${problem.svg}
              `),
            )
            .join('\n')}
          | <script>
          |   for (const doc of document.querySelectorAll('svg.typst-doc')) {
          |     doc.removeAttribute('width');
          |     doc.removeAttribute('height');
          |   }
          | </script>
        `),
      { encoding: 'utf-8' },
    );
  }

  log('Building \x1B[4mindex.html\x1B[0m');
  await fs.writeFile(
    path.join(dist, 'index.html'),
    dedent(`
      | <!DOCTYPE html>
      | <head>
      | <style>
      | ol {
      |   list-style: none;
      |   width: 100svw;
      |   padding: 2rem;
      |   display: grid;
      |   gap: 2rem;
      |   grid-template-columns: repeat(auto-fill, minmax(8rem, 1fr));
      | }
      | li {
      |   aspect-ratio: 3 / 4;
      |   border: 2px solid black;
      |   border-radius: 0.25rem;
      |   font-size: 2rem;
      | }
      | li > a {
      |   width: 100%;
      |   height: 100%;
      |   padding: 0.5rem;
      |   display: flex;
      |   flex-direction: column;
      |   align-items: center;
      |   justify-content: end;
      |   text-decoration: none;
      |   color: unset;
      | }
      | </style>
      | <body>
      | <h1>@napkin-community/solutions</h1>
      | <ol>
      ${chapters
        .map((chapter) =>
          dedent(`
            | <li>
            | <a href=${JSON.stringify(
              path.posix.resolve('/', basepath, `${chapter}.html`),
            )}>Ch. ${chapter}</a>
            | </li>
          `),
        )
        .join('\n')}
      | </ol>
    `),
    { encoding: 'utf-8' },
  );
  log('Done!');
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
 * @returns {Promise<{ stdout: string, stderr: string }>}
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
      (error, stdout, stderr) => resolve({ stdout, stderr }),
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
  const c = {'$': '33', '!': '31' }[level] ?? '34';
  console.log(`    \x1B[${c}m[${level}]\x1B[0m    ${string}`);
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
