#!/usr/bin/env -S node --no-warnings
import process from 'node:process';
import { parseArgs } from 'node:util';
import { execSync } from 'node:child_process';
import fs from 'node:fs/promises';
import path from 'node:path';

/**
 * @type {{
 *   values: {
 *      version: boolean;
 *      help: boolean;
 *      force: boolean;
 *   };
 *   positionals: string[];
 * }}
 */
const { values, positionals } = parseArgs({
  options: {
    version: { type: 'boolean', short: 'v' },
    help: { type: 'boolean', short: 'h' },
    force: { type: 'boolean', short: 'f' },
  },
  allowPositionals: true,
});

const commands = {
  async version() {
    console.log(`./x 0.1.0-SNAPSHOT.0`);
  },
  async help() {
    console.log(`./x - Napkin Utilities`);
    console.log(`Usage: ./x [--version] [--help]`);
    console.log(`           <command> [<args>]`);
    console.log(``);
    console.log(`retrieve the napkin book into .x/napkin folder`);
    console.log(
      `  build [hash] [--force] [-f]   Build the book using specified source.`,
    );
    console.log(
      `                                if unspecified, it will build from main`,
    );
    console.log(
      `  download                      Get the most recent napkin book`,
    );
    console.log(
      `  list                          List downloaded napkin pdf files`,
    );
    console.log(
      `  register <github-handle>      Fetch GitHub profile from handle and download`,
    );
    console.log(
      `                                the profile to register it to challengers`,
    );
  },
  async build(hash = 'main', { force = false } = {}) {
    const targetDir = `.x/napkin/snapshots/${hash}`;
    const sourceDir = path.join(targetDir, 'source');
    try {
      if (force) throw new Error('force!');
      await fs.access(sourceDir);
      console.log(
        `    \x1B[32m[#]\x1B[0m    \x1B[4m${sourceDir}\x1B[0m already exists; Skip cloning`,
      );
      console.log(
        `    \x1B[34minfo:\x1B[0m  You can use --force to ignore clone cache`,
      );
    } catch {
      console.log(
        `    \x1B[34m[i]\x1B[0m    Cloning napkin source code into \x1B[4m${sourceDir}\x1B[0m`,
      );
      await fs.rm(sourceDir, { recursive: true, force: true });
      await fs.mkdir(sourceDir, { recursive: true });
      $(`git init`, { cwd: sourceDir });
      $(`git remote add origin https://github.com/vEnhance/napkin.git`, {
        cwd: sourceDir,
      });
      $(`git fetch --depth 1 origin ${hash}`, { cwd: sourceDir });
      $(`git checkout FETCH_HEAD`, { cwd: sourceDir });
    }
    let command;
    try {
      $(`dockera --version`, { silent: true });
      command = 'docker';
    } catch {
      try {
        $(`podman --version`, { silent: true });
        command = 'podman';
      } catch {
        console.log(
          `    \x1B[31m[!]\x1B[0m    You must install either \x1B[4mdocker\x1B[0m or \x1B[4mpodman\x1B[0m`,
        );
        process.exit(1);
      }
    }
    console.log(
      `    \x1B[34m[i]\x1B[0m    Build the Napkin using ${command}...`,
    );
    await fs.cp(
      `.x/Dockerfile.builder`,
      path.join(targetDir, 'Dockerfile.builder'),
    );
    const containerTag = `napkin-builder:${hash}`;
    $(`${command} build -f ./Dockerfile.builder -t ${containerTag}`, {
      cwd: targetDir,
    });
    const container = $(`${command} create ${containerTag}`, {
      requireValue: true,
    }).trim();
    $(`podman cp "${container}:/output" "./output"`, { cwd: targetDir });
    $(`podman rm ${container}`);
    console.log(
      `    \x1B[34m[i]\x1B[0m    Successfully built \x1B[4m${path.join(
        targetDir,
        'output/Napkin.pdf',
      )}\x1B[0m`,
    );
  },
  async download() {
    await fs.mkdir(`.x/napkin`, { recursive: true });
    $(
      'curl https://venhance.github.io/napkin/Napkin.pdf --output .x/napkin/draft.pdf',
    );
  },
  async list() {
    try {
      await fs.access('.x/napkin/draft.pdf');
      console.log(`    \x1B[32m○\x1B[0m  .x/napkin/draft.pdf`);
    } catch {}
    for await (const entry of fs.glob(
      '.x/napkin/snapshots/**/output/Napkin.pdf',
    )) {
      console.log(`    \x1B[32m○\x1B[0m  ${entry}`);
    }
  },
  async register(handle) {
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
      $(`curl https://api.github.com/users/${handle}`, {
        requireValue: true,
      }),
    );

    const targetDir = `template/assets/challengers/${handle.toLowerCase()}`;
    await fs.mkdir(targetDir, { recursive: true });
    const avatarMime = (await fetch(response.avatar_url)).headers.get(
      'Content-Type',
    );
    const avatarFormat = avatarMime.replace(/^image\//, '');
    const avatarFilename = `avatar.${avatarFormat}`;
    $(`curl ${response.avatar_url} --output ${avatarFilename}`, {
      cwd: targetDir,
    });
    await fs.writeFile(
      path.join(targetDir, 'metadata.json'),
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
      ),
      { encoding: 'utf-8' },
    );
    console.log(
      `    \x1B[34m[i]\x1B[0m    Successfully wrote metadata for \x1B[4m${response.login}\x1B[0m`,
    );
    console.log(
      `    \x1B[34m[i]\x1B[0m    Update \x1B[4mtemplate/napkin-challengers.typ\x1B[0m...`,
    );
    const wholeChallengers = await Array.fromAsync(
      fs.glob('*/', { cwd: 'template/assets/challengers' }),
    );
    await fs.writeFile(
      `template/napkin-challengers.typ`,
      `
      | #let challengers = (
      ${wholeChallengers
        .toSorted((a, b) => a.localeCompare(b))
        .map((challenger) =>
          [
            `|   ${JSON.stringify(challenger)}: {`,
            `|     let metadata = json(${JSON.stringify(
              `./assets/challengers/${challenger}/metadata.json`,
            )})`,
            `|     let avatar = read(metadata.avatar.path, encoding: none)`,
            `|     (..metadata, avatar: (source: avatar, format: metadata.avatar.format))`,
            `|   },`,
          ].join('\n'),
        )
        .join('\n')}
      | )
      `
        .trim()
        .split('\n')
        .map((x) => x.trimStart().replace(/^\| /, ''))
        .join('\n'),
      { encoding: 'utf-8' },
    );
  },
};

if (values.help) {
  commands.help();
  process.exit(0);
}
if (values.version) {
  commands.version();
  process.exit(0);
}

switch (positionals[0]) {
  case undefined:
  case 'help':
    await commands.help();
    break;
  case 'build':
    await commands.build(positionals[1], values);
    break;
  case 'download':
    await commands.download();
    break;
  case 'list':
    await commands.list();
    break;
  case 'register':
    await commands.register(positionals[1]);
    break;
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
 * @returns {string}
 */
function $(command, { cwd, silent = false, requireValue = false } = {}) {
  if (!silent) {
    console.log(`    \x1B[33m[$]\x1B[0m    ${command}`);
  }
  return execSync(command, {
    cwd,
    stdio: requireValue ? 'pipe' : silent ? 'ignore' : 'inherit',
    encoding: 'utf-8',
  });
}
