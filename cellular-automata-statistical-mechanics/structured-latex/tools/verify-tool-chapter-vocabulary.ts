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

/**
 * 語の対応表の一件。本文の軸で使う語と、識別子の軸で使う対応語をここで結ぶ。
 *
 * `identifiers` は複数を許す（同じ本文語が `cell_` と `_cell` のように複数の断片で現れる）。
 * 対応語を持たない場合は `null` と理由の宣言を必須にする。
 */
type TermCorrespondenceEntry = {
  readonly body: string;
  readonly identifiers: readonly string[] | null;
  readonly reasonWhenNoIdentifier?: string;
};

/**
 * 識別子の対応語として認める綴り。
 *
 * 本文の軸は大文字小文字を区別せずに照合するが、識別子の軸はリポジトリの小文字命名規約に
 * 合わせて区別したまま照合する。したがって対応語が小文字 snake_case でなければ識別子の軸は
 * 静かに空振りする。前後の下線は語境界を示す断片（`cell_` / `_cell`）として認める。
 */
const IDENTIFIER_TERM_PATTERN = /^_?[a-z][a-z0-9]*(?:_[a-z0-9]+)*_?$/;

/**
 * 対応表そのものの検査。片肺の宣言と、識別子の軸で空振りする綴りを起票時に止める。
 *
 * 本文の軸だけに語を足しても、対応語を大文字混じりで綴っても、検査は 0 件で通ってしまう。
 * どちらも「検査した」という記録だけが残り、実際には何も止めていない状態になる。
 */
function correspondenceTableViolations(
  tableName: string,
  entries: readonly TermCorrespondenceEntry[],
): string[] {
  const found: string[] = [];
  for (const entry of entries) {
    if (entry.body.trim().length === 0) {
      found.push(`${tableName}の対応表に空の本文語がある`);
      continue;
    }
    if (entry.identifiers === null) {
      if ((entry.reasonWhenNoIdentifier ?? "").trim().length === 0) {
        found.push(`${tableName}に識別子の対応語が無いのに理由が宣言されていない: ${entry.body}`);
      }
      continue;
    }
    if (entry.identifiers.length === 0) {
      found.push(`${tableName}の識別子の対応語が空である: ${entry.body}`);
      continue;
    }
    for (const identifier of entry.identifiers) {
      if (identifier.length === 0) {
        found.push(`${tableName}の識別子の対応語が空である: ${entry.body}`);
        continue;
      }
      if (!IDENTIFIER_TERM_PATTERN.test(identifier)) {
        found.push(
          `${tableName}の識別子の対応語が小文字 snake_case でない: ${entry.body}（${identifier}）`,
        );
      }
    }
  }
  return found;
}

/**
 * 2 値セルオートマトン固有語の対応表。**本文の軸と識別子の軸をここ一箇所から導出する。**
 *
 * CA 固有語も既存物理由来語と同じく、読者が読む散文（本文の軸）と、章の分類を id から読むときに
 * 効く機械識別子（識別子の軸）の二本で対称に止める。既存物理由来語では二つの軸を別々の配列で
 * 持っていたために片方だけへ語を足すと対称が静かに崩れ、対応表へ集約して塞いだ。CA 固有語には
 * 同じ形が残っており、実測で識別子の軸の語を `Automaton` と綴っても検査が 0 件で通ることを
 * 確認した（識別子は小文字なので一致せず、その語の識別子側の検査だけが静かに失われる）。
 * そこで CA 固有語も語の追加点を対応表の一箇所に閉じ、二つの軸をここから導出する。
 *
 * 識別子の対応語は接頭辞・接尾辞の断片でよい（`cell_` / `_cell` のように、一般英単語
 * `cellular` 以外の綴りへ巻き込まれないよう区切り文字を含める）。対応語を持たない語は
 * `identifiers: null` と持たない理由の宣言を必須にし、黙って片肺になることを不可能にする。
 */
