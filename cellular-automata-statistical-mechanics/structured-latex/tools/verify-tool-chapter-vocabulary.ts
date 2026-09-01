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
  "Lorentz",
  "ローレンツ",
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
  "lorentz",
];

/**
 * CA 章で既存物理由来語を持ってよいブロック（＝既存理論との照合の所有者）の宣言。
 *
 * 既存物理由来語の検査は数学的道具立て章にしか掛かっておらず、CA 章の内部は無制約だった。
 * ところがマニフェストは「物理的意味を局所規則へ入れない」「対応は後から写像として書く」を要求する。
 * 無制約のままだと、照合節の所有物である既存物理の語が、CA 章の定義・主張・証明へ後から染み出しても
 * 検査は 0 件で通る。CA 章の内部にも同じ境界を課し、照合を持つブロックだけを宣言で許す。
 *
 * 宣言は fail-closed に扱う。ここに挙げた id が実在しない、CA 章に無い、あるいは既存物理由来語を
 * 一つも持たなくなった場合も違反にする（役目を終えた宣言が許可だけ残るのを防ぐ）。
 */
const PHYSICS_COMPARISON_BLOCK_IDS = [
  "causal_set_primary_literature_remark_not_claimed",
  "causal_set_primary_literature_remark_source",
];

/**
 * CA 章で既存物理由来語を識別子へ持ってよいブロックの族（id の接頭辞）と、
 * その族が実際に必要とする語の宣言。
 *
 * 既存物理由来語は本文の軸と識別子の軸の二本で対称に止める設計だが、識別子の軸は
 * 数学的道具立て章にしか掛かっておらず、CA 章の識別子は無制約だった。本文の軸は
 * CA 章の内部でも照合ブロックだけを許すのに、識別子の軸では照合と無関係な節のブロックへ
 * `quantum` などを入れても 0 件で通る。同じ境界を識別子にも課す。
 *
 * 族で宣言するのは、照合の所有者が `causal_structure_comparison_` と
 * `causal_set_primary_literature_` の二つの原本ファイルに対応しており、そこに属するブロックの
 * id とラベルが `causal` を持つためである。接頭辞だけを許可すると、同じ識別子へ `quantum` や
 * `hilbert` を足しても通るので、許す語も `causal` に限定する。宣言は fail-closed に扱い、
 * **許可語を一語ずつ**検査する（下の検査を参照）。既存物理由来語でない語、および族の識別子が
 * 実際には使っていない語を許可することも違反にする。
 */
const PHYSICS_COMPARISON_IDENTIFIER_FAMILIES = new Map<string, readonly string[]>([
  ["causal_structure_comparison_", ["causal"]],
  ["causal_set_primary_literature_", ["causal"]],
]);

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

/**
 * 既存物理由来語の照合は大文字小文字を区別しない。
 *
 * `PHYSICS_TERMS` には日本語の語に混じってラテン文字の語（`Lorentz`）が入っている。
 * 区別したままだと、同じ概念を `lorentz` や `LORENTZ` と綴った瞬間に検査が空振りする。
 * 日本語の語は `toLowerCase` で変わらないため、この正規化で失われる識別力はない。
 */
