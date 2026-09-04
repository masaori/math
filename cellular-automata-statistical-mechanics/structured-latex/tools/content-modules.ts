/**
 * `content/` と `notes/` のモジュールを読み込む共通処理。
 *
 * ソース形式は **`.ts` に統一**する（書き方の種類を増やさない）。ファイル名昇順は
 * 原文を安定して読み込むためだけに使い、出版順は `document-organization.ts` を正本とする。
 * Node 22.18+ の型ストリップにより、`.ts` はビルドなしでそのまま import できる。
 * `.mjs` が残っていれば「型検査から漏れたファイル」なので、読まずにエラーで落とす。
 */

import { existsSync, readdirSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath, pathToFileURL } from "node:url";

import { paragraph, ref, type ConvertedBlock, type Label, type Note } from "../schema.ts";
import { blockSectionAssignments } from "./document-block-assignments.ts";
import { documentOrganization, type OrganizationSection } from "./document-organization.ts";

const here = dirname(fileURLToPath(import.meta.url));

/** structured-latex ディレクトリの絶対パス。 */
export const structuredLatexDir = join(here, "..");
export const contentDir = join(structuredLatexDir, "content");
export const notesDir = join(structuredLatexDir, "notes");

const isSourceFile = (fileName: string): boolean =>
  fileName.endsWith(".ts") && !fileName.endsWith(".d.ts");

/**
 * dir 直下のソースファイル名を安定したファイル名昇順で返す。
 * `.mjs` を見つけたら、型検査の網から漏れている証拠なのでエラーにする。
 */
export function listSourceFiles(dir: string): string[] {
  if (!existsSync(dir)) return [];
  const entries = readdirSync(dir);
  const legacy = entries.filter((fileName) => fileName.endsWith(".mjs"));
  if (legacy.length > 0) {
    throw new Error(
      `${dir} に .mjs が残っている: ${legacy.join(", ")}` +
        "（ソース形式は .ts に統一する。node tools/codemod-mjs-to-ts.ts --apply で変換する）",
    );
  }
  return entries.filter(isSourceFile).sort();
}

async function loadDefaultExport(dir: string, fileName: string): Promise<unknown> {
  const mod: { default?: unknown } = await import(pathToFileURL(join(dir, fileName)).href);
  return mod.default;
}

export type LoadedBlockFile = { file: string; blocks: ConvertedBlock[] };
export type LoadedNoteFile = { file: string; notes: Note[] };

/** ノード木の `ref` と数式文字列中の `\blkref{...}` の 2 経路から参照先ラベルを集める。 */
export function collectRefTargets(value: unknown, targets: Set<string>): void {
  if (Array.isArray(value)) {
    for (const item of value) collectRefTargets(item, targets);
    return;
  }
  if (typeof value === "string") {
    for (const match of value.matchAll(/\\blkref\{([^}]+)\}/g)) {
      if (match[1] !== undefined) targets.add(match[1]);
    }
    return;
  }
  if (value === null || typeof value !== "object") return;
  const record = value as Record<string, unknown>;
  if (record.type === "ref" && typeof record.target === "string") targets.add(record.target);
  for (const item of Object.values(record)) collectRefTargets(item, targets);
}

