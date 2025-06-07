import {
  type CompileDocArgs,
  NodeCompiler,
} from '@myriaddreamin/typst-ts-node-compiler';
import { load } from 'cheerio';

// Heavily taken from: https://github.com/OverflowCat/astro-typst/blob/master/src/lib/typst.ts

let compilerIns: NodeCompiler | undefined;

function initCompiler(): NodeCompiler {
  return NodeCompiler.create({
    workspace: '../',
    fontArgs: [{ fontPaths: ['../fonts'] }],
  });
}

function getOrInitCompiler(): NodeCompiler {
  return (compilerIns ||= initCompiler());
}

/**
 * @param source The source code of the .typ file.
 * @returns The SVG string.
 */
export async function readMetadata(source: string) {
  const $typst = getOrInitCompiler();

  const skipFromBuild: Array<{ value: boolean }> = $typst.query(
    { mainFileContent: source },
    { selector: '<skip-from-build>' },
  );
  return {
    skipFromBuild:
      skipFromBuild.length > 0 && skipFromBuild.every(({ value }) => value),
  };
}

/**
 * @param source The source code of the .typ file.
 * @returns The SVG string.
 */
export async function renderToSVGString(source: string) {
  const $typst = getOrInitCompiler();
  const svg = await renderToSVGString_($typst, { mainFileContent: source });
  $typst.evictCache(60);
  let $ = load(svg, {
    xml: true,
  });
  $('svg').attr('width', null);
  $('svg').attr('height', null);

  const svgString = $.html();

  return { svg: svgString };
}

async function renderToSVGString_(
  $typst: NodeCompiler,
  source: CompileDocArgs,
): Promise<string> {
  const docRes = $typst.compile(source);
  if (!docRes.result) {
    docRes.printDiagnostics();
    return '';
  }
  const doc = docRes.result;
  const svg = $typst.svg(doc);
  return svg;
}