function physicsTermsIn(block: unknown): string[] {
  const text = normalizedTextOf(block).toLowerCase();
  return PHYSICS_TERMS.filter((term) => text.includes(term.toLowerCase()));
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
/** CA 章のブロック id → それを含む節 id。照合の所在を節まで特定するために引く。 */
const caSectionOfBlock = new Map<string, string>();
for (const file of files) {
  const inTools = file.file.startsWith(TOOL_CHAPTER_PREFIX);
  const inCa = file.file.startsWith(CA_CHAPTER_PREFIX);
  for (const block of file.blocks) {
    if (block.kind === "heading" || block.id.startsWith("organization_")) continue;
    if (inTools) toolBlockIds.add(block.id);
    else if (inCa) {
      caBlockIds.add(block.id);
      caSectionOfBlock.set(block.id, file.file.slice(CA_CHAPTER_PREFIX.length));
    } else unclassifiedBlockIds.add(block.id);
  }
}
/** 照合を許した節。CA 章の節の記述に既存物理由来語を認めるのは、この節だけ。 */
const caComparisonSections = new Set<string>();
for (const blockId of PHYSICS_COMPARISON_BLOCK_IDS) {
  const section = caSectionOfBlock.get(blockId);
  if (section !== undefined) caComparisonSections.add(section);
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
    if (inCa) {
      const bodyPhysicsHits = physicsTermsIn(block);
      const allowed = PHYSICS_COMPARISON_BLOCK_IDS.includes(block.id);
      if (bodyPhysicsHits.length > 0 && !allowed) {
        violations.push(
          `CA 章の照合以外の本文に既存物理由来語がある: ${block.id}（${bodyPhysicsHits.join("、")}）`,
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


/** 照合宣言そのものの検査。許可だけが残って空振りするのを防ぐため fail-closed に扱う。 */
const blockById = new Map<string, unknown>();
for (const file of files) {
  for (const block of file.blocks) blockById.set(block.id, block);
}
for (const blockId of PHYSICS_COMPARISON_BLOCK_IDS) {
  const block = blockById.get(blockId);
  if (block === undefined) {
    violations.push(`照合として宣言したブロックが本文に無い: ${blockId}`);
    continue;
  }
  if (!caBlockIds.has(blockId)) {
    violations.push(`照合として宣言したブロックが CA 章に無い: ${blockId}`);
    continue;
  }
  if (physicsTermsIn(block).length === 0) {
    violations.push(`照合として宣言したブロックに既存物理由来語が無い: ${blockId}`);
  }
}

/** 識別子側の検査。本文の語彙とは独立に、機械識別子へ CA 語が新たに入るのを止める。 */
const identifierViolations: string[] = [];
const comparisonPrefixOwners = new Map<string, string[]>(
  [...PHYSICS_COMPARISON_IDENTIFIER_FAMILIES.keys()].map((prefix) => [prefix, []]),
);
for (const file of files) {
  const inTools = file.file.startsWith(TOOL_CHAPTER_PREFIX);
  const inCa = file.file.startsWith(CA_CHAPTER_PREFIX);
  if (!inTools && !inCa) continue;
  for (const block of file.blocks) {
    if (block.kind === "heading" || block.id.startsWith("organization_")) continue;
    const identifiers = [
      { key: `id:${block.id}`, value: block.id },
      ...block.labels.map((label) => ({ key: `label:${label}`, value: label })),
    ];
    // CA 由来語は CA 章の識別子では当然のものなので、数学的道具立て章にだけ掛ける。
    // 既存物理由来語は両章で止め、CA 章では照合として宣言した族だけを許す。
    const comparisonPrefix = inCa
      ? [...PHYSICS_COMPARISON_IDENTIFIER_FAMILIES.keys()].find((prefix) => block.id.startsWith(prefix))
      : undefined;
    if (comparisonPrefix !== undefined) comparisonPrefixOwners.get(comparisonPrefix)?.push(block.id);
    for (const identifier of identifiers) {
      if (inTools) {
        const caHits = CA_IDENTIFIER_TERMS.filter((term) => identifier.value.includes(term));
        if (caHits.length > 0) {
          identifierViolations.push(
            `数学的道具立て章の識別子に CA 由来語が新たに入った: ${identifier.key}` +
              `（所有ブロック ${block.id}、${caHits.join("、")}）`,
          );
        }
      }
      const physicsHits = PHYSICS_IDENTIFIER_TERMS.filter((term) => identifier.value.includes(term));
      if (physicsHits.length === 0) continue;
      if (inTools) {
        identifierViolations.push(
          `数学的道具立て章の識別子に既存物理由来語が入っている: ${identifier.key}` +
            `（所有ブロック ${block.id}、${physicsHits.join("、")}）`,
        );
        continue;
      }
      if (comparisonPrefix === undefined) {
        identifierViolations.push(
          `CA 章の照合以外の識別子に既存物理由来語がある: ${identifier.key}` +
            `（所有ブロック ${block.id}、${physicsHits.join("、")}）`,
        );
        continue;
      }
      const allowedPhysicsTerms = PHYSICS_COMPARISON_IDENTIFIER_FAMILIES.get(comparisonPrefix) ?? [];
      const unexpectedPhysicsHits = physicsHits.filter((term) => !allowedPhysicsTerms.includes(term));
      if (unexpectedPhysicsHits.length > 0) {
        identifierViolations.push(
          `照合として宣言した族の識別子に未許可の既存物理由来語がある: ${identifier.key}` +
            `（所有ブロック ${block.id}、${unexpectedPhysicsHits.join("、")}）`,
        );
      }
      const section = caSectionOfBlock.get(block.id);
      if (section === undefined || !caComparisonSections.has(section)) {
        identifierViolations.push(
          `照合として宣言した族の識別子が照合節の外にある: ${identifier.key}` +
            `（所有ブロック ${block.id}、節 ${section ?? "不明"}）`,
        );
      }
    }
  }
}
/** 照合族の宣言そのものの検査。役目を終えた許可が残って空振りするのを防ぐため fail-closed に扱う。 */
for (const [prefix, owners] of comparisonPrefixOwners) {
  if (owners.length === 0) {
    identifierViolations.push(`照合として宣言した識別子の族に属するブロックが CA 章に無い: ${prefix}`);
    continue;
  }
  const allowedPhysicsTerms = PHYSICS_COMPARISON_IDENTIFIER_FAMILIES.get(prefix) ?? [];
  if (allowedPhysicsTerms.length === 0) {
    identifierViolations.push(`照合として宣言した識別子の族に許可語が一つも無い: ${prefix}`);
    continue;
  }
  // 許可語は一語ずつ検査する。族の中で一語でも使われていれば宣言全体を通す作りにすると、
  // 実際には使っていない語（`quantum` など）を同じ宣言へ足すだけで許可が広がり、
  // 族の識別子へその語を書けてしまう。許可は「いま実在する語」だけに閉じる。
  const familyIdentifierValues = owners.flatMap((blockId) => {
    const block = files.flatMap((file) => file.blocks).find((candidate) => candidate.id === blockId);
    if (block === undefined || block.kind === "heading") return [];
    return [blockId, ...block.labels];
  });
  for (const term of allowedPhysicsTerms) {
    if (!PHYSICS_IDENTIFIER_TERMS.includes(term)) {
      identifierViolations.push(
        `照合として宣言した識別子の族が既存物理由来語でない語を許可している: ${prefix}（${term}）`,
      );
      continue;
    }
    if (!familyIdentifierValues.some((value) => value.includes(term))) {
      identifierViolations.push(
        `照合として宣言した識別子の族が使っていない語を許可している: ${prefix}（${term}）`,
      );
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
    if (inCa) {
      // 節の入力・出力・主定理は出版本文に出る。既存物理の語を書いてよいのは、
      // 照合ブロックを実際に持つ節だけに限る（照合を持たない節が物理を語り始めるのを止める）。
      const sectionPhysicsHits = physicsTermsIn([section.title, section.input, section.output, section.main]);
      if (sectionPhysicsHits.length > 0 && !caComparisonSections.has(String(section.id))) {
        organizationViolations.push(
          `照合を持たない CA 章の節の記述に既存物理由来語がある: ${chapterId}/${section.id}（${sectionPhysicsHits.join("、")}）`,
        );
      }
    }
    if (inCa) {
      // 現在の照合節の id は CA 内在的な依存順序を表し、既存物理由来語を必要としない。
      // 照合節であることだけを理由に任意の物理語を許すと、quantum 等への先取りを止められない。
      const sectionPhysicsIdentifierHits = PHYSICS_IDENTIFIER_TERMS.filter((term) =>
        String(section.id).includes(term),
      );
      if (sectionPhysicsIdentifierHits.length > 0) {
        organizationViolations.push(
          `CA 章の節の識別子に既存物理由来語がある: section:${section.id}` +
            `（${sectionPhysicsIdentifierHits.join("、")}）`,
        );
      }
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
    `CA 章の照合ブロック ${PHYSICS_COMPARISON_BLOCK_IDS.length} 件・照合節 ${caComparisonSections.size} 件・` +
    `照合識別子の族 ${PHYSICS_COMPARISON_IDENTIFIER_FAMILIES.size} 件、` +
    "CA 章の照合以外の本文の既存物理由来語 0 件・照合以外の識別子の既存物理由来語 0 件、" +
    `章タイトル・節の記述・章節識別子の違反 0 件 / 章 ${documentOrganization.length} 件・` +
    `節 ${documentOrganization.reduce((sum, chapter) => sum + chapter.sections.length, 0)} 件）`,
);