const CA_TERM_CORRESPONDENCE: readonly TermCorrespondenceEntry[] = [
  { body: "セルオートマトン", identifiers: ["automaton", "cellular"] },
  { body: "舞台", identifiers: ["stage"] },
  { body: "セル", identifiers: ["cell_", "_cell"] },
  { body: "局所規則", identifiers: ["local_"] },
  { body: "局所表現", identifiers: ["local_"] },
  { body: "真理値表", identifiers: ["truth_table"] },
  { body: "大域写像", identifiers: ["global_map"] },
  { body: "時刻", identifiers: ["time_", "_time"] },
  { body: "配位", identifiers: ["configuration"] },
  { body: "一点反転", identifiers: ["flip"] },
  { body: "伝播", identifiers: ["propagation"] },
  { body: "イベント", identifiers: ["event"] },
  { body: "状態集合", identifiers: ["state_set"] },
  { body: "2 値", identifiers: ["binary"] },
  { body: "二値", identifiers: ["binary"] },
];

/** 本文側の CA 固有語。対応表から導出するので、ここへ直接足すことはできない。 */
const CA_TERMS = CA_TERM_CORRESPONDENCE.map((entry) => entry.body);

/** CA を仮定せずに定義された語。字句検査の前に取り除く。 */
const NEUTRAL_PHRASES = [
  "近傍割り当て", // 有限集合上の集合値写像として定義しており、CA の近傍を仮定しない
  "周期の伝播", // 有限自己写像の周期が反復で保たれることを指し、空間的伝播ではない
];

/**
 * 識別子側の CA 由来語。block id と label は出版本文に出ないが、整理前のファイル名を
 * 引き継いでいるため「章の分類を id から読むと誤読する」状態が残っている。
 * 本文（散文・数式）の語彙検査とは独立の軸なので、ここで別に検査する。
 */
const CA_IDENTIFIER_TERMS = [
  ...new Set(CA_TERM_CORRESPONDENCE.flatMap((entry) => entry.identifiers ?? [])),
];

/**
 * 既存物理由来語の対応表。**本文の軸と識別子の軸をここ一箇所から導出する。**
 *
 * 数学的道具立て章は「2 値 CA を仮定せずに述べられるもの」であり、既存物理との比較は
 * CA 章の照合節だけが持つ。この境界は、読者が読む散文（本文の軸）と、章の分類を id から
 * 読むときに効く機械識別子（識別子の軸）の二本で対称に止める設計になっている。
 *
 * ところが二つの軸を別々の配列で持っていたため、片方だけへ語を足すと対称が静かに崩れた。
 * 実際に `Lorentz` が本文の軸だけに入って識別子の軸を素通りする欠陥が起き、その場の一語を
 * 足して直したが、**次に足す語で同じことが起きる形は残っていた**。実測でも `作用素代数` が
 * 本文の軸だけにあり、`operator_algebra` を id へ書くと識別子の軸を素通りしていた。
 *
 * そこで語の追加点を対応表の一箇所に閉じ、二つの軸を導出する。識別子の対応語を持たない語は
 * `identifier: null` と持たない理由の宣言を必須にし、黙って片肺になることを不可能にする。
 *
 * 「否定形なら安全」とはしない。物理の語をどう扱うかを述べること自体が比較章の役目であり、
 * 数学的道具立て章の定義・主張・証明はその語に言及する必要がない。
 *
 * 一般数学で常用され、物理を先取りしない語（場・作用素・体・空間など）は含めない。
 * 識別子の対応語も一般数学の語と衝突しないものに限る（`作用素` 単独ではなく `作用素代数` に
 * 対して `operator_algebra` を対応させるのはこのためである）。
 */
