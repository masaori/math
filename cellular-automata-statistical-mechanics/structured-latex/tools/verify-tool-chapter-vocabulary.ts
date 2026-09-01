/**
 * 「数学的道具立て」章に 2 値セルオートマトン固有の語が混入していないかを字句で検査する。
 *
 * content-modules.ts の検査は参照依存だけを見るため、CA 固有の語を直接書いたブロックが
 * 数学的道具側に置かれていても通ってしまう。分類境界のレビューを人手の一巡で終わらせず、
 * 以後の追加でも自動的に効かせるためにここで語彙側から検査する。
 *
 * 除外語は「CA を仮定せずに定義済みである語」に限る。増やすときは、その語が
 * 有限集合・写像・関係だけで定義されていることを本文で確認してから足すこと。
 */
import { collectRefTargets, loadContentFiles } from "./content-modules.ts";
import { documentOrganization } from "./document-organization.ts";

const CA_TERMS = [
  "セルオートマトン",
  "舞台",
  "セル",
  "局所規則",
  "局所表現",
  "真理値表",
  "大域写像",
  "時間発展",
  "時刻",
  "配位",
  "一点反転",
  "伝播",
  "イベント",
  "状態集合",
  "2 値",
  "二値",
];

/** CA を仮定せずに定義された語。字句検査の前に取り除く。 */
const NEUTRAL_PHRASES = [
  "近傍割り当て", // 有限集合上の集合値写像として定義しており、CA の近傍を仮定しない
  "周期の伝播", // 有限自己写像の周期が反復で保たれることを指し、空間的伝播ではない
];

/**
 * 本文側の既存物理由来語。数学的道具立て章は「2 値 CA を仮定せずに述べられるもの」であり、
 * 既存物理との比較は CA 章の照合節だけが持つ。ところが物理由来語の検査は識別子だけに掛かっており、
 * **読者が実際に読む散文**には一件も掛かっていなかった。CA 固有語は散文と識別子の両方を見るのに、
 * 物理由来語は識別子しか見ないという非対称は、比較章の所有物である文（「物理的な意味を要求しない」等）が
 * 数学的道具立て章の定義の中に残ることを許す。同じ境界を散文にも課す。
 *
 * 「否定形なら安全」とはしない。物理の語をどう扱うかを述べること自体が比較章の役目であり、
 * 数学的道具立て章の定義・主張・証明はその語に言及する必要がない。
 *
 * 一般数学で常用され、物理を先取りしない語（場・作用素・体・空間など）は含めない。
 */
const PHYSICS_TERMS = [
  "物理",
  "因果集合",
  "時空",
  "光円錐",
  "量子",
  "ヒルベルト",
  "多様体",
  "相対論",
  "粒子",
  "場の量子論",
  "作用素代数",
];

/**
 * 識別子側の CA 由来語。block id と label は出版本文に出ないが、整理前のファイル名を
 * 引き継いでいるため「章の分類を id から読むと誤読する」状態が残っている。
 * 本文（散文・数式）の語彙検査とは独立の軸なので、ここで別に検査する。
 */
const CA_IDENTIFIER_TERMS = [
  "automaton",
  "cellular",
  "cell_",
  "_cell",
  "binary",
  "truth_table",
  "global_map",
  "configuration",
  "flip",
  "time_",
  "_time",
  "propagation",
  "event",
  "state_set",
  "local_",
  "stage",
];

/**
 * 識別子側の既存物理由来語。数学的道具立て章は「2 値 CA を仮定せずに述べられるもの」だが、
 * 既存物理の名前を機械識別子へ残すと、章の分類を id から読んだときに比較章の所有物だと誤読する。
 * CA 由来語と同じ性質の欠陥なので、同じ軸で無条件に止める。
 * 一般数学の語と衝突しないもの（作用素・体・場のように数学側で常用される語を含めない）に限る。
 */
const PHYSICS_IDENTIFIER_TERMS = [
  "causal",
  "spacetime",
  "lightcone",
  "quantum",
  "hilbert",
  "manifold",
  "relativity",
  "particle",
  "physical",
];

const TOOL_CHAPTER_PREFIX = "organization/mathematical_tools/";
const CA_CHAPTER_PREFIX = "organization/binary_cellular_automaton_semantics/";

function collectText(node: unknown, out: string[]): void {
  if (typeof node === "string") {
    out.push(node);
    return;
  }
  if (node === null || typeof node !== "object") return;
  if (Array.isArray(node)) {
    for (const item of node) collectText(item, out);
    return;
  }
  for (const value of Object.values(node as Record<string, unknown>)) collectText(value, out);
}

function normalizedTextOf(block: unknown): string {
  const parts: string[] = [];
  collectText(block, parts);
  let text = parts.join(" ");
  for (const phrase of NEUTRAL_PHRASES) text = text.split(phrase).join(" ");
  return text;
}

function caTermsIn(block: unknown): string[] {
  const text = normalizedTextOf(block);
  return CA_TERMS.filter((term) => text.includes(term));
}

