/**
 * **「射程の主張」を機械で支える**（検査 F の第 3 部）。
 *
 * ## なぜこれがあるか
 *
 * cycle 31 step 4 が、台帳の「無い」の根拠を数字まで読む検査を入れた。その結果、
 * **不在を主張している 9 エントリのうち機械が再確認できているのは 5 件**で、
 * 残り 4 件は人の読みに依ったままであると分かった。残った 4 件を 1 件ずつ読むと、
 * いずれも「無い」ではなく**「在るが射程が足りない」型**だった——
 * 整除の鎖が無い／断片しか無い／多変数が無い、である。
 *
 * **語の件数ではこの型を支えられない。** 語は当たるからである。
 * cycle 31 はそこを違反にせず内訳を数で出すに留め、
 * 「射程を型のある形にする設計が要る」を cycle 32 へ送った。ここがその設計である。
 *
 * ## 考え方: 射程の主張を、確かめられる 3 つの形へ落とす
 *
 * 「在るが射程が足りない」は漠然としているが、**実際に起きている 3 つの形**へ分けると
 * どれも mathlib の原文を読めば確かめられる。**3 つとも、現に台帳にある主張から逆算した**
 * （原理から出したものではない。検査 Λ の 3 規則と同じ立て方である）。
 *
 * 1. **`宣言が仮定を要求する`** — その名前は在るが、宣言が強い仮定の下にある。
 *    例: `Module.Basis.traceDual` は在るが、体と分離性を要求するので可換環では使えない。
 *    確かめ方: その宣言を含むファイルで、宣言より前の `variable` 行（または宣言自身）に
 *    その仮定が書かれていること。
 *    **注意**: 仮定は宣言行そのものではなく `variable` 行に書かれているのが普通である。
 *    台帳が「宣言行で直読した」と書いていたのは言い方が緩く、実際は節の `variable` である。
 * 2. **`在るが概念を使っていない`** — そのファイルは在るが、要る概念を 1 度も使っていない。
 *    例: Mahler 測度のファイルは在るが `MvPolynomial` を 1 度も使っていない（＝多変数が無い）。
 *    確かめ方: ファイルが在り、その語が 1 度も現れないこと。
 * 3. **`在るが関係が無い`** — その名前は在るが、要る関係と一緒に現れる箇所が無い。
 *    例: `Ideal.smithCoeffs` は在るが、整除記号と同じ行に現れる箇所が無い（＝整除の鎖が無い）。
 *    確かめ方: 語 A が在り、かつ語 A と語 B が同じ行に現れる箇所が 0 件であること。
 *
 * ## 何を違反にするか
 *
 * **主張が反証されたときだけ違反にする。** すなわち、
 * 仮定が見つからない／不在と言った語が在る／無いと言った組合せが在る、のいずれか。
 * **確かめられなかった場合（mathlib がこの作業ツリーに無い）は違反にしない**——
 * `npm run check` は mathlib 不在でも通る前提で運用しているためである（cycle 31 の判断と同じ）。
 * 確かめられなかった件数は毎回印字する。
 *
 * ## 機械が確かめられないこと（正直に書く）
 *
 * - **その射程の主張が、当の数学的主張にとって正しい射程かは判定できない。**
 *   `MvPolynomial` が無いことは確かめられるが、
 *   本論文が要るのが本当に多変数版かは人の判断である。
 *   （検査 F の他の部分が持っている限界と同じ形。上限は台帳の書き手が選んだ語の妥当性である。）
 * - **登録されていない射程の主張は、これまでどおり人の読みのままである。** 登録の網羅性は測れない。
 */

export type ScopeClaimKind = "宣言が仮定を要求する" | "在るが概念を使っていない" | "在るが関係が無い";

export type ScopeClaim = {
  /** どの台帳エントリの主張か（本文ブロックの id、または外部定理の名前）。 */
  readonly entry: string;
  /** なぜそれが射程の不足にあたるか（人の言葉。機械は読まない）。 */
  readonly why: string;
} & (
  | {
      readonly kind: "宣言が仮定を要求する";
      /** mathlib 内の相対パス。 */
      readonly file: string;
      /** 宣言の名前（`Module.Basis.traceDual` など）。 */
      readonly declaration: string;
      /** その宣言が置かれている場所が要求する仮定（`variable` 行に現れる字面）。 */
      readonly requires: readonly string[];
    }
  | {
      readonly kind: "在るが概念を使っていない";
      readonly file: string;
      /** そのファイルに 1 度も現れないはずの語。 */
      readonly absentToken: string;
    }
  | {
      readonly kind: "在るが関係が無い";
      /** 在るはずの語。 */
      readonly presentToken: string;
      /** `presentToken` と同じ行には現れないはずの語。 */
      readonly unrelatedToken: string;
    }
);