function topologicallySort(
  blocks: readonly ConvertedBlock[],
  labelOwner: ReadonlyMap<string, string>,
): ConvertedBlock[] {
  const byId = new Map(blocks.map((block) => [block.id, block]));
  const originalIndex = new Map(blocks.map((block, index) => [block.id, index]));
  const dependencies = new Map<string, Set<string>>();
  const dependents = new Map<string, Set<string>>();
  for (const block of blocks) {
    const refs = new Set<string>();
    collectRefTargets(block, refs);
    const local = new Set<string>();
    for (const target of refs) {
      const owner = labelOwner.get(target);
      if (owner !== undefined && byId.has(owner) && owner !== block.id) local.add(owner);
    }
    dependencies.set(block.id, local);
    for (const owner of local) {
      const next = dependents.get(owner) ?? new Set<string>();
      next.add(block.id);
      dependents.set(owner, next);
    }
  }
  const ready = blocks.filter((block) => dependencies.get(block.id)?.size === 0);
  ready.sort((a, b) => originalIndex.get(a.id)! - originalIndex.get(b.id)!);
  const sorted: ConvertedBlock[] = [];
  while (ready.length > 0) {
    const block = ready.shift()!;
    sorted.push(block);
    for (const dependent of dependents.get(block.id) ?? []) {
      const remaining = dependencies.get(dependent)!;
      remaining.delete(block.id);
      if (remaining.size === 0) {
        ready.push(byId.get(dependent)!);
        ready.sort((a, b) => originalIndex.get(a.id)! - originalIndex.get(b.id)!);
      }
    }
  }
  if (sorted.length !== blocks.length) {
    const unresolved = blocks.filter((block) => !sorted.some((item) => item.id === block.id));
    throw new Error(`本文ブロックの参照依存に循環がある: ${unresolved.map((block) => block.id).join(", ")}`);
  }
  return sorted;
}

function sectionIntro(
  chapterId: string,
  section: OrganizationSection,
): ConvertedBlock[] {
  return [
    {
      id: `organization_${chapterId}_${section.id}_heading`,
      kind: "heading",
      level: 2,
      title: { text: section.title },
      labels: [],
    },
    {
      id: `organization_${chapterId}_${section.id}_goal`,
      kind: "remark",
      title: { text: "この節の入力・出力・主定理" },
      labels: [],
      habitat: "none",
      statement: [
        paragraph([`入力: ${section.input}`]),
        paragraph([`出力: ${section.output}`]),
        paragraph([
          `${section.main} `,
          "参照: ",
          ...section.mainLabels.flatMap((label, index) => [
            ...(index === 0 ? [] : ["、"]),
            ref(label as Label),
          ]),
        ]),
      ],
    },
  ] as ConvertedBlock[];
}