function physicsTermsIn(block: unknown): string[] {
  const text = normalizedTextOf(block);
  return PHYSICS_TERMS.filter((term) => text.includes(term));
}

const files = await loadContentFiles();

/** ラベル → 所有ブロック id。CA 章側の根拠を参照経由でも認めるために引く。 */
const labelOwner = new Map<string, string>();
for (const file of files) {
  for (const block of file.blocks) {
    if (block.kind === "heading") continue;
    for (const label of block.labels) labelOwner.set(label, block.id);
  }
}

const toolBlockIds = new Set<string>();
const caBlockIds = new Set<string>();
const unclassifiedBlockIds = new Set<string>();
for (const file of files) {
  const inTools = file.file.startsWith(TOOL_CHAPTER_PREFIX);
  const inCa = file.file.startsWith(CA_CHAPTER_PREFIX);
  for (const block of file.blocks) {
    if (block.kind === "heading" || block.id.startsWith("organization_")) continue;
    if (inTools) toolBlockIds.add(block.id);
    else if (inCa) caBlockIds.add(block.id);
    else unclassifiedBlockIds.add(block.id);
  }
}

const violations: string[] = [];
if (toolBlockIds.size === 0) {
  violations.push("数学的道具立て章の走査対象が 0 件である");
}
if (caBlockIds.size === 0) {
  violations.push("2 値セルオートマトンのセマンティクス章の走査対象が 0 件である");
}
if (unclassifiedBlockIds.size > 0) {
  violations.push(
    `二章のどちらにも属さない走査対象がある: ${[...unclassifiedBlockIds].sort().join(", ")}`,
  );
}
for (const file of files) {
  const inTools = file.file.startsWith(TOOL_CHAPTER_PREFIX);
  const inCa = file.file.startsWith(CA_CHAPTER_PREFIX);
  if (!inTools && !inCa) continue;
  for (const block of file.blocks) {
    if (block.kind === "heading" || block.id.startsWith("organization_")) continue;
    const hits = caTermsIn(block);
    if (inTools) {
      const bodyPhysicsHits = physicsTermsIn(block);
      if (bodyPhysicsHits.length > 0) {
        violations.push(
          `数学的道具立て章の本文に既存物理由来語がある: ${block.id}（${bodyPhysicsHits.join("、")}）`,
        );
      }
    }
    if (inTools && hits.length > 0) {
      violations.push(`数学的道具立て章に CA 固有語がある: ${block.id}（${hits.join("、")}）`);
      continue;
    }
    if (!inCa || hits.length > 0) continue;
    // CA 章にあるのに CA 固有語を持たないなら、CA 章のブロックを参照していることを根拠に要求する。
    const targets = new Set<string>();
    collectRefTargets(block, targets);
    const grounded = [...targets].some((label) => {
      const owner = labelOwner.get(label);
      return owner !== undefined && caBlockIds.has(owner) && owner !== block.id;
    });
    if (!grounded) {
      violations.push(`CA 章にあるが CA 固有語も CA 章への参照も持たない: ${block.id}`);
    }
  }
}


/** 識別子側の検査。本文の語彙とは独立に、機械識別子へ CA 語が新たに入るのを止める。 */
const identifierViolations: string[] = [];
for (const file of files) {
  if (!file.file.startsWith(TOOL_CHAPTER_PREFIX)) continue;
  for (const block of file.blocks) {
    if (block.kind === "heading" || block.id.startsWith("organization_")) continue;
    const identifiers = [
      { key: `id:${block.id}`, value: block.id },
      ...block.labels.map((label) => ({ key: `label:${label}`, value: label })),
    ];
    for (const identifier of identifiers) {
      const caHits = CA_IDENTIFIER_TERMS.filter((term) => identifier.value.includes(term));
      if (caHits.length > 0) {
        identifierViolations.push(
          `数学的道具立て章の識別子に CA 由来語が新たに入った: ${identifier.key}` +
            `（所有ブロック ${block.id}、${caHits.join("、")}）`,
        );
      }
      const physicsHits = PHYSICS_IDENTIFIER_TERMS.filter((term) => identifier.value.includes(term));
      if (physicsHits.length > 0) {
        identifierViolations.push(
          `数学的道具立て章の識別子に既存物理由来語が入っている: ${identifier.key}` +
            `（所有ブロック ${block.id}、${physicsHits.join("、")}）`,
        );
      }
    }
  }
}
violations.push(...identifierViolations);

/**
 * 節の設計そのものの検査。
 *
 * 上の二つの軸は content/ 由来のブロックだけを見ており、`organization_` で始まる生成ブロック
 * （節見出しと「この節の入力・出力・主定理」）を明示的に読み飛ばしている。その文面は
 * document-organization.ts の title / input / output / main に書かれ、**出版本文に現れる**のに、
 * どちらの軸からも原理的に一件も検出できない。数学的道具立て章の節の説明へ CA 固有語を書いても、
 * 章・節 id へ CA 由来語・既存物理由来語を置いても、検査を通ってしまう状態だった。
 * 章タイトルも生成された見出しとして出版本文に現れるため、本文ブロックと同じ境界を
 * 章タイトル・節の記述へ課す。
 */