const PHYSICS_TERM_CORRESPONDENCE: readonly TermCorrespondenceEntry[] = [
  { body: "物理", identifiers: ["physical"] },
  { body: "因果集合", identifiers: ["causal"] },
  { body: "時空", identifiers: ["spacetime"] },
  { body: "光円錐", identifiers: ["lightcone"] },
  { body: "量子", identifiers: ["quantum"] },
  { body: "ヒルベルト", identifiers: ["hilbert"] },
  { body: "多様体", identifiers: ["manifold"] },
  { body: "相対論", identifiers: ["relativity"] },
  { body: "粒子", identifiers: ["particle"] },
  { body: "場の量子論", identifiers: ["quantum"] },
  { body: "作用素代数", identifiers: ["operator_algebra"] },
  { body: "Lorentz", identifiers: ["lorentz"] },
  { body: "ローレンツ", identifiers: ["lorentz"] },
];

/** 本文側の既存物理由来語。対応表から導出するので、ここへ直接足すことはできない。 */
const PHYSICS_TERMS = PHYSICS_TERM_CORRESPONDENCE.map((entry) => entry.body);

/** 識別子側の既存物理由来語。対応表から導出する（同じ対応語を複数の本文語が指すので重複を除く）。 */
const PHYSICS_IDENTIFIER_TERMS = [
  ...new Set(PHYSICS_TERM_CORRESPONDENCE.flatMap((entry) => entry.identifiers ?? [])),
];

