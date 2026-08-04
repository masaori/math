/**
 * **検査 F（形式化の被覆）**。本文の全主張について形式化の状態が宣言されていること、
 * 宣言が腐っていないこと、宣言された Lean の定理名が実在することを確かめ、
 * **未形式化の件数を毎回出す**。
 *
 * 目標と語彙は `formalization-coverage.ts` の doc を正本とする。要点だけ:
 * **論文の主張を全数 Lean 形式化することが目標である**（2026-08-03 ユーザー方針）。
 * 一部の形式化で足れりとしないので、残りが何件・どれかを毎サイクル見えるようにする。
 *
 * 本文が書いている被覆の数値の照合については、**照合が実際に効いていることを毎回示す**
 * （cycle 28 step 6 が自分の限界として「空振りしても静かなままである」と記録した点。
 * cycle 29 step 6 で塞いだ）。空振りの道は 3 つあり、3 つとも赤くする。
 *
 *   1. 照合する箇所そのものが無い（ロケールごとに 1 箇所も無い／文が 0 文）。
 *   2. 照合する文字列が台帳の数に依っていない（数を動かしても同じ文字列が出る）。
 *      → **台帳の数を 1 ずつ動かして、照合すべき文字列が本文に無くなることを確かめる。**
 *   3. 本文が数を数式ノードで書いている（地の文だけを連結する実装では見えない）。
 *      → **その箇所の数式ノードに被覆の数が現れていないことを確かめる。**
 *
 * `--self-test` を付けて実行すると、上の 3 つが実際に検出されることを合成データで確かめる
 * （`npm run test:formalization`）。検出できることと検出しなかったことは別なので、両方を持つ。
 */

import { existsSync, readFileSync, readdirSync } from "node:fs";
import { join } from "node:path";

import type { TranslatedNode } from "../schema.ts";
import { knownLocales, loadContentFiles, loadContentFilesForLocale, structuredLatexDir } from "./content-modules.ts";
import {
  COVERAGE_NUMBER_SITES,
  type CoverageNumberSite,
  type CoverageState,
  FORMALIZATION_COVERAGE,
  auditPartCoverage,
} from "./formalization-coverage.ts";
import { STALENESS_POLICY, auditLedgerAbsence, type LedgerText } from "./ledger-absence-model.ts";
import {
  EXTERNAL_THEOREM_COVERAGE,
  type ExternalEntry,
  type ExternalKind,
} from "./external-theorem-coverage.ts";
import { auditExternalTheorems } from "./external-theorem-model.ts";
import {
  auditAbsenceEvidenceSupport,
  parseSurveyLog,
  type SurveyLog,
} from "./absence-evidence-support.ts";
import {
  SCOPE_CLAIMS,
  SCOPE_CLAIM_EXEMPTIONS,
  auditScopeClaimCoverage,
  auditScopeClaims,
} from "./scope-claim-support.ts";

/** 地の文だけを連結する（数式・参照は本文の数値の照合に効かないので落とす）。 */
const flattenProse = (nodes: readonly TranslatedNode[]): string => {
  let out = "";
  for (const node of nodes) {
    switch (node.type) {
      case "text":
      case "todo":
        out += node.value;
        break;
      case "paragraph":
        out += flattenProse(node.children);
        break;
      case "list":
        for (const item of node.items) out += flattenProse(item);
        break;
      default:
        break;
    }
  }
  return out;
};

/** 数式ノードの TeX を集める（地の文の照合が見ていない側を見るため）。 */
const collectMathTex = (nodes: readonly TranslatedNode[]): string[] => {
  const out: string[] = [];
  for (const node of nodes) {
    switch (node.type) {
      case "math":
      case "displayMath":
        out.push(node.tex);
        break;
      case "paragraph":
        out.push(...collectMathTex(node.children));
        break;
      case "list":
        for (const item of node.items) out.push(...collectMathTex(item));
        break;
      default:
        break;
    }
  }
  return out;
};

// --- 本文の被覆の数値の照合（本体は純関数。合成データでも同じ経路を通す）--------------

type CoverageCounts = {
  readonly total: number;
  readonly done: number;
  readonly partial: number;
  readonly untouched: number;
  /** 外部定理のうち「自分で証明する」の件数と、そのうち完了した件数。 */
  readonly externalOwn: number;
  readonly externalOwnDone: number;
};

/**
 * 台帳から数える 6 つの数。名前は本文の言い回しに合わせる。
 * 後ろの 2 つは cycle 32 step 1 で足した——外部定理の件数は本文が述べているのに
 * 台帳と突き合わせていなかった（本文だけが古くなる道が空いていた）。
 */
const COUNT_FIELDS = [
  { key: "total", name: "全数" },
  { key: "done", name: "完了" },
  { key: "partial", name: "部分的" },
  { key: "untouched", name: "未着手" },
  { key: "externalOwn", name: "外部定理（自分で証明する）" },
  { key: "externalOwnDone", name: "外部定理（完了）" },
] as const satisfies readonly { key: keyof CoverageCounts; name: string }[];

/** 照合の対象になるブロックの中身。地の文と数式を分けて渡す（分けて検査するため）。 */
type SiteText = { readonly prose: string; readonly mathTex: readonly string[] };

type SiteAudit = {
  readonly locale: string;
  readonly label: string;
  readonly phraseCount: number;
  /** 台帳の数を動かすと照合が動く、と確かめられた数の名前。 */
  readonly pinned: readonly string[];
  readonly mathHits: number;
};

type CoverageNumberAudit = { readonly violations: readonly string[]; readonly sites: readonly SiteAudit[] };

