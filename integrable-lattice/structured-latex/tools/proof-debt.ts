/**
 * **検査 C の中身**（`verify-proof-completeness.ts` は入出力だけを持つ）。
 *
 * 動機（cycle 24 総括が「検査で守られていない負債」として明記したもの）:
 *
 * > 正直な限界: 本章は主張と限界だけで `proof` が空。原本の証明はまだ運んでいない。
 * > **転記検査は主張しか見ないので、この未了は赤にならない**（＝検査で守られていない負債である）。
 *
 * 転記検査（検査 A）は「根拠 report の条件文に出る記号・語が本文ブロックに出るか」を見る。
 * 主張だけを転記したブロックはこれを通る。**証明を運んだかどうかは、どの検査も見ていなかった。**
 *
 * ここで見るのは 1 つだけである。**証明を持つべきブロックが証明を持っているか。**
 *
 * ---
 *
 * ## 「証明を持つべき」の定義と、その根拠
 *
 * **定義: `kind` が `theorem` または `claim` のブロックは証明を持たなければならない。**
 *
 * 根拠は 3 つとも一次情報である。
 *
 * 1. **入力言語が持つ種別**はシステムの `THEOREM_LIKE_KINDS`＝
 *    `theorem` / `definition` / `claim` / `remark` / `note` の 5 つだけである
 *    （リポジトリ直下 structured-latex の domain-model/structured-text/block.ts）。
 *    このうち**証明されるべき事柄を述べるのは `theorem` と `claim` だけ**である。
 *    `definition` は定義（証明の対象ではない）、`remark` / `note` は注記である。
 * 2. **現在の本文がその境界どおりに書かれている**（実測）。定理型 34 ブロックのうち
 *    `proof` を持つ 16 ブロックは**すべて** `theorem` か `claim` であり、
 *    `definition` / `remark` の 18 ブロックは**1 つも** `proof` を持たない。
 *    つまりこの規則は新しい約束事ではなく、**すでに守られている区別を機械が読める形にしたもの**である。
 * 3. リポジトリ CLAUDE.md の命名規則が type を
 *    `definition, claim, theorem, remark, note, heading` と列挙し、
 *    「正しさに必要ならそれは注記ではない」＝主張は `statement`、証明中の事柄は `proof` と定めている。
 *
 * **この定義が捕まえないもの**（限界。§ report）:
 *   - `remark` の中に実質的な証明つきの主張を書いた場合。種別の付け方そのものは見ていない。
 *   - 証明の**中身**が正しいか。長さも内容も見ない（空でなければ通る）。
 *
 * ---
 *
 * ## 既知の未了は「宣言」で扱う。宣言が腐ったら赤くなる
 *
 * いま実際に証明を持たない `theorem` が 7 件ある。これをそのまま違反にすると
 * `npm run check` が落ちて他の作業が止まる。そこで cycle 24 step 3 が免除に対して採った方式に倣い、
 * **「既知の未了」を根拠つきで宣言できるようにし、その宣言自体が腐ったら赤くなる**ようにする。
 *
 * 宣言 1 件について機械検証するのは次の 6 つである。
 *
 *   1. 宣言が指すブロックが本文に実在し、証明を持つべき種別であること。
 *   2. **そのブロックがいまも証明を持っていないこと**（証明が入ったら宣言は余りである＝赤）。
 *   3. 未了を記録した report が実在し、引用文が**ちょうど 1 か所**に当たること。
 *   4. **その引用文が実際に未了を述べていること**（「証明」＋未了を表す語を含む）。
 *      引用を貼り替えて別の文を pin するのを防ぐ。検査 A′ の「その文から実際にその項目が出る」に当たる。
 *   5. **原本の在処が転記検査の台帳（source-links.ts）と一致すること。**
 *      台帳が別の report を根拠に挙げているのに、宣言だけ別の report を指すことはできない。
 *   6. **その report に原本の証明が実際にあること**——目印がちょうど 1 か所に当たり、
 *      そこから後ろ 80 行以内に証明の書き出しがあること。**原本の証明が消えたら赤になる。**
 */

import { readFile } from "node:fs/promises";
import { join } from "node:path";

import type { ConvertedBlock, Node } from "../schema.ts";
import { SOURCE_LINKS } from "./source-links.ts";
import { projectRoot } from "./transcription-model.ts";

/** 証明を持たなければならない種別。根拠は上の doc。 */
export const PROVABLE_KINDS = ["theorem", "claim"] as const;

export type ProofView = {
  id: string;
  file: string;
  kind: string;
  title: string;
  hasProof: boolean;
  /** 証明が「あるが中身が無い」形（空・空白だけ・TODO ノード）なら理由を持つ。 */
  emptyReason?: string;
};

