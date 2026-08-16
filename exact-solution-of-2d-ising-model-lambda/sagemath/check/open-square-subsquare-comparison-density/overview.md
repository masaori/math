# SageMath Check: 開境界正方形と部分正方形の比較による密度の挟み込み（Λ_Q 版。q は 1 以下）

## 対象

**対象ラベル**: `claim_open_square_subsquare_comparison_density_le_one`

- 実行日: 2026-08-16
- 状態: PASS（形 $(a,L)\in\{(1,2),(1,3),(2,3)\}$ × 有理点 6 点。
  各組で準備の第一 1 件・第二 3 件・第三 6 件・第四 6 件・本体 6 件、合計 396 件。所要 4 秒）
- 帰属: `ZZ`/`QQ` と素因数分解、有限台辞書の厳密計算。浮動小数点は使わない（主張は $\Lambda_{\mathbb Q}$ で閉じている）。
- 形は一辺 4 以上を含めない（$4\times4$ の配位和は 10 分を超える。実測 2026-08-16）。
- $\le_{\Lambda_{\mathbb Q}}$ の決定手続きの共通分母は、各素数での値の分母の**最小公倍数**を取る
  （`def_rational_log_order_group_order` は「ある共通分母で」と「すべての共通分母で」が同値なので、どの共通分母でもよい。
  分母の積を取ると台の素数が十数個あるとき $\mathrm{rat}_\Lambda$ の冪の指数が $10^{14}$ 程度になり計算が終わらない——実測 2026-08-16、10 分超）。

## 検査内容

形 $(a,L)$ と正の有理数 $q\in\{1/10,1/3,1/2,2/3,9/10,1\}$（主張の範囲 $0<q\le1$）について、$n:=L^2-a^2$ とし、

- 準備の第一: $Z^{\mathrm{op}}_{a,a}(q),Z^{\mathrm{op}}_{L,L}(q)\in\mathbb Q_{>0}$
  （$\mathbb Z[x]$ の開境界分配多項式への代入が配位ごとの和と一致することも見る）、$a^2\ne0$、$L^2\ne0$。
- 準備の第二: $\frac1{L^2}\cdot\iota(\log Z^{\mathrm{op}}_{a,a}(q))=\frac{a^2}{L^2}\cdot\Psi^{\mathrm{op}}_a(q)$ の三段
  （$\mathbb Q$ の約分 $\frac{a^2}{L^2}\cdot\frac1{a^2}=\frac1{L^2}$ の逆向き・有理数倍の結合則・密度の定義）を $\Lambda_{\mathbb Q}$ の有限台辞書の等号で一段ずつ。
- 準備の第三（下からの評価の側）: $\frac1{L^2}\cdot\iota((a+L)\log q+\log Z^{\mathrm{op}}_{a,a}(q))=\frac{a+L}{L^2}\cdot\iota(\log q)+\frac{a^2}{L^2}\cdot\Psi^{\mathrm{op}}_a(q)$ の六段
  （$\iota$ の加法性・分配則・$n\cdot\iota(\nu)=\iota(n\nu)$ の逆向き・結合則・$\mathbb Q$ の積・準備の第二）。
- 準備の第四（上からの評価の側）: $\frac1{L^2}\cdot\iota(n\ell_2+2n\log(1+q)+\log Z^{\mathrm{op}}_{a,a}(q))
  =\frac{L^2-a^2}{L^2}\cdot\iota(\ell_2)+\frac{2(L^2-a^2)}{L^2}\cdot\iota(\log(1+q))+\frac{a^2}{L^2}\cdot\Psi^{\mathrm{op}}_a(q)$ の六段
  （加法性二回・分配則二回・$n\cdot\iota(\nu)=\iota(n\nu)$ を二項へ同時・結合則を二項へ同時・$\mathbb Q$ の積・準備の第二）。
- 本体: $\frac{a+L}{L^2}\cdot\iota(\log q)+\frac{a^2}{L^2}\cdot\Psi^{\mathrm{op}}_a(q)\le_{\Lambda_{\mathbb Q}}\Psi^{\mathrm{op}}_L(q)\le_{\Lambda_{\mathbb Q}}(\text{上の形})$。
  $\le_{\Lambda_{\mathbb Q}}$ は決定手続きで判定し、加えて `claim_scaled_embedding_order_transfer` の移送（$N=L^2$、証人は $\Lambda$ の元そのもの）が
  `claim_open_square_subsquare_comparison_log_le_one` の $\Lambda$ の比較と一致することも各段で見る。

有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

## Lean

具体版 `scaled_subsquareBlockDensity_eq`（準備の第二）・`scaled_subsquareLowerForm_eq`（準備の第三）・`scaled_subsquareUpperForm_eq`（準備の第四）・
`rationalLogOrderLE_openSquareSubsquareDensity_bounds_of_le_one`（本体）
（`lean/Ising2DLambda/ThermodynamicLimit/OpenSquareSubsquareComparisonDensity.lean`。
`claim_open_square_subsquare_comparison_log_le_one` の Lean と `rationalLogOrderLE_scaled_toRational_iff L` の ← から組む）。
必要十分版は `twoSided_bounds_transport_through_monotone_map_necSuf`
（`lean/Ising2DLambda/NecSuf/ThermodynamicLimit/OpenSquareBlockTilingLog.lean`）をそのまま共有し、
導出版 `rationalLogOrderLE_openSquareSubsquareDensity_bounds_of_le_one_from_necSuf`
（`OpenSquareSubsquareComparisonDensityFromNecSuf.lean`。`ell := λ ↦ (1/L²)·ι(λ)` で特殊化）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-subsquare-comparison-density/check.sage
```