/** 数を 1 増やした台帳の数（照合がその数に依っているかを見るための当て馬）。 */
const bump = (counts: CoverageCounts, key: keyof CoverageCounts): CoverageCounts => ({
  ...counts,
  [key]: counts[key] + 1,
});

/** 桁の境界つきで数を探す（`16` が `160` に当たらないようにする）。 */
const containsNumber = (haystack: string, value: number): boolean =>
  new RegExp(String.raw`(?<![0-9])${value}(?![0-9])`).test(haystack);

const auditCoverageNumberSites = (input: {
  readonly sites: readonly CoverageNumberSite[];
  readonly counts: CoverageCounts;
  readonly expectedLocales: readonly string[];
  readonly textOf: (locale: string, label: string) => SiteText | undefined;
}): CoverageNumberAudit => {
  const { sites, counts, expectedLocales, textOf } = input;
  const violations: string[] = [];
  const audits: SiteAudit[] = [];

  for (const locale of expectedLocales) {
    if (sites.some((site) => site.locale === locale)) continue;
    violations.push(
      `[照合する箇所が無い] ${locale} — 本文は被覆を数で述べているので、` +
        `ロケールごとに少なくとも 1 箇所を台帳へ登録すること（登録が無ければ照合は空振りする）`,
    );
  }

  for (const site of sites) {
    const text = textOf(site.locale, site.label);
    if (text === undefined) {
      violations.push(`[数値の在り処が本文に無い] ${site.locale} / ${site.label}`);
      continue;
    }
    const phrases = site.phrases(counts);
    if (phrases.length === 0) {
      violations.push(
        `[照合する文が 0 文] ${site.locale} / ${site.label} — ` +
          `文が無ければ何も突き合わせていない（件数だけ増えて中身が無い状態を塞ぐ）`,
      );
    }
    for (const phrase of phrases) {
      if (text.prose.includes(phrase)) continue;
      violations.push(
        `[本文の被覆の数値が台帳と合わない] ${site.locale} / ${site.label} — ` +
          `本文に「${phrase}」が無い（台帳の実測: 全 ${counts.total}・完了 ${counts.done}・` +
          `部分的 ${counts.partial}・未着手 ${counts.untouched}）`,
      );
    }

    // 照合がその数に依っているか。**本文に在る文が、数を 1 増やすと本文に無くなること**を
    // 数ごとに確かめる。片方だけでは足りない——照合が数に依っていなければ本文と台帳が
    // ずれても赤くならず、照合そのものが成り立っていなければ固定の証拠にならない。
    const pinned: string[] = [];
    for (const field of COUNT_FIELDS) {
      const moved = site.phrases(bump(counts, field.key));
      const span = Math.min(phrases.length, moved.length);
      let pinnedHere = false;
      for (let index = 0; index < span; index += 1) {
        if (!text.prose.includes(phrases[index]!)) continue;
        if (text.prose.includes(moved[index]!)) continue;
        pinnedHere = true;
        break;
      }
      if (pinnedHere) {
        pinned.push(field.name);
        continue;
      }
      violations.push(
        `[台帳の数を動かしても照合が動かない] ${site.locale} / ${site.label} — ` +
          `${field.name}（${counts[field.key]} → ${counts[field.key] + 1}）を動かしても、` +
          `本文に在る文が本文から外れない。この数は照合で固定されていない` +
          `（照合する文が本文に無い場合も、固定の証拠が立たないのでここに出る）`,
      );
    }

    // 地の文だけを見る実装なので、数が数式ノードへ移ると照合が空振りする。
    // 数式に被覆の数が現れた時点で赤くし、地の文へ戻すか照合の設計を変えるかを選ばせる。
    let mathHits = 0;
    for (const tex of text.mathTex) {
      for (const field of COUNT_FIELDS) {
        if (!containsNumber(tex, counts[field.key])) continue;
        mathHits += 1;
        violations.push(
          `[被覆の数が数式ノードに在る] ${site.locale} / ${site.label} — ` +
            `数式「${tex}」に ${field.name}（${counts[field.key]}）が現れている。` +
            `照合は地の文だけを連結して見るので、数を数式で書くと空振りする（地の文で書くこと）`,
        );
      }
    }

    audits.push({
      locale: site.locale,
      label: site.label,
      phraseCount: phrases.length,
      pinned,
      mathHits,
    });
  }

  return { violations, sites: audits };
};

// --- 検出テスト（`--self-test`）------------------------------------------------
//
// 空振りの 3 つの道を合成データで通し、**3 つとも赤くなること**を確かめる。
// あわせて、**現に本文が取っている形**（6 つの数を地の文で述べ、数式に数を置かない）が
// 違反にならないことも確かめる。検出できるだけの検査は誤検出で使えなくなるからである。

