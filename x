#!/usr/bin/env node
import process from 'node:process';
import { parseArgs } from 'node:util';
import { exec } from 'node:child_process';
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

async function version() {
  console.log(`./x 0.1.0-SNAPSHOT.1`);
}

async function help() {
  console.log(dedent(`
    | ./x - Napkin Utilities
    | Usage: ./x [-v | --version] [-h | --help]
    |            <command> [<args>]
    |
    |   register <github-handle>      Fetch GitHub profile from handle and download
    |                                 the profile to register it to users
    |   website                       Make website displaying solutions
  `));
}

async function register(handle) {
  if (handle == null) {
    console.log(
      `    \x1B[31m[!]\x1B[0m    Handle is not supplied to the register command`,
    );
    process.exit(1);
  }
  console.log(
    `    \x1B[34m[i]\x1B[0m    Fetch \x1B[4m${handle}\x1B[0m from GitHub...`,
  );
  const response = JSON.parse(
    (
      await $(`curl https://api.github.com/users/${handle}`, {
        requireValue: true,
      })
    ).stdout,
  );

  const targetDir = `users/`;
  await fs.mkdir(targetDir, { recursive: true });
  const avatarMime = (await fetch(response.avatar_url)).headers.get(
    'Content-Type',
  );
  const avatarFormat = avatarMime.replace(/^image\//, '');
  const avatarFilename = `${handle.toLowerCase()}.${avatarFormat}`;
  await $(`curl ${response.avatar_url} --output ${avatarFilename}`, {
    cwd: targetDir,
  });
  await fs.writeFile(
    path.join(targetDir, `${handle.toLowerCase()}.json`),
    JSON.stringify(
      {
        login: response.login,
        name: response.name,
        avatar: {
          path: path.relative(
            `template`,
            path.join(targetDir, avatarFilename),
          ),
          format: avatarFormat,
        },
        social: {
          github: `https://github.com/${response.login}`,
          twitter: response.twitter_username
            ? `https://twitter.com/${response.twitter_username}`
            : null,
        },
      },
      null,
      2,
    ) + '\n',
    { encoding: 'utf-8' },
  );
  console.log(
    `    \x1B[34m[i]\x1B[0m    Successfully wrote metadata for \x1B[4m${response.login}\x1B[0m`,
  );
  console.log(
    `    \x1B[34m[i]\x1B[0m    Update \x1B[4mtemplate/napkin-users.typ\x1B[0m...`,
  );

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

async function website({ basepath = '' }) {
  const dist = 'dist/';
  console.log(
    `    \x1B[34m[i]\x1B[0m    Clean build the website to \x1B[4m${dist}\x1B[0m...`,
  );
  await fs.rm(dist, { recursive: true, force: true });
  await fs.mkdir(dist, { recursive: true });

  const problems = await fs.readdir('.');
  const compiledProblems = (
    await Promise.all(
      problems.map(async (filename) => {
        const group = /^([0-9]+)([A-Z]+)\.typ$/.exec(filename);
        if (!group) return null;
        const [_, chapter, problemCode] = group;
        console.log(
          `    \x1B[33m[$]\x1B[0m    typst compile --root . -f svg ${filename} -`,
        );
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
    console.log(
      `    \x1B[34m[i]\x1B[0m    Building \x1B[4msrc/problems/${chapter}.html\x1B[0m...`,
    );
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

  console.log(`    \x1B[34m[i]\x1B[0m    Making index...`);

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
  console.log(`    \x1B[34m[i]\x1B[0m    Done!`);
}

if (values.help) {
  help();
  process.exit(0);
}
if (values.version) {
  version();
  process.exit(0);
}

switch (positionals[0]) {
  case undefined:
  case 'help':
    await help();
    break;
  case 'register':
    await register(positionals[1]);
    break;
  case 'website':
    await website(values);
    break;
  default:
    console.log(
      `    \x1B[31m[!]\x1B[0m    Unknown command: ./x ${positionals[0]}`,
    );
    process.exit(1);
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
  if (!silent) {
    console.log(`    \x1B[33m[$]\x1B[0m    ${command}`);
  }
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
 * @returns {string}
 */
function dedent(string) {
  return string
    .trim()
    .split('\n')
    .map((x) => x.trimStart().replace(/^\|(?: |$)/, '') + '\n')
    .join('');
}