/** content/ の全ファイルを文書順で読む。default export が配列でなければ落とす。 */
export async function loadContentFiles(): Promise<LoadedBlockFile[]> {
  const raw: LoadedBlockFile[] = [];
  for (const file of listSourceFiles(contentDir)) {
    const blocks = await loadDefaultExport(contentDir, file);
    if (!Array.isArray(blocks)) {
      throw new TypeError(`${file} default export must be an array`);
    }
    raw.push({ file, blocks: blocks as ConvertedBlock[] });
  }

  const blockMap = new Map<string, ConvertedBlock>();
  const labelOwner = new Map<string, string>();
  for (const { file, blocks } of raw) {
    for (const block of blocks) {
      // 章・節の見出しは document-organization.ts が正本であり、ここで組み立てる。
      // content/ 側に見出しを書くと出版物へは出ないので、黙って落とさずエラーにする。
      if (block.kind === "heading") {
        throw new Error(
          `content/${file} に見出しブロックがある: ${block.id}\n` +
            "  章・節の見出しは tools/document-organization.ts に書く（content/ の見出しは出版物へ出ない）。",
        );
      }
      blockMap.set(block.id, block);
      for (const label of block.labels) labelOwner.set(label, block.id);
    }
  }

  const assigned = new Map<string, { chapter: number; section: number }>();
  const out: LoadedBlockFile[] = [];
  // 「数学的道具が 2 値 CA セマンティクスへ依存してはならない」は章の**同一性**についての規律で、
  // 並び順についての規律ではない。ここを配列添字の 0 と 1 で書くと、章を並べ替えた瞬間に
  // 許される向き（CA → 数学的道具）を禁止しはじめ、禁止したい向き（数学的道具 → CA）が
  // 無検査になる。実測: 二章を入れ替えると `causal_set_primary_literature_remark_source ->
  // def_locally_finite_partial_order`（CA 章から数学的道具立て章への正当な参照）が
  // 「数学的道具が 2 値 CA セマンティクスへ依存している」として落ちた。
  // そこで両章を id で引き、どちらかが無ければその場で落とす。
  const chapterIndexById = new Map(
    documentOrganization.map((chapter, index) => [String(chapter.id), index]),
  );
  const toolChapterIndex = chapterIndexById.get("mathematical_tools");
  const caChapterIndex = chapterIndexById.get("binary_cellular_automaton_semantics");
  if (toolChapterIndex === undefined || caChapterIndex === undefined) {
    throw new Error(
      "章立てに数学的道具立て章と 2 値セルオートマトンのセマンティクス章の両方が無い: " +
        `${[...chapterIndexById.keys()].join(", ")}`,
    );
  }
  for (const [chapterIndex, chapter] of documentOrganization.entries()) {
    out.push({
      file: `organization/${chapter.id}`,
      blocks: [{
        id: `organization_${chapter.id}_heading`,
        kind: "heading",
        level: 1,
        title: { text: chapter.title },
        labels: [],
      }],
    });
    for (const [sectionIndex, section] of chapter.sections.entries()) {
      const normalizedSection: OrganizationSection = section;
      const selected = [...blockMap.values()].filter(
        (block) => blockSectionAssignments[block.id as keyof typeof blockSectionAssignments] === section.id,
      );
      for (const block of selected) {
        const previous = assigned.get(block.id);
        if (previous !== undefined) throw new Error(`本文ブロックが二重分類されている: ${block.id}`);
        assigned.set(block.id, { chapter: chapterIndex, section: sectionIndex });
      }
      for (const mainLabel of normalizedSection.mainLabels) {
        const mainOwner = labelOwner.get(mainLabel);
        if (mainOwner === undefined || !selected.some((block) => block.id === mainOwner)) {
          throw new Error(`節の主定理が節内に無い: ${section.id} -> ${mainLabel}`);
        }
      }
      out.push({
        file: `organization/${chapter.id}/${section.id}`,
        blocks: [...sectionIntro(chapter.id, normalizedSection), ...topologicallySort(selected, labelOwner)],
      });
    }
  }

  const unassigned = [...blockMap.keys()].filter((blockId) => !assigned.has(blockId));
  if (unassigned.length > 0) throw new Error(`二章へ分類されていない本文ブロック: ${unassigned.join(", ")}`);
  const unknown = Object.keys(blockSectionAssignments).filter((blockId) => !blockMap.has(blockId));
  if (unknown.length > 0) throw new Error(`章立てが存在しない block id を指す: ${unknown.join(", ")}`);

  for (const block of blockMap.values()) {
    const source = assigned.get(block.id)!;
    const refs = new Set<string>();
    collectRefTargets(block, refs);
    for (const target of refs) {
      const owner = labelOwner.get(target);
      if (owner === undefined) continue;
      const dependency = assigned.get(owner)!;
      if (source.chapter === toolChapterIndex && dependency.chapter === caChapterIndex) {
        throw new Error(`数学的道具が 2 値 CA セマンティクスへ依存している: ${block.id} -> ${target}`);
      }
      if (dependency.chapter > source.chapter ||
          (dependency.chapter === source.chapter && dependency.section > source.section)) {
        throw new Error(`章・節の順序が参照依存に反する: ${block.id} -> ${target}`);
      }
    }
  }
  return out;
}

/** notes/ の全ファイルを読む。ディレクトリが無ければ 0 件。 */
export async function loadNoteFiles(): Promise<LoadedNoteFile[]> {
  const out: LoadedNoteFile[] = [];
  for (const file of listSourceFiles(notesDir)) {
    const notes = await loadDefaultExport(notesDir, file);
    if (!Array.isArray(notes)) {
      throw new TypeError(`${file} default export must be an array`);
    }
    out.push({ file, notes: notes as Note[] });
  }
  return out;
}
