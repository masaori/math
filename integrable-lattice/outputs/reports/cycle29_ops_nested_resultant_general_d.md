# 周期点数の終結式表示を一般の $d$ で形式化した（cycle 29 step 3b）

対象は本文 `structured-latex/content/002_setup.ts` の claim
「周期点数は入れ子の終結式で厳密に計算できる」（ラベル `paper_claim_resultant`）である。
Lean は `lean/IntegrableLattice/PeriodicPointResultant.lean` の §3。

## 何が目的だったか

ユーザー方針は論文の主張を全数形式化することである。台帳（検査 F）の「残り」は
**完了でない主張の数**なので、主張を 1 つ完了させない限り減らない。cycle 28 と cycle 29 の
step 1〜3 は形式化の量を増やしたが件数は 19 件のまま動かなかった。この step の目的は
件数を実際に減らすことだけである。

## 壁とされていたものは無かった

cycle 29 step 1 の仕分けは、この claim の残りを次のように書いていた。

> 素材の欠落は無い（`Polynomial.resultant_eq_prod_eval` は mathlib に在る）が、
> 反復多項式環 $R[z_1]\cdots[z_d]$ を $d$ について再帰で作る型
> （型とその環構造を同時に決める）をこちらが持っていない。

**この判定は誤りだった。** 反復多項式環を新しい型として組む必要は無い。$d$ 変数多項式環
`MvPolynomial (Fin d) K` は最初から環であり、そこから変数を 1 つだけ外へ出す同型

```
MvPolynomial.finSuccEquiv :
  MvPolynomial (Fin (d+1)) R ≃ₐ[R] Polynomial (MvPolynomial (Fin d) R)
```

が mathlib に在る（`Mathlib/Algebra/MvPolynomial/Equiv.lean` の 647 行。実測）。
これを $d$ 段回せば「終結式を $d$ 回入れ子にする」がそのまま書ける。
型と環構造を同時に決める問題が生じるのは反復多項式環を新しい型として定義した場合であって、
既にある環から変数を剥がす形にすれば生じない。

**同じ形の誤診断は 4 サイクル連続である**（cycle 27・28、cycle 29 step 1・step 3 が
それぞれ「素材が無い」「型が無い」と書き、後の step が実測で覆した）。
一次情報を引く前に壁の名前を書いていることが原因である。

## 入ったもの

| 名前 | 内容 |
| --- | --- |
| `unityRoots` | $1$ の $L$ 乗根の多重集合（重複度こみ）。$z^L-1$ の根として定義する |
| `peelRes` | 変数 $z_0$ を 1 つ剥がす終結式 $\mathrm{Res}_{z_0}(z_0^L-1,\ P)$。値は残り $d$ 変数の多項式 |
| `nestedRes` | $d$ 重の入れ子の終結式。$d$ についての再帰はこの定義だけで、新しい型は作っていない |
| `rootTuples` | 成分がすべて $1$ の $L$ 乗根であるような $d$ 個組の多重集合 |
| `tupleProdHom` | 本文の左辺 $\prod_{z_1^L=\dots=z_d^L=1}P(z_1,\dots,z_d)$。乗法性を使うのでモノイド準同型として束ねた |
| `eval_cons_eq_eval_eval` | 「$z_0$ に $\zeta$ を代入してから残りを評価」＝「組 $(\zeta,w)$ で一度に評価」 |
| `tupleProdHom_succ` | 組の上の積が、外側 1 変数の積と内側 $d$ 変数の積へ分かれる |
| `peelRes_eq_prod_eval` | **1 段ぶんの中身**。$d=1$ の補題を係数環 $\mathrm{MvPolynomial}(\mathrm{Fin}\,d,K)$ の上で使う |
| `nestedRes_eq_tupleProd` | **claim の一般の $d$ の中身** |
| `nestedRes_two_eq_tupleProd` | 一般形を本文が明示する $d=2$ へ落としたもの |