/** 二つの対応表を同じ規則で検査する。CA 固有語と既存物理由来語で規律が食い違わないようにする。 */
const correspondenceViolations: string[] = [
  ...correspondenceTableViolations("CA 固有語", CA_TERM_CORRESPONDENCE),
  ...correspondenceTableViolations("既存物理由来語", PHYSICS_TERM_CORRESPONDENCE),
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
violations.push(...correspondenceViolations);

/**
 * CA 対応語を CA 章の実識別子へ一語ずつ突き合わせる。
 *
 * 綴りだけを検査しても、`automaton` を有効な snake_case の `automata` へ変えると検査は成功し、
 * 実在する識別子の `automaton` だけが静かに無検査になる。対応語は将来用の予約語ではなく、
 * 現在の分類境界を二本の軸で検査するための語なので、実際に使われていない対応語を許さない。
 */
const caIdentifierValues = [
  ...files
    .filter((file) => file.file.startsWith(CA_CHAPTER_PREFIX))
    .flatMap((file) =>
      file.blocks.flatMap((block) =>
        block.kind === "heading" || block.id.startsWith("organization_")
          ? []
          : [block.id, ...block.labels],
      ),
    ),
  ...documentOrganization
    .filter((chapter) => String(chapter.id) === "binary_cellular_automaton_semantics")
    .flatMap((chapter) => [String(chapter.id), ...chapter.sections.map((section) => String(section.id))]),
];
for (const entry of CA_TERM_CORRESPONDENCE) {
  for (const identifier of entry.identifiers ?? []) {
    if (!caIdentifierValues.some((value) => value.includes(identifier))) {
      violations.push(
        `CA 固有語の識別子の対応語が CA 章の実識別子で使われていない: ${entry.body}（${identifier}）`,
      );
    }
  }
}

/**
 * CA 固有語の本文語を CA 章の実際の本文へ一語ずつ突き合わせる。
 *
 * 識別子の軸は前 tick で実識別子へ突き合わせるようにしたが、本文の軸には同じ穴が残っていた。
 * 実測で `大域写像`（CA 章の本文 35 箇所で使う語）を `大城写像` と綴り替えても検査は 0 件で通り、
 * 数学的道具立て章がその語を書けるようになることを確認した。綴り違いは本文の軸の役目を静かに
 * 消すのに、どの検査にも現れない。
 *
 * 実際 `時間発展` は本文にも節の記述にも一度も現れておらず、本文の軸で何も検査していなかった
 * （CA 章が時間の軸に使う語は `時刻` で、識別子の対応語 `time_` / `_time` も `時刻` が供給する）。
 * 対応表の語は将来のための予約語ではなく現在の分類境界を検査する語なので、この一件は削除した。
 * CA 章が新たにその語を使い始めた時点で対応表へ戻す。
 *
 * 既存物理由来語には同じ要求をしない。あちらは「本文に現れないこと」を要求する禁止語であり、
 * 使用箇所を要求すると規律が反転する。
 */
const caBodyCorpus: string[] = [];
for (const file of files) {
  if (!file.file.startsWith(CA_CHAPTER_PREFIX)) continue;
  for (const block of file.blocks) {
    if (block.kind === "heading" || block.id.startsWith("organization_")) continue;
    caBodyCorpus.push(normalizedTextOf(block));
  }
}
for (const chapter of documentOrganization) {
  if (String(chapter.id) !== "binary_cellular_automaton_semantics") continue;
  for (const section of chapter.sections) {
    caBodyCorpus.push(normalizedTextOf([section.title, section.input, section.output, section.main]));
  }
}
for (const entry of CA_TERM_CORRESPONDENCE) {
  if (!caBodyCorpus.some((text) => text.includes(entry.body))) {
    violations.push(`CA 固有語の本文語が CA 章の本文で使われていない: ${entry.body}`);
  }
}
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
  // 既存物理由来語の禁止は章タイトルでは両章に掛ける。
  //
  // 照合の所有は「ブロック」と「節」の粒度でしか宣言できない（PHYSICS_COMPARISON_BLOCK_IDS と、
  // そこから導く照合節）。章タイトルはそのどちらにも属さないので、照合の所有者になりようがない。
  // にもかかわらず CA 章のときだけ検査を掛けていなかったため、実測で章タイトルを
  // 「2 値セルオートマトンの量子的セマンティクスを持つもの」へ書き換えても検査は 0 件で通った。
  // 章タイトルは出版本文の最上位の見出しとして現れるので、宣言のないまま既存物理の語が
  // 章全体の名前に入ることになる。CA 章の節の記述には照合節だけを許す制限が既に掛かっており、
  // 章タイトルだけが無制約なのは同じ境界の片肺である。
  const chapterTitlePhysicsHits = physicsTermsIn(chapter.title);
  if (chapterTitlePhysicsHits.length > 0) {
    organizationViolations.push(
      `章タイトルに既存物理由来語がある: ${chapterId}（${chapterTitlePhysicsHits.join("、")}）`,
    );
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
  `章の意味境界の語彙検査 OK（本文の CA 固有語 ${CA_TERMS.length} 件` +
    `（識別子の対応語 ${CA_IDENTIFIER_TERMS.length} 件、対応表 ${CA_TERM_CORRESPONDENCE.length} 件）、` +
    `本文の既存物理由来語 ${PHYSICS_TERMS.length} 件（識別子の対応語 ${PHYSICS_IDENTIFIER_TERMS.length} 件、対応表 ${PHYSICS_TERM_CORRESPONDENCE.length} 件）、` +
    `走査対象は数学的道具立て章 ${toolBlockIds.size} 件・` +
    `CA 章 ${caBlockIds.size} 件・未分類 ${unclassifiedBlockIds.size} 件、` +
    "数学的道具立て章に残る CA 由来識別子 0 件、既存物理由来識別子 0 件、本文の既存物理由来語 0 件、" +
    `CA 章の照合ブロック ${PHYSICS_COMPARISON_BLOCK_IDS.length} 件・照合節 ${caComparisonSections.size} 件・` +
    `照合識別子の族 ${PHYSICS_COMPARISON_IDENTIFIER_FAMILIES.size} 件、` +
    "CA 章の照合以外の本文の既存物理由来語 0 件・照合以外の識別子の既存物理由来語 0 件、" +
    `章タイトル・節の記述・章節識別子の違反 0 件 / 章 ${documentOrganization.length} 件・` +
    `節 ${documentOrganization.reduce((sum, chapter) => sum + chapter.sections.length, 0)} 件）`,
);