const TOOL_CHAPTER_ID = "mathematical_tools";
const CA_CHAPTER_ID = "binary_cellular_automaton_semantics";

const organizationViolations: string[] = [];
for (const chapter of documentOrganization) {
  // 章 id は as const で literal 型になるため、比較で never へ潰れないよう string へ広げてから見る。
  const chapterId: string = chapter.id;
  const inTools = chapterId === TOOL_CHAPTER_ID;
  const inCa = chapterId === CA_CHAPTER_ID;
  if (!inTools && !inCa) {
    organizationViolations.push(`二章のどちらでもない章がある: ${chapterId}`);
    continue;
  }
  const chapterTitleHits = caTermsIn(chapter.title);
  if (inTools && chapterTitleHits.length > 0) {
    organizationViolations.push(
      `数学的道具立て章の章タイトルに CA 固有語がある: ${chapterId}（${chapterTitleHits.join("、")}）`,
    );
  }
  if (inCa && chapterTitleHits.length === 0) {
    organizationViolations.push(`CA 章の章タイトルに CA 固有語が無い: ${chapterId}`);
  }
  if (inTools) {
    const chapterTitlePhysicsHits = physicsTermsIn(chapter.title);
    if (chapterTitlePhysicsHits.length > 0) {
      organizationViolations.push(
        `数学的道具立て章の章タイトルに既存物理由来語がある: ${chapterId}（${chapterTitlePhysicsHits.join("、")}）`,
      );
    }
  }
  if (inTools) {
    const caHits = CA_IDENTIFIER_TERMS.filter((term) => chapterId.includes(term));
    if (caHits.length > 0) {
      organizationViolations.push(
        `数学的道具立て章の章識別子に CA 由来語がある: chapter:${chapterId}（${caHits.join("、")}）`,
      );
    }
    const physicsHits = PHYSICS_IDENTIFIER_TERMS.filter((term) => chapterId.includes(term));
    if (physicsHits.length > 0) {
      organizationViolations.push(
        `数学的道具立て章の章識別子に既存物理由来語がある: chapter:${chapterId}（${physicsHits.join("、")}）`,
      );
    }
  }
  for (const section of chapter.sections) {
    const hits = caTermsIn([section.title, section.input, section.output, section.main]);
    if (inTools && hits.length > 0) {
      organizationViolations.push(
        `数学的道具立て章の節の記述に CA 固有語がある: ${chapterId}/${section.id}（${hits.join("、")}）`,
      );
    }
    if (inTools) {
      const sectionPhysicsHits = physicsTermsIn([section.title, section.input, section.output, section.main]);
      if (sectionPhysicsHits.length > 0) {
        organizationViolations.push(
          `数学的道具立て章の節の記述に既存物理由来語がある: ${chapterId}/${section.id}（${sectionPhysicsHits.join("、")}）`,
        );
      }
    }
    if (inCa && hits.length === 0) {
      organizationViolations.push(
        `CA 章の節の記述に CA 固有語が無い: ${chapterId}/${section.id}`,
      );
    }
    if (!inTools) continue;
    for (const identifier of [{ key: `section:${section.id}`, value: String(section.id) }]) {
      const caHits = CA_IDENTIFIER_TERMS.filter((term) => identifier.value.includes(term));
      if (caHits.length > 0) {
        organizationViolations.push(
          `数学的道具立て章の節の識別子に CA 由来語がある: ${identifier.key}（${caHits.join("、")}）`,
        );
      }
      const physicsHits = PHYSICS_IDENTIFIER_TERMS.filter((term) => identifier.value.includes(term));
      if (physicsHits.length > 0) {
        organizationViolations.push(
          `数学的道具立て章の節の識別子に既存物理由来語がある: ${identifier.key}（${physicsHits.join("、")}）`,
        );
      }
    }
  }
}
violations.push(...organizationViolations);

if (violations.length > 0) {
  console.error("章の意味境界に違反がある:");
  for (const line of violations) console.error(`  ${line}`);
  process.exit(1);
}
console.log(
  `章の意味境界の語彙検査 OK（本文の CA 固有語 ${CA_TERMS.length} 件、` +
    `本文の既存物理由来語 ${PHYSICS_TERMS.length} 件、走査対象は数学的道具立て章 ${toolBlockIds.size} 件・` +
    `CA 章 ${caBlockIds.size} 件・未分類 ${unclassifiedBlockIds.size} 件、` +
    "数学的道具立て章に残る CA 由来識別子 0 件、既存物理由来識別子 0 件、本文の既存物理由来語 0 件、" +
    `章タイトル・節の記述・章節識別子の違反 0 件 / 章 ${documentOrganization.length} 件・` +
    `節 ${documentOrganization.reduce((sum, chapter) => sum + chapter.sections.length, 0)} 件）`,
);
