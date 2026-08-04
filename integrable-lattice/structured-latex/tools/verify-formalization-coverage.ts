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
} from "./formalization-coverage.ts";
import { STALENESS_POLICY, auditLedgerAbsence, type LedgerText } from "./ledger-absence-model.ts";
import {
  EXTERNAL_THEOREM_COVERAGE,
  type ExternalEntry,
  type ExternalKind,
} from "./external-theorem-coverage.ts";
import { auditExternalTheorems } from "./external-theorem-model.ts";

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
};

/** 台帳から数える 4 つの数。名前は本文の言い回しに合わせる。 */
const COUNT_FIELDS = [
  { key: "total", name: "全数" },
  { key: "done", name: "完了" },
  { key: "partial", name: "部分的" },
  { key: "untouched", name: "未着手" },
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
// あわせて、**現に本文が取っている形**（4 つの数を地の文で述べ、数式に数を置かない）が
// 違反にならないことも確かめる。検出できるだけの検査は誤検出で使えなくなるからである。

if (process.argv.includes("--self-test")) {
  const counts: CoverageCounts = { total: 24, done: 5, partial: 16, untouched: 3 };
  const proseOf = (c: CoverageCounts) =>
    `本論文の主張 ${c.total} 件のうち、内容が形式化されているのは ${c.done} 件、` +
    `一部が形式化されているのは ${c.partial} 件、未着手が ${c.untouched} 件である。`;
  /** 本文が現に取っている形（4 つの数を地の文で述べる）。 */
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

  const total = cases.length + LEDGER_ABSENCE_CASES.length;
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
for (const file of readdirSync(leanDir).filter((name) => name.endsWith(".lean"))) {
  const source = readFileSync(join(leanDir, file), "utf8");
  for (const match of source.matchAll(
    /^(?:private\s+|protected\s+|noncomputable\s+)*(?:theorem|lemma|def|abbrev|instance)\s+([A-Za-z_][A-Za-z0-9_'!?]*)/gm,
  )) {
    declaredInLean.add(match[1]!);
  }
}

type Claim = { id: string; title: string; leanNames: readonly string[] };
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
    const short = name.replace(/^IntegrableLattice\./, "");
    if (declaredInLean.has(short)) continue;
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
    ` lean/ の宣言 ${declaredInLean.size} 件`,
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

  // 自分で証明すると決めた外部定理は、まだ 1 件も完了していない。
  // したがって全数までの残りは「本文の未完了 ＋ 自分で証明する外部定理の全件」である。
  const ownRemaining = audit.counts["自分で証明する"];

  console.log("");
  console.log(`  外部定理の振り分け（基準: docs/external-theorem-criterion.md）: 全 ${EXTERNAL_THEOREM_COVERAGE.length} 件`);
  console.log(
    `    自分で証明する ${audit.counts["自分で証明する"]} 件（うち着手済み ${audit.startedOwnProofs} 件） / ` +
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
    console.log(`    [自分で証明する] ${entry.name}`);
    console.log(`      出典: ${entry.source}`);
    console.log(`      mathlib に無い根拠: ${entry.absence}`);
    console.log(`      残り: ${entry.remaining}`);
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