人手証明との対応は 1 対 1 である。人手証明が使うのは「$z^L-1$ がモニックだから
$\mathrm{Res}(f,g)=\mathrm{lc}(f)^{\deg g}\prod_{f(\alpha)=0}g(\alpha)$ が根での積そのものを与える」
という一点で、それが `peelRes_eq_prod_eval` の中の `resultant_X_pow_sub_one_eq_prod_eval`
（$d=1$ の補題、cycle 29 step 1 が入れたもの）の 1 回の適用にあたる。
人手証明の「一般の $d$ でも終結式を $d$ 回入れ子にすればよい」が、
`nestedRes_eq_tupleProd` の $d$ についての帰納法そのものである。

$z^L-1$ が係数環の上でも分解することと、その根が $K$ の根の像そのものであることは
`Splits.map` と `Splits.roots_map_of_injective`（`MvPolynomial.C` の単射性）で出る。

## 仮定が空でないことを確かめた

定理は「$z^L-1$ が $K$ 上で分解する」という仮定を持つので、満たす例が無ければ空虚に真になる。

- `splits_X_sq_sub_one_rat`: $z^2-1=(z+1)(z-1)$ は $\mathbb{Q}$ の上で分解する。
- `card_unityRoots_two_rat`: そのとき根は $\pm1$ の 2 個。
- `card_rootTuples`: 組の個数は $(\#\mu_L)^d$。
- `nestedRes_rat_two_three`: $\mathbb{Q}$・$L=2$・$d=3$ で定理が成り立ち、積は $2^3=8$ 項を走る。

$\mathbb{R}$ も $\mathbb{C}$ もこのファイルに 1 度も現れない。根が住む体は仮定として受け取るだけで、
代数体に取れば可算側に留まる。

## 被覆の変化

**完了 5・部分的 17・未着手 2（残り 19）→ 完了 6・部分的 16・未着手 2（残り 18）。**
cycle 28 以来はじめて件数が減った。実出力は `structured-latex/logs/check-cycle29-step3b.log`。

## 自分の誤りの記録

- `X_sub_C_ne_zero` の引数を宣言を読まずに推測した（証明を渡したが、実際に取るのは元 $r$ である）。
  結果は elaboration の heartbeat 超過で、原因が分かりにくい形で落ちた。
  **補題の引数を宣言で確かめてから書く、が守れていない**（cycle 29 step 2・step 3 と同じ形）。
- 多重集合の要素数を `rfl` で潰そうとして `whnf` が heartbeat を超えた。`simp` に替えた。

**実在しない mathlib の名前を書いた誤りは今回は無い**（使った名前は宣言行を grep で確認してから書いた。
`finSuccEquiv` 647 行、`resultant_eq_prod_eval` 478 行、`Splits.roots_map_of_injective` 392 行、
`eval_eq_eval_mv_eval'` 709 行、`Polynomial.eval₂_hom` / `eval_map`、
`Multiset.prod_bind` / `map_bind` / `prod_map_mul` / `prod_map_one`、`map_multiset_prod`）。

## 限界

- **「完了」は人の判断である。** 機械が確かめているのは、claim の内容として書き下した等式が
  Lean で証明されていることであって、その等式が本文の claim を汲み尽くしているかではない。
  ここでは、本文が明示する $d=2$ の式と「一般の $d$ でも $d$ 回入れ子にすればよい」の両方に
  対応する定理があることを根拠に完了と判断した。
- 定義ブロック側の主張（$a_L$ が Galois 不変な整数であること、単項式倍で不変であること）は
  この claim の外なので形式化していない。**この判断も人が線を引いたものである。**
- 形式次数を実次数に固定した。人手証明は形式次数を選んでいないので、
  別の形式次数で同じ値になることは述べていない（$d=2$ の §2 は形式次数を引数に持つ形で書いてある）。
