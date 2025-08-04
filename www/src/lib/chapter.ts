import { getCollection } from 'astro:content';
import { uniqBy } from 'es-toolkit';
import path from 'node:path';
import { readMetadata } from './typst';
import { naturalCompare } from './numberCompare';

export async function getChapters() {
  const exercises = await getCollection('exercises');
  const aFewHarderProblems = await getCollection('aFewHarderProblems');

  return uniqBy(
    [
      ...exercises.map(({ filePath }) => {
        const chapterId = Number(
          /([0-9]+)(?:\.(?:[0-9]+))+\.typ/.exec(path.basename(filePath))[1],
        );
        return {
          id: chapterId,
          order: chapterId,
        };
      }),
      ...aFewHarderProblems.map(({ filePath }) => {
        const chapterId = Number(
          /([0-9]+)[a-zA-Z]+\.typ/.exec(path.basename(filePath))[1],
        );
        return {
          id: chapterId,
          order: chapterId,
        };
      }),
      { id: 'Le14', order: 69 },
      { id: 'Hatcher', order: 72 },
    ],
    (chap) => chap.order,
  ).toSorted((a, b) => a.order - b.order);
}

export function getChapterName(id: number | string) {
  if (id === 'Le14') {
    return 'Le14';
  } else if (id === 'Hatcher') {
    return 'Hatcher';
  } else {
    return `Ch. ${id}`;
  }
}

export async function getChapterContents(id: number | string) {
  if (id === 'Le14') {
    const respect = await getCollection('le14');
    return respect.map((content) => ({
      ...content,
      id: path
        .parse(content.filePath)
        .name.replace(/^Le14-/, '')
        .replaceAll(/\./g, '-'),
      display: path.parse(content.filePath).name.replace(/^Le14-/, ''),
    })).toSorted(({ id: a }, { id: b }) => naturalCompare(a, b));
  }

  if (id === 'Hatcher') {
    const hatcher = await getCollection('hatcher');
    return hatcher.map((content) => ({
      ...content,
      id: path
        .parse(content.filePath)
        .name.replace(/^Hatcher-/, '')
        .replaceAll(/\./g, '-'),
      display: path.parse(content.filePath).name.replace(/^Hatcher-/, ''),
    })).toSorted(({ id: a }, { id: b }) => naturalCompare(a, b));
  }


  const exercises = await getCollection('exercises');
  const aFewHarderProblems = await getCollection('aFewHarderProblems');

  const exercisesOrdered = (
    await Promise.all(
      exercises.map(async (content) => ({
        ...content,
        metadata: await readMetadata(content.body),
      })),
    )
  )
    .filter(({ filePath, metadata }) => {
      const chapterId = /([0-9]+)(?:\.(?:[0-9]+))+\.typ/.exec(
        path.basename(filePath),
      )[1];
      return id.toString() === chapterId && !metadata.skipFromBuild;
    })
    .toSorted(({ filePath: a }, { filePath: b }) => naturalCompare(a, b));
  const problemsOrdered = aFewHarderProblems
    .filter(({ filePath }) => {
      const chapterId = /([0-9]+)[a-zA-Z]+\.typ/.exec(
        path.basename(filePath),
      )[1];

      return id.toString() === chapterId;
    })
    .toSorted(({ filePath: a }, { filePath: b }) => naturalCompare(a, b));

  return [
    ...exercisesOrdered.map((content) => ({
      ...content,
      id: path.parse(content.filePath).name.replaceAll(/\./g, '-'),
      display: path.parse(content.filePath).name,
    })),
    ...problemsOrdered.map((content) => ({
      ...content,
      id: `problem-${path.parse(content.filePath).name.toLowerCase()}`,
      display: `Problem ${path.parse(content.filePath).name}`,
    })),
  ];
}