export type ScopeVerdict =
  | { readonly claim: ScopeClaim; readonly status: "裏が取れた"; readonly detail: string }
  | { readonly claim: ScopeClaim; readonly status: "反証された"; readonly detail: string }
  | { readonly claim: ScopeClaim; readonly status: "確かめられない"; readonly detail: string };

export type ScopeAudit = {
  readonly violations: readonly string[];
  readonly verdicts: readonly ScopeVerdict[];
  readonly counts: Readonly<Record<ScopeVerdict["status"], number>>;
};

/** 宣言が始まる行を探す。`theorem` / `def` などの直後にその名前が来る行。 */
const declarationLine = (source: string, declaration: string): number => {
  const lines = source.split("\n");
  const pattern = new RegExp(
    String.raw`^\s*(?:@\[[^\]]*\]\s*)?(?:private\s+|protected\s+|noncomputable\s+|scoped\s+)*` +
      String.raw`(?:theorem|lemma|def|abbrev|instance|structure)\s+` +
      declaration.replace(/[.*+?^${}()|[\]\\]/g, String.raw`\$&`) +
      String.raw`(?![A-Za-z0-9_'])`,
  );
  return lines.findIndex((line) => pattern.test(line));
};

/**
 * 宣言より前の `variable` 行（と宣言自身の署名）に、その仮定が現れるか。
 * **仮定は宣言行ではなく `variable` 行に書かれているのが普通である**ので、両方を見る。
 */
const scopeRequires = (source: string, declaration: string, token: string): boolean => {
  const lines = source.split("\n");
  const index = declarationLine(source, declaration);
  if (index < 0) return false;
  // 宣言の署名は `:=` か本文が始まるまで続きうるので、数行先まで見る。
  const signature = lines.slice(index, index + 6).join("\n");
  if (signature.includes(token)) return true;
  return lines.slice(0, index).some((line) => line.trimStart().startsWith("variable") && line.includes(token));
};

