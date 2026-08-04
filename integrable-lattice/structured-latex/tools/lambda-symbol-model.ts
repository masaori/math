/**
 * **対数順序群の記号の検査（検査 Λ）の型と判定**。
 *
 * ## なぜこの検査が要るのか
 *
 * 2026-08-04 のユーザー判断: **記号 $\Lambda$ は対数順序群にのみ使う。**
 *
 * cycle 29 step 4 の走査で、この記号が別の 3 つの量にも使われていることが見つかっていた
 * （例外直線の $\lambda$ の和 ／ $\min_{j\ge0}(e_j+j\ell^r)$ ／ $\min_m v_\ell(A^{[k]}_m)$）。
 * **定義の順序としては正しかったので、既存の検査はどれも赤くならなかった。**
 * 中心概念の記号が別の量を指していても機械が黙っている、という穴である。
 * cycle 31 step 2 で 3 つとも改名し、同じことが起きないようにこの検査を入れた。
 *
 * ## 何を見るか（3 つ。どれも「意味」ではなく「形」を見る）
 *
 * 意味は機械に読めないので、**衝突が実際に起きたときの形**を 3 つとも塞ぐ。
 * 3 つは、現に起きた 3 件の起き方から逆算したものである（原理から出たものではない）。
 *
 * 1. **飾りを付けない。** $\Lambda_k$ / $\Lambda^k$ / $\Lambda(r)$ のように添字・肩・引数を付けた形は、
 *    対数順序群ではない別の対象を指している。実際、3 件のうち 2 件がこの形だった
 *    （$\Lambda_k$ と $\Lambda(r)$）。対数順序群は本文の全用例で裸で書かれている。
 * 2. **定義し直さない。** `\Lambda:=` の形は、その場で新しい対象を導入している。
 *    3 件のうち残る 1 件（$\Lambda:=\sum_{\text{例外直線}}\lambda$）はこの形だった。
 *    対数順序群を定義する当のブロックだけがこれを書いてよい。
 * 3. **使ってよいブロックを台帳で持つ。** 新しいブロックがこの記号を使い始めたら、
 *    理由を書いて登録するまで赤くする。1 と 2 を通り抜ける形の再発を、人の目に乗せるため。
 *
 * ## 機械が確かめられないこと（正直に書く）
 *
 * - **既に登録されているブロックの中で、裸の $\Lambda$ を別の量に使うことは止められない。**
 *   「この $\Lambda$ は対数順序群か」は本文を読む判断である。
 *   止められるのは、飾りを付けた形・定義し直す形・新しいブロックで使い始める形の 3 つだけ。
 * - **3 つの形は、現に起きた 3 件から逆算した規則である。** 別の起き方は拾えない。
 */

export type LambdaUseSite = {
  readonly blockId: string;
  readonly locale: string;
  readonly file: string;
  /** その出現を含む数式（tex）。 */
  readonly tex: string;
};

/** この記号を使ってよいブロックの台帳。 */
export type LambdaAllowance = {
  readonly block: string;
  /** なぜこのブロックが対数順序群に言及するのか。 */
  readonly reason: string;
  /** 対数順序群そのものを定義するブロックだけ true。`\Lambda:=` を書いてよい。 */
  readonly defines?: true;
};

export type LambdaAudit = {
  readonly violations: readonly string[];
  readonly siteCount: number;
  readonly blockCount: number;
  /** 台帳にあるのに 1 度も使われなくなったブロック（登録が古い）。 */
  readonly unusedAllowances: readonly string[];
};

/** 飾り（添字・肩・引数）を付けた形。`\Lambda` の直後だけを見る。 */
const DECORATED = /\\Lambda\s*(?<mark>[_^]|\()/;
/** その場で定義し直す形。 */
const REDEFINED = /\\Lambda\s*:=/;

export const auditLambdaSymbol = (input: {
  readonly sites: readonly LambdaUseSite[];
  readonly allowances: readonly LambdaAllowance[];
}): LambdaAudit => {
  const violations: string[] = [];
  const byBlock = new Map(input.allowances.map((a) => [a.block, a] as const));
  const usedBlocks = new Set<string>();

  for (const site of input.sites) {
    usedBlocks.add(site.blockId);
    const allowance = byBlock.get(site.blockId);

    if (allowance === undefined) {
      violations.push(
        `[台帳に無いブロックが記号を使っている] ${site.locale} / ${site.blockId}（${site.file}）— ` +
          `記号 \\Lambda は対数順序群にのみ使う。対数順序群のことなら理由を書いて台帳へ登録し、` +
          `別の量なら別の記号へ改名すること。数式: ${site.tex.slice(0, 60)}`,
      );
      continue;
    }

    const decorated = DECORATED.exec(site.tex);
    if (decorated !== null) {
      violations.push(
        `[記号に飾りが付いている] ${site.locale} / ${site.blockId} — ` +
          `\\Lambda${decorated.groups?.mark} の形は対数順序群ではない別の対象を指している。` +
          `別の記号へ改名すること。数式: ${site.tex.slice(0, 60)}`,
      );
    }

    if (REDEFINED.test(site.tex) && allowance.defines !== true) {
      violations.push(
        `[記号を定義し直している] ${site.locale} / ${site.blockId} — ` +
          `\\Lambda:= の形はその場で新しい対象を導入している。` +
          `対数順序群を定義してよいのは台帳で defines を宣言したブロックだけである。` +
          `数式: ${site.tex.slice(0, 60)}`,
      );
    }
  }

  const unusedAllowances = input.allowances
    .map((a) => a.block)
    .filter((block) => !usedBlocks.has(block));
  for (const block of unusedAllowances) {
    violations.push(
      `[登録が古い] ${block} — 台帳にあるが、この記号を 1 度も使っていない（登録を消すこと）`,
    );
  }

  return {
    violations,
    siteCount: input.sites.length,
    blockCount: usedBlocks.size,
    unusedAllowances,
  };
};