if (process.argv.includes("--self-test")) {
  const counts: CoverageCounts = {
    total: 24, done: 5, partial: 16, untouched: 3, externalOwn: 7, externalOwnDone: 1,
  };
  const proseOf = (c: CoverageCounts) =>
    `本論文の主張 ${c.total} 件のうち、内容が形式化されているのは ${c.done} 件、` +
    `一部が形式化されているのは ${c.partial} 件、未着手が ${c.untouched} 件である。` +
    `自分で証明することにした外部定理は ${c.externalOwn} 件であり、` +
    `そのうち証明を書き終えたのは ${c.externalOwnDone} 件である。`;
  /** 本文が現に取っている形（6 つの数を地の文で述べる）。 */
  const healthySite: CoverageNumberSite = {
    locale: "ja",
    label: "fixture",
    phrases: (c) => [proseOf(c)],
  };
  const healthyText: SiteText = { prose: proseOf(counts), mathTex: [String.raw`\mathrm{decide}`] };

  const cases: readonly {
    readonly name: string;
    readonly input: Parameters<typeof auditCoverageNumberSites>[0];
    /** 違反に含まれていてほしい字面（`undefined` なら違反 0 件を期待する）。 */
    readonly expect?: string;
  }[] = [
    {
      name: "照合する箇所がロケールごとに 1 箇所も無い",
      input: {
        sites: [healthySite],
        counts,
        expectedLocales: ["ja", "en"],
        textOf: () => healthyText,
      },
      expect: "[照合する箇所が無い] en",
    },
    {
      name: "箇所は在るが照合する文が 0 文",
      input: {
        sites: [{ locale: "ja", label: "fixture", phrases: () => [] }],
        counts,
        expectedLocales: ["ja"],
        textOf: () => healthyText,
      },
      expect: "[照合する文が 0 文]",
    },
    {
      name: "照合する文字列が台帳の数に依っていない（数を動かしても同じ文字列）",
      input: {
        sites: [{ locale: "ja", label: "fixture", phrases: () => ["本論文の主張のうち、"] }],
        counts,
        expectedLocales: ["ja"],
        textOf: () => ({ prose: "本論文の主張のうち、内容が形式化されているものがある。", mathTex: [] }),
      },
      expect: "[台帳の数を動かしても照合が動かない]",
    },
    {
      name: "4 つのうち 1 つだけ照合から落ちている（未着手を述べていない）",
      input: {
        sites: [
          {
            locale: "ja",
            label: "fixture",
            phrases: (c) =>
              [`本論文の主張 ${c.total} 件のうち、内容が形式化されているのは ${c.done} 件、` +
                `一部が形式化されているのは ${c.partial} 件である。`],
          },
        ],
        counts,
        expectedLocales: ["ja"],
        textOf: () => ({
          prose:
            `本論文の主張 ${counts.total} 件のうち、内容が形式化されているのは ${counts.done} 件、` +
            `一部が形式化されているのは ${counts.partial} 件である。`,
          mathTex: [],
        }),
      },
      expect: "未着手（3 → 4）",
    },
    {
      name: "本文が数を数式ノードで書いている",
      input: {
        sites: [healthySite],
        counts,
        expectedLocales: ["ja"],
        textOf: () => ({
          prose: "本論文の主張 件のうち、内容が形式化されているのは 件、一部が形式化されているのは 件、未着手が 件である。",
          mathTex: [String.raw`24`, String.raw`5`, String.raw`16`, String.raw`3`],
        }),
      },
      expect: "[被覆の数が数式ノードに在る]",
    },
    {
      name: "照合すべき文が本文から消えている",
      input: {
        sites: [healthySite],
        counts,
        expectedLocales: ["ja"],
        textOf: () => ({ prose: "被覆は全数ではない。", mathTex: [] }),
      },
      expect: "[本文の被覆の数値が台帳と合わない]",
    },
    {
      name: "現に本文が取っている形は通る",
      input: { sites: [healthySite], counts, expectedLocales: ["ja"], textOf: () => healthyText },
    },
    {
      name: "桁の境界を見る（16 は 160 に当たらない）",
      input: {
        sites: [healthySite],
        counts,
        expectedLocales: ["ja"],
        textOf: () => ({ prose: healthyText.prose, mathTex: [String.raw`160`, String.raw`245`] }),
      },
    },
  ];

  console.log("");
  console.log("形式化の被覆の検査の検出テスト（本文の被覆の数値の照合が空振りする道）");
  let failed = 0;
  for (const item of cases) {
    const { violations } = auditCoverageNumberSites(item.input);
    if (item.expect === undefined) {
      if (violations.length === 0) {
        console.log(`  OK（誤検出なし）: ${item.name}`);
      } else {
        failed += 1;
        console.log(`  NG（誤検出）: ${item.name} — ${violations.join(" / ")}`);
      }
      continue;
    }
    if (violations.some((violation) => violation.includes(item.expect!))) {
      console.log(`  OK（検出）: ${item.name}`);
    } else {
      failed += 1;
      console.log(`  NG（検出されなかった）: ${item.name} — 期待した字面「${item.expect}」`);
      for (const violation of violations) console.log(`      出た違反: ${violation}`);
    }
  }
  const { LEDGER_ABSENCE_CASES, runLedgerAbsenceCases } = await import(
    "./verify-ledger-absence-detection-test.ts"
  );
  failed += runLedgerAbsenceCases();

  // cycle 34 step 5: 部の覆いの検出テスト（現に起きた形＝命題 R の (R5) 落ちを再現する）。
  const partCases: { name: string; shouldFail: boolean; run: () => string[] }[] = [
    {
      name: "部分的なのに部の 1 つに触れていない（cycle 34 が実際に見つけた形）",
      shouldFail: true,
      run: () =>
        auditPartCoverage({
          entries: [
            {
              block: "fixture",
              state: "部分的",
              text: "(R1)(R2)(R3) の核まで。(R4) は未形式化。",
              statementText: "(R1 桁枝分解) …(R4 終結式による付値) …(R5 予言アルゴリズム) …",
            },
          ],
        }).violations,
    },
    {
      name: "部を全部書いていれば通る",
      shouldFail: false,
      run: () =>
        auditPartCoverage({
          entries: [
            {
              block: "fixture",
              state: "部分的",
              text: "(R1)(R2)(R3) の核まで。(R4)(R5) は未形式化。",
              statementText: "(R1 桁枝分解) …(R4 終結式による付値) …(R5 予言アルゴリズム) …",
            },
          ],
        }).violations,
    },
    {
      name: "素点の名前で部を切っている主張も見る（cycle 35 step 4 が現に見つけた形）",
      shouldFail: true,
      run: () =>
        auditPartCoverage({
          entries: [
            {
              block: "fixture",
              state: "部分的",
              text: "アルキメデス側は未形式化。(p 素点, 有限 L) は入った。",
              statementText:
                "(∞ 素点) …\n(p 素点, 有限 L) …\n(p 素点, 塔の漸近) …",
            },
          ],
        }).violations,
    },
    {
      name: "素点の名前を書けば通る（偽陽性でない）",
      shouldFail: false,
      run: () =>
        auditPartCoverage({
          entries: [
            {
              block: "fixture",
              state: "部分的",
              text: "(∞ 素点) は未形式化。(p 素点, 有限 L) は入った。(p 素点, 塔の漸近) も未形式化。",
              statementText:
                "(∞ 素点) …\n(p 素点, 有限 L) …\n(p 素点, 塔の漸近) …",
            },
          ],
        }).violations,
    },
    {
      name: "枝番つきの部（U1a）も見る（cycle 35 step 4 が現に見つけた形）",
      shouldFail: true,
      run: () =>
        auditPartCoverage({
          entries: [
            {
              block: "fixture",
              state: "部分的",
              text: "(U1)(U2) は入った。",
              statementText: "(U1 付値側と位置側の分業) …\n(U1a 飽和深度を大きめに取ってもよい) …",
            },
          ],
        }).violations,
    },
    {
      name: "完了と未着手は対象外（部ごとに書く欄ではない）",
      shouldFail: false,
      run: () =>
        auditPartCoverage({
          entries: [
            {
              block: "fixture",
              state: "完了",
              text: "全部書いた。",
              statementText: "(R1 桁枝分解) …(R5 予言アルゴリズム) …",
            },
          ],
        }).violations,
    },
  ];
  for (const partCase of partCases) {
    const violations = partCase.run();
    const ok = violations.length > 0 === partCase.shouldFail;
    if (!ok) failed += 1;
    console.log(`  ${ok ? "OK" : "NG"} [部の覆い] ${partCase.name}`);
  }

  const total = cases.length + LEDGER_ABSENCE_CASES.length + partCases.length;
  console.log("");
  if (failed > 0) {
    console.log(`NG: ${failed} 件が期待どおりでない。`);
    process.exit(1);
  }
  console.log(`OK: ${total} 件すべて期待どおり。`);
  process.exit(0);
}