/** 証明の中身を見る。`proof` があっても空・空白だけ・TODO なら「持っていない」。 */
export function proofViewOf(block: ConvertedBlock, file: string): ProofView {
  const kind = block.kind;
  const title = block.kind === "figure" ? "" : (block.title?.text ?? block.title?.tex ?? "");
  const proof = (block as { proof?: readonly Node[] }).proof;
  const base = { id: block.id, file, kind, title };
  if (proof === undefined) return { ...base, hasProof: false, emptyReason: "proof フィールドが無い" };
  if (proof.length === 0) return { ...base, hasProof: false, emptyReason: "proof が空配列" };
  const text: string[] = [];
  let todo = false;
  const walk = (nodes: readonly Node[]): void => {
    for (const node of nodes) {
      if (node.type === "todo") { todo = true; text.push(node.value); }
      else if (node.type === "text") text.push(node.value);
      else if (node.type === "math" || node.type === "displayMath") text.push(node.tex);
      else if (node.type === "paragraph") walk(node.children);
      else if (node.type === "list") node.items.forEach(walk);
    }
  };
  walk(proof);
  if (todo) return { ...base, hasProof: false, emptyReason: "proof が TODO ノードを含む" };
  if (text.join("").trim() === "") return { ...base, hasProof: false, emptyReason: "proof に中身が無い" };
  return { ...base, hasProof: true };
}

// --- 宣言（既知の未了）-----------------------------------------------------------

export type ProofDebt = {
  /** 証明が空の本文ブロックの id。 */
  block: string;
  /** なぜ今それが空なのか（自然文。機械は読まない）。 */
  reason: string;
  grounds: {
    /** その未了を記録している report と、その一文。 */
    recordedIn: { report: string; quote: string };
    /**
     * 原本の証明の在処。`report` は**転記検査の台帳が同じブロックについて挙げている report**
     * でなければならない（宣言だけが別の出所を名乗ることを塞ぐ）。
     * `proofMarker` はその report の中で証明の直前を指す目印。
     */
    origin: { report: string; proofMarker: string };
  };
};

/** 引用・目印がこれより短いと、何を pin しているのか特定できない。 */
const MIN_QUOTE = 12;

/** 「未了である」と述べていると認める語。引用が「証明」とこのいずれかを含むことを要求する。 */
const DEBT_WORDS = ["運んでいない", "持たない", "空", "未了", "入れていない", "まだ"];

/** 目印から後ろ、この行数以内に証明の書き出しがあることを要求する。 */
const PROOF_WINDOW = 80;

/** 証明の書き出し（この report 群の書き方。実測: 7 本すべてがこの形）。 */
const PROOF_OPENING = /^\s*(?:>\s*)?\*\*証明[.．]/;

export type DebtFinding = {
  block: string;
  kind:
    | "宣言が指すブロックが本文に無い"
    | "宣言が指すブロックは証明を要さない種別"
    | "宣言が余っている（証明が入った）"
    | "未了の記録が見つからない"
    | "未了の記録が複数箇所に当たる"
    | "記録が未了を述べていない"
    | "原本の在処が転記検査の台帳と食い違う"
    | "原本の目印が見つからない"
    | "原本の目印が複数箇所に当たる"
    | "原本にその証明が無い"
    | "宣言の指定が短すぎて何も pin していない";
  detail: string;
};

export type MissingProofFinding = {
  block: string;
  file: string;
  kind: string;
  title: string;
  reason: string;
};

/** 証明を持つべきなのに持たず、宣言もされていないブロック。 */
export function findMissingProofs(
  views: readonly ProofView[],
  debts: readonly ProofDebt[],
): MissingProofFinding[] {
  const declared = new Set(debts.map((debt) => debt.block));
  return views
    .filter((view) => (PROVABLE_KINDS as readonly string[]).includes(view.kind))
    .filter((view) => !view.hasProof && !declared.has(view.id))
    .map((view) => ({
      block: view.id,
      file: view.file,
      kind: view.kind,
      title: view.title,
      reason: view.emptyReason ?? "proof が無い",
    }));
}

const fileCache = new Map<string, string[] | null>();
async function linesOf(report: string): Promise<string[] | null> {
  const cached = fileCache.get(report);
  if (cached !== undefined) return cached;
  let lines: string[] | null;
  try {
    lines = (await readFile(join(projectRoot, report), "utf8")).split("\n");
  } catch {
    lines = null;
  }
  fileCache.set(report, lines);
  return lines;
}