export const auditScopeClaims = (input: {
  readonly claims: readonly ScopeClaim[];
  /** mathlib の相対パスからファイルの中身を返す。無ければ `undefined`。 */
  readonly readMathlibFile: (path: string) => string | undefined;
  /** ある語を含む行を mathlib 全体から集める。mathlib が無ければ `undefined`。 */
  readonly grepMathlib: ((token: string) => readonly string[]) | undefined;
}): ScopeAudit => {
  const violations: string[] = [];
  const verdicts: ScopeVerdict[] = [];
  const counts: Record<ScopeVerdict["status"], number> = {
    裏が取れた: 0,
    反証された: 0,
    確かめられない: 0,
  };

  const record = (verdict: ScopeVerdict) => {
    verdicts.push(verdict);
    counts[verdict.status] += 1;
    if (verdict.status !== "反証された") return;
    violations.push(`[射程の主張が反証された] ${verdict.claim.entry} — ${verdict.detail}`);
  };

  for (const claim of input.claims) {
    if (claim.kind === "在るが関係が無い") {
      if (input.grepMathlib === undefined) {
        record({ claim, status: "確かめられない", detail: "mathlib がこの作業ツリーに無い" });
        continue;
      }
      const hits = input.grepMathlib(claim.presentToken);
      if (hits.length === 0) {
        record({
          claim,
          status: "反証された",
          detail: `\`${claim.presentToken}\` が mathlib に 1 件も無い（在ることを前提にした主張なのに在らない）`,
        });
        continue;
      }
      const together = hits.filter((line) => line.includes(claim.unrelatedToken));
      if (together.length > 0) {
        record({
          claim,
          status: "反証された",
          detail:
            `\`${claim.presentToken}\` と \`${claim.unrelatedToken}\` が同じ行に現れる箇所が ` +
            `${together.length} 件ある（無いと書いてある）`,
        });
        continue;
      }
      record({
        claim,
        status: "裏が取れた",
        detail: `\`${claim.presentToken}\` は ${hits.length} 行に在るが、\`${claim.unrelatedToken}\` と同じ行は 0 件`,
      });
      continue;
    }

    const source = input.readMathlibFile(claim.file);
    if (source === undefined) {
      record({ claim, status: "確かめられない", detail: `mathlib の ${claim.file} を読めない` });
      continue;
    }

    if (claim.kind === "在るが概念を使っていない") {
      const count = source.split(claim.absentToken).length - 1;
      if (count > 0) {
        record({
          claim,
          status: "反証された",
          detail: `${claim.file} に \`${claim.absentToken}\` が ${count} 件ある（1 度も使っていないと書いてある）`,
        });
        continue;
      }
      record({
        claim,
        status: "裏が取れた",
        detail: `${claim.file} は在るが \`${claim.absentToken}\` が 0 件`,
      });
      continue;
    }

    if (declarationLine(source, claim.declaration) < 0) {
      record({
        claim,
        status: "反証された",
        detail: `${claim.file} に \`${claim.declaration}\` の宣言が見つからない（在ることを前提にした主張である）`,
      });
      continue;
    }
    const missing = claim.requires.filter((token) => !scopeRequires(source, claim.declaration, token));
    if (missing.length > 0) {
      record({
        claim,
        status: "反証された",
        detail:
          `\`${claim.declaration}\` の場所が ${missing.map((t) => `\`${t}\``).join("・")} を要求していない` +
          `（要求すると書いてある）`,
      });
      continue;
    }
    record({
      claim,
      status: "裏が取れた",
      detail: `\`${claim.declaration}\` は ${claim.requires.map((t) => `\`${t}\``).join("・")} の下にある`,
    });
  }

  return { violations, verdicts, counts };
};

/**
 * **射程の主張の台帳。**
 *
 * 初期値は cycle 32 step 4 の実測（mathlib `520045ab14`）。
 * cycle 31 step 4 が「人の読みに依ったまま」と数えた 4 件のうち、
 * **3 件をこの形へ落とせた**。落とせなかった 1 件は下の doc に理由を書く。
 */
export const SCOPE_CLAIMS: readonly ScopeClaim[] = [
  {
    entry: "paper_046_theorem_wstar_different / 可換環の上の Euler の双対基底公式",
    kind: "宣言が仮定を要求する",
    file: "Mathlib/RingTheory/Trace/Basic.lean",
    declaration: "Module.Basis.traceDual",
    requires: ["[Algebra.IsSeparable K L]", "[FiniteDimensional K L]"],
    why:
      "本論文が要るのは可換環の上のトレース双対である。mathlib の `traceDual` は在るが、" +
      "分離性と有限次元性（したがって体）の下にあるので、$\\rho$ が可約な場合に届かない。" +
      "**台帳は「宣言行で直読した」と書いていたが、実際に仮定を持っているのは節の `variable` 行である**" +
      "（cycle 32 step 4 の実測で分かった。主張の中身は変わらない）。",
  },
  {
    entry: "paper_031_theorem_lsw / 多変数の Mahler 測度（解析側）",
    kind: "在るが概念を使っていない",
    file: "Mathlib/Analysis/Polynomial/MahlerMeasure.lean",
    absentToken: "MvPolynomial",
    why: "本論文が要るのは 2 変数のスペクトル曲線の Mahler 測度である。このファイルは 1 変数しか扱わない。",
  },
  {
    entry: "paper_031_theorem_lsw / 多変数の Mahler 測度（数論側）",
    kind: "在るが概念を使っていない",
    file: "Mathlib/NumberTheory/MahlerMeasure.lean",
    absentToken: "MvPolynomial",
    why: "上と同じ。$\\mathbb{Z}[X]$ 側のファイルも 1 変数しか扱わない。",
  },
  {
    entry: "paper_043b_theorem_trace_bound / 単因子の整除の鎖",
    kind: "在るが関係が無い",
    presentToken: "smithCoeffs",
    unrelatedToken: "∣",
    why:
      "本論文が引くのは単因子の整除の鎖 $a_1\\mid a_2\\mid\\cdots$ である。" +
      "`Ideal.smithCoeffs`（適合基底の係数）は在るが、係数どうしの整除を述べた箇所が無い。" +
      "**cycle 29 step 1 はこの一点を読みだけで判断していた**（走査ログが残っていないと台帳が自ら書いている）。" +
      "ここで機械の側へ移した。",
  },
];