const leanDir = join(structuredLatexDir, "..", "lean", "IntegrableLattice");

const declaredInLean = new Set<string>();
// 印字する件数は「宣言の個数」なので、照合用の集合（裸の名前も入れる）とは別に持つ。
const declaredFullyQualified = new Set<string>();
for (const file of readdirSync(leanDir).filter((name) => name.endsWith(".lean"))) {
  const source = readFileSync(join(leanDir, file), "utf8");
  // 名前空間を追いながら走る。**入れ子の名前空間の中の宣言も完全修飾名で拾うため**である
  // （cycle 32 は入れ子を使うと照合が通らないことを接頭辞で回避したが、
  //  「照合の側を名前空間に対応させるほうが本筋である」と限界に書いていた。ここで直した）。
  const namespaceStack: string[] = [];
  for (const line of source.split("\n")) {
    const open = /^\s*namespace\s+([A-Za-z_][A-Za-z0-9_'.!?]*)/.exec(line);
    if (open) {
      namespaceStack.push(open[1]!);
      continue;
    }
    const close = /^\s*end\s+([A-Za-z_][A-Za-z0-9_'.!?]*)\s*$/.exec(line);
    if (close && namespaceStack[namespaceStack.length - 1] === close[1]) {
      namespaceStack.pop();
      continue;
    }
    const decl =
      /^(?:private\s+|protected\s+|noncomputable\s+)*(?:theorem|lemma|def|abbrev|instance)\s+([A-Za-z_][A-Za-z0-9_'!?]*)/.exec(
        line,
      );
    if (!decl) continue;
    const bare = decl[1]!;
    // 完全修飾名と裸の名前の両方を登録する（既存の紐づけは裸の名前で書かれている）。
    declaredInLean.add(bare);
    const qualified = [...namespaceStack, bare].join(".");
    declaredFullyQualified.add(qualified);
    if (namespaceStack.length > 0) {
      declaredInLean.add(qualified);
    }
  }
}

type Claim = { id: string; title: string; leanNames: readonly string[]; statementText: string };

/** ノードの木から地の文を集める（部の見出しを拾うためだけに使う）。 */
function plainTextOfNodes(node: unknown): string {
  if (node == null) return "";
  if (typeof node === "string") return node;
  if (Array.isArray(node)) return node.map(plainTextOfNodes).join("");
  if (typeof node === "object") {
    const n = node as Record<string, unknown>;
    return plainTextOfNodes(n.value) + plainTextOfNodes(n.children) + plainTextOfNodes(n.text);
  }
  return "";
}
const claims: Claim[] = [];
/** 外部定理の台帳が「どのブロックが引いているか」を指すので、主張以外（注記・定義）の id も要る。 */
const allBlockIds = new Set<string>();
for (const { blocks } of await loadContentFiles()) {
  for (const block of blocks) {
    allBlockIds.add(block.id);
    if (block.kind !== "theorem" && block.kind !== "claim") continue;
    claims.push({
      id: block.id,
      title: block.title?.text ?? "",
      leanNames: block.lean ?? [],
      // 段落の境界を残す（段落の先頭にある部の見出しを拾うため。cycle 35 step 4）。
      statementText: (block.statement ?? []).map(plainTextOfNodes).join("\n"),
    });
  }
}

const byBlock = new Map(FORMALIZATION_COVERAGE.map((entry) => [entry.block, entry] as const));
const violations: string[] = [];

for (const claim of claims) {
  const entry = byBlock.get(claim.id);
  if (entry === undefined) {
    violations.push(
      `[台帳に無い主張] ${claim.id}（${claim.title}）— 形式化の状態を宣言すること（黙って落とせない）`,
    );
    continue;
  }
  if (entry.state !== "未着手" && claim.leanNames.length === 0) {
    violations.push(
      `[${entry.state} なのに Lean の紐づけが無い] ${claim.id} — 形式化したと言うなら読者が辿れる先が要る`,
    );
  }
  if (entry.state === "未着手" && claim.leanNames.length > 0) {
    violations.push(
      `[未着手なのに Lean の紐づけがある] ${claim.id} — 紐づけがあるなら少なくとも「部分的」である`,
    );
  }
  for (const name of claim.leanNames) {
    // 完全修飾名でも、`IntegrableLattice.` を落とした形でも、裸の名前でも当たるようにする。
    const short = name.replace(/^IntegrableLattice\./, "");
    if (declaredInLean.has(name) || declaredInLean.has(short)) continue;
    violations.push(`[Lean に実在しない定理名] ${claim.id} — ${name}`);
  }
}

const claimIds = new Set(claims.map((claim) => claim.id));
for (const entry of FORMALIZATION_COVERAGE) {
  if (claimIds.has(entry.block)) continue;
  violations.push(`[宣言が余っている] ${entry.block} — その主張は本文に無い（改名・削除で浮いた）`);
}

const counts: Record<CoverageState, number> = { 完了: 0, 部分的: 0, 未着手: 0 };
for (const entry of FORMALIZATION_COVERAGE) counts[entry.state] += 1;
const unformalised = FORMALIZATION_COVERAGE.filter((entry) => entry.state !== "完了");

console.log("");
console.log("形式化の被覆の検査（検査 F）");
console.log("  目標: 論文の主張を全数 Lean 形式化する（2026-08-03 ユーザー方針）。");
console.log(
  `  本文の主張（theorem / claim）${claims.length} 件 / 台帳 ${FORMALIZATION_COVERAGE.length} 件 /` +
    ` lean/ の宣言 ${declaredFullyQualified.size} 件`,
);
console.log(
  `  状態: 完了 ${counts.完了} 件 / 部分的 ${counts.部分的} 件 / 未着手 ${counts.未着手} 件`,
);
console.log(`  **全数形式化まで残り ${unformalised.length} 件**（完了でないもの）`);
console.log("");
for (const entry of unformalised) {
  const detail = entry.state === "部分的" ? entry.remaining : entry.reason;
  console.log(`    [${entry.state}] ${entry.block}`);
  console.log(`      残り／理由: ${detail}`);
}

// --- 本文が書いている被覆の数値が、台帳から数えた実測値と一致するか ---
{
  const counts = {
    total: FORMALIZATION_COVERAGE.length,
    done: FORMALIZATION_COVERAGE.filter((entry) => entry.state === "完了").length,
    partial: FORMALIZATION_COVERAGE.filter((entry) => entry.state === "部分的").length,
    untouched: FORMALIZATION_COVERAGE.filter((entry) => entry.state === "未着手").length,
    externalOwn: EXTERNAL_THEOREM_COVERAGE.filter((entry) => entry.kind === "自分で証明する").length,
    externalOwnDone: EXTERNAL_THEOREM_COVERAGE.filter(
      (entry) => entry.kind === "自分で証明する" && entry.state === "完了",
    ).length,
  };
  const textByLabelPerLocale = new Map<string, Map<string, SiteText>>();
  for (const locale of knownLocales) {
    const byLabel = new Map<string, SiteText>();
    for (const { blocks } of await loadContentFilesForLocale(locale)) {
      for (const block of blocks) {
        if (block.kind === "heading" || block.kind === "figure") continue;
        const nodes = [...block.statement, ...(block.proof ?? [])];
        const text: SiteText = { prose: flattenProse(nodes), mathTex: collectMathTex(nodes) };
        for (const label of block.labels ?? []) byLabel.set(label, text);
      }
    }
    textByLabelPerLocale.set(locale, byLabel);
  }

  const audit = auditCoverageNumberSites({
    sites: COVERAGE_NUMBER_SITES,
    counts,
    expectedLocales: knownLocales,
    textOf: (locale, label) => textByLabelPerLocale.get(locale)?.get(label),
  });
  violations.push(...audit.violations);

  const checkedPhrases = audit.sites.reduce((sum, site) => sum + site.phraseCount, 0);
  console.log(
    `  本文が書いている被覆の数値: ${audit.sites.length} 箇所 / ` +
      `${checkedPhrases} 文を台帳の実測値と突き合わせた`,
  );
  console.log(
    `    期待: ロケール ${knownLocales.length} 件（${knownLocales.join(" / ")}）それぞれ 1 箇所以上、` +
      `各箇所 1 文以上（根拠: 形式検証の到達点の段が日英とも被覆を数で述べている）。` +
      `下回れば違反にする（0 件でも静かに緑になる道を塞ぐ）`,
  );
  for (const site of audit.sites) {
    console.log(
      `    ${site.locale} / ${site.label}: ${site.phraseCount} 文 / ` +
        `台帳の数を 1 ずつ動かして照合が動いた数 ${site.pinned.length} / ${COUNT_FIELDS.length}` +
        `（${site.pinned.length === 0 ? "無し" : site.pinned.join("・")}）/ ` +
        `数式ノードに現れた被覆の数 ${site.mathHits} 件`,
    );
  }
}

// --- 台帳が「無い」と書いた箇所に、実在確認の根拠が付いているか ---
//
// cycle 29 総括の記録（壁の名前を一次情報より先に書く誤りが 4 サイクル連続）に対する検査。
// 何を不在の主張とみなし、何を根拠と認め、なぜその粒度なのかは ledger-absence-model.ts の doc が正本。
{
  const projectDir = join(structuredLatexDir, "..");
  const entries: LedgerText[] = FORMALIZATION_COVERAGE.map((entry) => ({
    block: entry.block,
    text: entry.state === "完了" ? (entry.note ?? "") : entry.state === "部分的" ? entry.remaining : entry.reason,
  }));

  const readMathlibCommitOfLog = (path: string): string | undefined => {
    const source = readFileSync(join(projectDir, path), "utf8");
    return /=== mathlib commit ===\s*\n\s*([0-9a-f]{7,40})/.exec(source)?.[1];
  };
  const currentMathlibCommit = (() => {
    const manifest = join(projectDir, "lean", "lake-manifest.json");
    if (!existsSync(manifest)) return undefined;
    for (const pkg of JSON.parse(readFileSync(manifest, "utf8")).packages ?? []) {
      if (pkg?.name === "mathlib" && typeof pkg?.rev === "string") return pkg.rev as string;
    }
    return undefined;
  })();

  const audit = auditLedgerAbsence({
    entries,
    logExists: (path) => existsSync(join(projectDir, path)),
    logCommit: readMathlibCommitOfLog,
    currentMathlibCommit,
  });
  violations.push(...audit.violations);

  const withClaims = audit.entries.filter((entry) => entry.claims.length > 0);
  const claimCount = withClaims.reduce((sum, entry) => sum + entry.claims.length, 0);
  const retracted = audit.entries.reduce((sum, entry) => sum + entry.retracted, 0);
  const unbacked = withClaims.filter((entry) => !entry.hasEvidence);
  const staleLogs = audit.logs.filter((log) => log.stale);

  console.log("");
  console.log(
    `  台帳の「無い」の根拠: 不在の主張 ${claimCount} 件 / ${withClaims.length} エントリ` +
      `（撤回された引用として除いたもの ${retracted} 件）`,
  );
  console.log(
    `    根拠を持たないエントリ ${unbacked.length} 件 / ` +
      `根拠に挙がった実在確認ログ ${audit.logs.length} 本` +
      `（うち現在の mathlib と違うコミットのもの ${staleLogs.length} 本）`,
  );
  console.log(`    現在の mathlib（lean/lake-manifest.json）: ${currentMathlibCommit ?? "読めない"}`);
  for (const log of audit.logs) {
    const mark = !log.exists ? "実在しない" : log.stale ? "古い" : "現在と同じ";
    console.log(`      ${log.path}: ${log.recordedCommit ?? "コミットの記録なし"}（${mark}）`);
  }
  console.log(`    ${STALENESS_POLICY}`);

  // --- その根拠が主張を実際に支えているか（cycle 31 step 4） ---
  //
  // cycle 30 step 3 が明記した限界への手当て。ログのパスが書いてあることだけでなく、
  // そのログの中の数字が不在を示していることまで見る。設計は absence-evidence-support.ts の doc。
  const surveyLogs: SurveyLog[] = [];
  for (const path of new Set(audit.entries.flatMap((entry) => entry.logPaths))) {
    const full = join(projectDir, path);
    if (!existsSync(full)) continue;
    surveyLogs.push(parseSurveyLog(path, readFileSync(full, "utf8")));
  }

  const support = auditAbsenceEvidenceSupport({
    entries: withClaims.map((entry) => ({
      block: entry.block,
      text: entries.find((row) => row.block === entry.block)?.text ?? "",
      logPaths: entry.logPaths,
    })),
    logs: surveyLogs,
  });
  violations.push(...support.violations);

  console.log("");
  console.log(
    `  その根拠は主張を支えているか: 数字が支えている ${support.counts.数字が支えている} 件 / ` +
      `宣言の直読が支えている ${support.counts.宣言の直読が支えている} 件 / ` +
      `数字は不在を示していない（射程の主張）${support.counts["数字は不在を示していない（射程の主張）"]} 件 / ` +
      `ログを引いていない（本文の実測値だけ）${support.counts["ログを引いていない（本文の実測値だけ）"]} 件` +
      `（読んだ実在確認ログ ${surveyLogs.length} 本 / 概念 ${surveyLogs.reduce((sum, log) => sum + log.concepts.length, 0)} 件）`,
  );
  for (const entry of support.entries) {
    if (entry.kind !== "数字が支えている") continue;
    console.log(`      ${entry.block}: ${entry.supportingConcept}`);
  }
  for (const entry of support.entries) {
    if (entry.kind === "数字が支えている" || entry.kind === "宣言の直読が支えている") continue;
    console.log(`      ${entry.block}: ${entry.kind}`);
  }
  console.log(
    "    後ろ 2 つは嘘とは限らない。「無い」ではなく「在るが射程が足りない」型の主張は" +
      "語の件数では支えられないためである。**そこを違反にすると、正直に射程を書いているエントリほど" +
      "赤くなる逆向きの規律になる**ので、違反にせず内訳を数で出す。",
  );
  console.log(
    "    限界: その検索語がその数学的主張にとって正しい語かは判定できない" +
      "（`matrixTree` が 0 件であることは確かめられるが、matrix-tree 定理を探すのに" +
      "その語を引くのが妥当かは人の判断である）。この検査の強さの上限は、台帳の書き手が選んだ語の妥当性である。",
  );

  // --- 「射程の主張」を機械で支える（cycle 32 step 4）---
  //
  // 上の内訳で「語の件数では支えられない」と出た型を、mathlib の原文を読んで確かめる。
  // mathlib がこの作業ツリーに無い場合は違反にせず、確かめられなかった件数を出す
  // （npm run check は mathlib 不在でも通る前提で運用している）。
  const mathlibRoot = join(structuredLatexDir, "..", "lean", ".lake", "packages", "mathlib");
  const mathlibPresent = existsSync(join(mathlibRoot, "Mathlib"));
  const readMathlibFile = (path: string): string | undefined => {
    const full = join(mathlibRoot, path);
    if (!existsSync(full)) return undefined;
    return readFileSync(full, "utf8");
  };
  const grepMathlib = mathlibPresent
    ? (token: string): readonly string[] => {
        const hits: string[] = [];
        const walk = (dir: string) => {
          for (const item of readdirSync(dir, { withFileTypes: true })) {
            const full = join(dir, item.name);
            if (item.isDirectory()) {
              walk(full);
              continue;
            }
            if (!item.name.endsWith(".lean")) continue;
            const source = readFileSync(full, "utf8");
            if (!source.includes(token)) continue;
            for (const line of source.split("\n")) if (line.includes(token)) hits.push(line);
          }
        };
        walk(join(mathlibRoot, "Mathlib"));
        return hits;
      }
    : undefined;

  const scope = auditScopeClaims({ claims: SCOPE_CLAIMS, readMathlibFile, grepMathlib });
  violations.push(...scope.violations);

  console.log("");
  console.log(
    `  「射程の主張」の裏取り（cycle 32 step 4 で追加）: 登録 ${SCOPE_CLAIMS.length} 件 / ` +
      `裏が取れた ${scope.counts.裏が取れた} 件 / 反証された ${scope.counts.反証された} 件 / ` +
      `確かめられない ${scope.counts.確かめられない} 件` +
      `（mathlib はこの作業ツリーに ${mathlibPresent ? "在る" : "無い"}）`,
  );
  for (const verdict of scope.verdicts) {
    console.log(`      [${verdict.status}] ${verdict.claim.entry} — ${verdict.detail}`);
  }
  console.log(
    "    「在るが射程が足りない」を、確かめられる 3 つの形へ落としてある" +
      "（宣言が仮定を要求する／在るが概念を使っていない／在るが関係が無い）。" +
      "**3 つとも現に台帳にある主張から逆算したものであって、原理から出たものではない。**",
  );
  console.log(
    "    限界: その射程の主張が当の数学的主張にとって正しい射程かは判定できない" +
      "（`MvPolynomial` が 0 件であることは確かめられるが、本論文が要るのが多変数版かは人の判断である）。",
  );

  // cycle 34 step 5: `部分的` の欄が本文の部を全部覆っているか。
  {
    const partAudit = auditPartCoverage({
      entries: claims.flatMap((claim) => {
        const entry = byBlock.get(claim.id);
        if (entry === undefined) return [];
        const e = entry as unknown as Record<string, string>;
        return [
          {
            block: claim.id,
            state: entry.state,
            text: [e.remaining, e.reason, e.note].filter((x) => typeof x === "string").join(" "),
            statementText: claim.statementText,
          },
        ];
      }),
    });
    violations.push(...partAudit.violations);
    console.log(
      `    台帳が本文の部を覆っているか（cycle 34 step 5 で追加）: ` +
        `部の見出しを持つ 部分的 の主張 ${partAudit.checked} 件 / 部 ${partAudit.parts} 件 / ` +
        `覆っていないもの ${partAudit.violations.length} 件`,
    );
    console.log(
      "    **`部分的` はどの部がどちら側かを書かない限り情報を持たない。** " +
        "cycle 34 の着手時の実測は、命題 R の欄が (R4) しか書かず (R5) を落としていたのを見つけた。" +
        "同じ形を機械が見る（この検査を入れたとき、他に 4 件の書き落としが出た）。",
    );
    console.log(
      "    限界: 部の記号が欄に在ることは確かめられるが、そこに書いてある状態が正しいかは確かめられない。" +
        "**cycle 35 step 4 で、部の見出しの拾い方を実測から広げた**——" +
        "段落の先頭にある括弧つきの見出しも部として扱い、枝番つきの記号（`U1a`）も拾う。" +
        "広げた結果、素点の名前で部を切っている 双対命題 D と、枝番つきの 命題 U の " +
        "合わせて 2 件の書き落としが出た（2 件とも台帳へ写した）。" +
        "それでもなお、部の見出しをまったく持たない主張は対象外である" +
        "（実測では 部分的 14 件のうち 6 件がこれに当たり、6 件とも本文に部の構造が無い）。",
    );
  }

  // cycle 34 step 4: 分類の手前の取りこぼしを、台帳の地の文の側から拾う。
  const scopeEntries: { name: string; text: string }[] = [];
  for (const entry of FORMALIZATION_COVERAGE) {
    const e = entry as unknown as Record<string, string>;
    scopeEntries.push({
      name: entry.block,
      text: [e.remaining, e.reason, e.note].filter((x) => typeof x === "string").join(" "),
    });
  }
  for (const entry of EXTERNAL_THEOREM_COVERAGE) {
    const e = entry as unknown as Record<string, string>;
    scopeEntries.push({
      name: entry.name,
      text: [e.remaining, e.note, e.presence, e.wiring, e.isolation, e.notAGround, e.absence]
        .filter((x) => typeof x === "string")
        .join(" "),
    });
  }
  const coverage = auditScopeClaimCoverage({
    entries: scopeEntries,
    registered: SCOPE_CLAIMS.map((claim) => claim.entry.split(" / ")[0]!),
    exemptions: SCOPE_CLAIM_EXEMPTIONS,
  });
  violations.push(...coverage.violations);
  console.log(
    `    登録の網羅性（cycle 34 step 4 で追加）: 台帳の地の文が射程の主張を書いているエントリ ` +
      `${coverage.candidates} 件 / 未登録で違反にしたもの ${coverage.violations.length} 件 / ` +
      `射程の主張ではないとして免除したもの ${coverage.exempted} 件`,
  );
  console.log(
    "    **分類を待たずに台帳の文そのものを読む。**「mathlib に在るが足りない」と地の文で言っている" +
      "エントリに登録が無ければ違反にする（cycle 33 までは、分類の手前の取りこぼしは人の読みのままだった）。",
  );
  console.log(
    "    限界: **目印に当たらない書き方をすれば素通りする。網羅性は測れないままである**" +
      "（狭めたのであって塞いだのではない）。目印は原理からではなく、現に台帳にある射程の主張の文から拾った。",
  );
}

// --- 外部定理の振り分け（2026-08-04 ユーザー判断。基準は docs/external-theorem-criterion.md） ---
//
// 全数形式化の対象に、本論文が証明せず引用している外部定理も含める。
// ここが確かめるのは、振り分けが腐っていないことと、種別ごとに要求した根拠が書かれていることだけ。
// 振り分けそのもの（ある引用が「証明の根拠」か「位置づけ」か）は人の読みである。
{
  const byKind: Record<ExternalKind, ExternalEntry[]> = {
    "自分で証明する": [],
    "mathlib から引く": [],
    "R 脱出として隔離する": [],
    対象外: [],
  };
  for (const entry of EXTERNAL_THEOREM_COVERAGE) byKind[entry.kind].push(entry);

  const audit = auditExternalTheorems({
    entries: EXTERNAL_THEOREM_COVERAGE,
    blockExists: (id) => allBlockIds.has(id),
    leanDeclExists: (name) => declaredInLean.has(name),
  });
  violations.push(...audit.violations);

  // 全数までの残りは「本文の未完了 ＋ 自分で証明する外部定理のうち完了していないもの」である。
  // cycle 31 まではここが全件だった（台帳に完了を書く場所が無かったため、
  // 何段書いても件数が動かなかった）。cycle 32 step 1 で状態を持たせて動くようにした。
  const ownRemaining = audit.counts["自分で証明する"] - audit.doneOwnProofs;

  console.log("");
  console.log(`  外部定理の振り分け（基準: docs/external-theorem-criterion.md）: 全 ${EXTERNAL_THEOREM_COVERAGE.length} 件`);
  console.log(
    `    自分で証明する ${audit.counts["自分で証明する"]} 件` +
      `（うち完了 ${audit.doneOwnProofs} 件・着手済み ${audit.startedOwnProofs} 件） / ` +
      `mathlib から引く ${audit.counts["mathlib から引く"]} 件 / ` +
      `R 脱出として隔離する ${audit.counts["R 脱出として隔離する"]} 件 / ` +
      `対象外 ${audit.counts["対象外"]} 件`,
  );
  console.log(
    `  **全数形式化まで残り ${unformalised.length + ownRemaining} 件**` +
      `（本文の主張 ${unformalised.length} 件 ＋ 自分で証明する外部定理 ${ownRemaining} 件）`,
  );
  console.log("");
  for (const entry of byKind["自分で証明する"]) {
    if (entry.kind !== "自分で証明する") continue;
    console.log(`    [自分で証明する / ${entry.state}] ${entry.name}`);
    console.log(`      出典: ${entry.source}`);
    console.log(`      mathlib に無い根拠: ${entry.absence}`);
    console.log(
      entry.state === "完了" ? `      完了と呼ぶ射程: ${entry.note}` : `      残り: ${entry.remaining}`,
    );
  }
  for (const entry of byKind["R 脱出として隔離する"]) {
    if (entry.kind !== "R 脱出として隔離する") continue;
    console.log(`    [R 脱出として隔離する] ${entry.name}`);
    console.log(`      隔離の根拠: ${entry.isolation}`);
  }
  console.log(
    "  限界（外部定理）: 種別の振り分けは人の読みである。機械が見るのは、" +
      "引いている箇所が実在すること・種別ごとに要求した根拠が書かれていること・" +
      "宣言した定理名が lean/ に実在することだけで、" +
      "「その引用が本当に証明の根拠でないか」「隔離が本当にできているか」は見ていない。",
  );
}

if (violations.length > 0) {
  console.log("");
  console.log(`  違反 ${violations.length} 件`);
  for (const violation of violations) console.log(`    ${violation}`);
  console.log("");
  console.log("  直し方: `tools/formalization-coverage.ts` の宣言を実態へ合わせる。");
  console.log("  形式化できない主張は、黙って落とさず、何がなぜできないかを一次情報で書くこと。");
  console.log("");
  console.log(`違反 ${violations.length} 件。`);
  process.exit(1);
}

console.log("");
console.log(
  "  限界: 「完了」が本当に完了かは機械で確かめられない（人の判断）。" +
    "この検査が保証するのは、判断が書かれていることと、書かれた判断が腐っていないことだけである。",
);
console.log(
  "  限界（本文の数値の照合）: 塞いだのは本文と台帳がずれる道だけである。" +
    "台帳の状態そのものが実態とずれている場合（形式化が進んだのに台帳を直していない等）は、" +
    "本文と台帳が一致したまま両方が古くなるので、この検査は緑のままである。",
);
console.log("");
console.log("違反 0 件。");
