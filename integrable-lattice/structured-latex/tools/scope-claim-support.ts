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
    entry: "整数行列の Smith 標準形（適合基底の形）",
    kind: "在るが概念を使っていない",
    file: "Mathlib/LinearAlgebra/FreeModule/PID.lean",
    absentToken: "elementaryDivisor",
    why:
      "本論文の本文は $w^*$ を「Smith 標準形の最後の対角成分 $e_r$ の $p$ 進付値」と書いている。" +
      "mathlib には適合基底の版（`Submodule.smithNormalForm` ほか）が在るが、" +
      "**係数どうしの整除の鎖（単因子）は無い。** " +
      "**cycle 49 step 2 で登録した**——同 step の走査で、`smithCoeffs` を含む行のうち整除を述べているものが" +
      "0 件、`elementary divisor` も `invariant factor` も 3 段とも 0 件であることを測った" +
      "（`lean/logs/mathlib-gap-survey-cycle49-smith-chain.log`）。" +
      "**それでも本論文はこれを要さない**——鎖を仮定として受け取れば、" +
      "$v_p(e_r)$ が内在的な最小元に一致することが言える" +
      "（`PropCElementaryDivisorChain.wStarOfCoeffs_eq_factorization_last`）。",
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
    entry: "paper_052_theorem_l0_computable / $d$ 変数の完備群環（岩澤代数）",
    kind: "在るが概念を使っていない",
    file: "Mathlib/NumberTheory/Padics/Measure/Basic.lean",
    absentToken: "MvPowerSeries",
    why:
      "本論文が要るのは $d$ 変数の完備群環 $\\mathbb{F}_p[[\\Gamma]]$ とその素イデアルの記述である。" +
      "mathlib で `iwasawa algebra` の語に当たるのは $p$ 進測度の章のこのファイルだけで、" +
      "**多変数の形式冪級数を 1 度も使っていない**（1 変数の測度である）。" +
      "**cycle 33 step 4 で登録した**——この主張は cycle 32 の時点で「射程の主張」に数えられていたのに" +
      "登録されておらず、人の読みのままだった（登録の網羅性が測れないことの実例である）。",
  },
  {
    entry: "paper_051_theorem_duality / 多変数の Mahler 測度（双対命題 D の側）",
    kind: "在るが概念を使っていない",
    file: "Mathlib/Analysis/Polynomial/MahlerMeasure.lean",
    absentToken: "MvPolynomial",
    why:
      "双対命題 D のアルキメデス側は 2 変数のスペクトル曲線の Mahler 測度を要する。" +
      "命題 LSW と同じ不足だが、**エントリが別なので登録も別に要る**。" +
      "**cycle 34 step 4 で登録した**——台帳の地の文は「mathlib の Mahler 測度は 1 変数だけで" +
      "多変数が無い」と書いていたのに、射程の主張として登録されていなかった。" +
      "**これは「射程の主張」と分類される手前で取りこぼしていた実例である。**",
  },
  {
    entry: "Monsky の p 進冪級数の定理 / 岩澤代数の一般論",
    kind: "在るが概念を使っていない",
    file: "Mathlib/NumberTheory/Padics/Measure/Basic.lean",
    absentToken: "MvPowerSeries",
    why:
      "本論文が要るのは岩澤代数の一般論である。台帳は「mathlib には `PowerSeries` の" +
      "断片としてしか無い」と地の文で書いていたが、登録が無かった。" +
      "**cycle 34 step 4 で登録した**（同じ不足を 命題 F の側では登録済みだったので、" +
      "**同じ事柄について片方だけ登録されていた**ことになる）。",
  },
  {
    entry: "Newton 多面体の加法性（Ostrowski の定理） / 頂点を取り出す道",
    kind: "宣言が仮定を要求する",
    file: "Mathlib/Analysis/Convex/KreinMilman.lean",
    declaration: "closure_convexHull_extremePoints",
    requires: ["[Module ℝ E]", "[TopologicalSpace E]", "[T2Space E]"],
    why:
      "凸包を頂点の凸包へ落とす標準の道は Krein–Milman である。mathlib に在るが、" +
      "節の `variable` 行が $\\mathbb{R}$ 上の加群であることと位相を要求する（2026-08-05 実測）。" +
      "**本論文が要るのは有限個の格子点の凸包なので、これを使うと主張は可算側にあるのに証明が $\\mathbb{R}$ へ出る。** " +
      "cycle 39 step 1 はこれを使わず、「頂点でない点は中点として書ける」という組合せの事実で代えた。",
  },
  {
    entry: "paper_062_theorem_T / 円分体の完備化への Hensel の配線",
    kind: "在るが関係が無い",
    presentToken: "Henselian",
    unrelatedToken: "cyclotomic",
    why:
      "命題 T の 2 の不分岐性は Hensel の持ち上げを円分体の完備化で使う。" +
      "台帳は「Hensel は mathlib に在るが円分体の完備化への配線が無い」と地の文で書いていたが、" +
      "登録が無かった。**cycle 34 step 4 で登録した**。" +
      "2026-08-05 実測で、`Henselian` と `cyclotomic` が同じ行に現れる箇所は 0 件である。" +
      "**cycle 42 step 2 で機構の名前で引き直した。判定は変わらないが、射程が狭まった。そう書く**——" +
      "この段が要求しているのは円分体の完備化そのものではなく、" +
      "「Hensel 的な局所環で、剰余体が原始 $L$ 乗根を持つこと」だけである。" +
      "その舞台を仮定として受け取れば段 3 の中身は完備化を経由せずに書ける" +
      "（`PropTHenselLift.lean`）。**配線が要るのは段 3 の全部ではなく舞台の構成だけである。** " +
      "同じ実測で `HenselianLocalRing` のインスタンスがこの版の mathlib に 1 つも無いことも確かめた" +
      "（`Mathlib/RingTheory/Henselian.lean` 以外のどのファイルもこの class を実装していない）。",
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

/* ------------------------------------------------------------------------- *
 * 分類の手前の取りこぼしを拾う（cycle 34 step 4）
 * ------------------------------------------------------------------------- */

/**
 * **登録の網羅性を、台帳の地の文の側から測る。**
 *
 * cycle 33 step 4 は「射程の主張」と分類済みなのに未登録だったものを 1 件拾えたが、
 * 総括はこう書いていた——**分類の手前で取りこぼしているものは、依然として人の読みのままである。**
 * ここがその穴を狭める仕組みである。
 *
 * 考え方は単純で、**分類を待たずに台帳の文そのものを読む**。
 * 「mathlib に在るが足りない」と地の文で言っているのに登録が無ければ、
 * それは分類の手前で取りこぼしている射程の主張である。
 *
 * ## 目印は実測から決めた（原理から出したものではない）
 *
 * 下の語は、**現に台帳にある射程の主張の文から拾った**（検査 Λ の 3 規則・
 * 射程の 3 形と同じ立て方である）。文の単位で見て、
 * **`mathlib` の語と目印の両方を含む文**だけを射程の主張の候補とする。
 * 語だけで拾うと「Cauchy–Binet と全単模性だけから出る」のような無関係な文まで当たる
 * （実測で 16 件当たり、そのうち射程の主張は 4 件だった。だから文の単位にした）。
 *
 * ## 何を違反にするか
 *
 * 候補に挙がったエントリが `SCOPE_CLAIMS` に登録されていなければ違反にする。
 * **登録するか、なぜ射程の主張でないのかを免除として書くか、のどちらかを要求する。**
 * 免除は件数を毎回印字するので、黙って増やせない。
 *
 * ## 機械が確かめられないこと（正直に書く）
 *
 * - **目印に当たらない書き方をすれば、この検査は素通りする。** 網羅性は測れないままである。
 *   狭めたのであって塞いだのではない。
 * - 目印に当たったからといって射程の主張とは限らない（免除の口があるのはそのためである）。
 */
export const SCOPE_CLAIM_MARKERS: readonly string[] = [
  "しか無い",
  "しかない",
  "在るが",
  "あるが",
  "断片",
  "届かない",
  "体の上にしか",
  "1 変数",
  "要求する",
];

/** 目印に当たるが射程の主張ではないもの。**理由を書く**（黙って除外できない）。 */
export const SCOPE_CLAIM_EXEMPTIONS: readonly { readonly entry: string; readonly why: string }[] =
  [];

/** 目印に当たる文を取り出す。`mathlib` の語と目印の両方を含む文だけを返す。 */
export function scopeClaimSentences(text: string): string[] {
  return text
    .split(/。/)
    .filter((s) => s.includes("mathlib") && SCOPE_CLAIM_MARKERS.some((m) => s.includes(m)));
}

/** 候補の判定。IO を持たないので検出テストからそのまま呼べる。 */
export function auditScopeClaimCoverage(input: {
  readonly entries: readonly { readonly name: string; readonly text: string }[];
  readonly registered: readonly string[];
  readonly exemptions: readonly { readonly entry: string; readonly why: string }[];
}): { violations: string[]; candidates: number; exempted: number } {
  const violations: string[] = [];
  let candidates = 0;
  let exempted = 0;
  for (const entry of input.entries) {
    const sentences = scopeClaimSentences(entry.text);
    if (sentences.length === 0) continue;
    candidates += 1;
    const isRegistered = input.registered.some(
      (r) => entry.name.startsWith(r) || r.startsWith(entry.name),
    );
    if (isRegistered) continue;
    if (input.exemptions.some((e) => e.entry === entry.name)) {
      exempted += 1;
      continue;
    }
    violations.push(
      `[射程の主張が未登録] ${entry.name} — ` +
        `台帳が「${sentences[0]!.trim().slice(0, 60)}」と書いているのに登録が無い`,
    );
  }
  return { violations, candidates, exempted };
}