/** 宣言 1 件ずつ、根拠が生きているかを検査する。 */
export async function checkProofDebts(
  debts: readonly ProofDebt[],
  views: ReadonlyMap<string, ProofView>,
): Promise<DebtFinding[]> {
  const out: DebtFinding[] = [];
  const add = (block: string, kind: DebtFinding["kind"], detail: string): void => {
    out.push({ block, kind, detail });
  };

  for (const debt of debts) {
    // 1・2: ブロックの実在と、いまも証明が無いこと
    const view = views.get(debt.block);
    if (view === undefined) {
      add(debt.block, "宣言が指すブロックが本文に無い", "本文から消えたか id が変わった。宣言を消すこと");
      continue;
    }
    if (!(PROVABLE_KINDS as readonly string[]).includes(view.kind)) {
      add(debt.block, "宣言が指すブロックは証明を要さない種別", `kind=${view.kind}。宣言は不要である`);
      continue;
    }
    if (view.hasProof) {
      add(debt.block, "宣言が余っている（証明が入った）", "証明が本文に入った。宣言を消すこと");
      continue;
    }

    // 3・4: 未了の記録
    const { report, quote } = debt.grounds.recordedIn;
    if (quote.length < MIN_QUOTE) {
      add(debt.block, "宣言の指定が短すぎて何も pin していない", `recordedIn.quote が ${quote.length} 文字: "${quote}"`);
      continue;
    }
    const recordLines = await linesOf(report);
    if (recordLines === null) {
      add(debt.block, "未了の記録が見つからない", `${report} が読めない`);
      continue;
    }
    const hits = recordLines.filter((line) => line.includes(quote));
    if (hits.length === 0) {
      add(debt.block, "未了の記録が見つからない", `${report} に "${quote}" が無い。記録が書き換わったなら未了の扱いを判定し直すこと`);
      continue;
    }
    if (hits.length > 1) {
      add(debt.block, "未了の記録が複数箇所に当たる", `${hits.length} 行に当たる。一意に特定できる引用にすること`);
      continue;
    }
    if (!quote.includes("証明") || !DEBT_WORDS.some((word) => quote.includes(word))) {
      add(
        debt.block,
        "記録が未了を述べていない",
        `引用に「証明」と未了を表す語（${DEBT_WORDS.join("／")}）の両方が要る: "${quote}"`,
      );
      continue;
    }

    // 5: 台帳との一致
    const ledger = SOURCE_LINKS.find((link) => link.block === debt.block);
    const ledgerReports = new Set((ledger?.passages ?? []).map((passage) => passage.report));
    if (ledgerReports.size > 0 && !ledgerReports.has(debt.grounds.origin.report)) {
      add(
        debt.block,
        "原本の在処が転記検査の台帳と食い違う",
        `台帳が挙げるのは ${[...ledgerReports].join(" / ")} だが、宣言は ${debt.grounds.origin.report} を指している`,
      );
      continue;
    }

    // 6: 原本に証明が実在すること
    const { report: originReport, proofMarker } = debt.grounds.origin;
    if (proofMarker.length < MIN_QUOTE) {
      add(debt.block, "宣言の指定が短すぎて何も pin していない", `origin.proofMarker が ${proofMarker.length} 文字: "${proofMarker}"`);
      continue;
    }
    const originLines = await linesOf(originReport);
    if (originLines === null) {
      add(debt.block, "原本の目印が見つからない", `${originReport} が読めない`);
      continue;
    }
    const at = originLines.flatMap((line, index) => (line.includes(proofMarker) ? [index] : []));
    if (at.length === 0) {
      add(debt.block, "原本の目印が見つからない", `${originReport} に "${proofMarker}" が無い`);
      continue;
    }
    if (at.length > 1) {
      add(debt.block, "原本の目印が複数箇所に当たる", `${at.length} 行に当たる。一意に特定できる目印にすること`);
      continue;
    }
    const window = originLines.slice(at[0]!, at[0]! + PROOF_WINDOW);
    if (!window.some((line) => PROOF_OPENING.test(line))) {
      add(
        debt.block,
        "原本にその証明が無い",
        `${originReport} の "${proofMarker}" から ${PROOF_WINDOW} 行以内に証明の書き出しが無い。` +
          "原本の証明が消えたなら、本文へ運ぶという申し送りは成立しない",
      );
    }
  }
  return out;
}

// --- 宣言（既知の未了）の表 --------------------------------------------------------
//
// **黙って緑にしない。** 件数は毎回出力する（cycle 23 の「照合力 0 のブロック 5 件」、
// cycle 24 の「機械検証できない免除 14 件」と同じ思想）。

// cycle 25 step 4a が命題 G′・G″・J・K・R の 5 件、step 4b が命題 M・U の 2 件へ
// それぞれ原本の証明を運んだので、**宣言は 0 件になった**。
// 以後、証明を持たない `theorem` / `claim` が現れたら、宣言を足さない限り検査 C が赤になる。
export const PROOF_DEBTS: readonly ProofDebt[] = [];
