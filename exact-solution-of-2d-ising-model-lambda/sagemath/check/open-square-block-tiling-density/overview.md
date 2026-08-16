# SageMath Check: 開境界正方形のブロック敷き詰め評価による密度の挟み込み（Λ_Q 版）

## 対象

**対象ラベル**: `claim_open_square_block_tiling_density`

- 実行日: 2026-08-16
- 状態: PASS（形 $(a,k)\in\{(1,1),(1,2),(1,3),(2,1)\}$ × 正の有理点 9 点。
  各組で準備の第一 1 件・第二 4 件・第三 6 件・本体 4 件（$q=1$ は両場合で 8 件）、合計 556 件。所要 10 秒）
- 帰属: `ZZ`/`QQ` と素因数分解、有限台辞書の厳密計算。浮動小数点は使わない（主張は $\Lambda_{\mathbb Q}$ で閉じている）。
- 形 $(a,k)=(2,2)$（$4\times4$ の正方形）は、含めると実行が 10 分を超えたので外した（実測 2026-08-16）。
  含める場合は計算を軽くすること。

## 検査内容

形 $(a,k)$ と正の有理数 $q\in\{1/10,1/3,1/2,2/3,1,3/2,22/7,5,11\}$ について、

- 準備の第一: $Z^{\mathrm{op}}_{a,a}(q),Z^{\mathrm{op}}_{ka,ka}(q)\in\mathbb Q_{>0}$
  （$\mathbb Z[x]$ の開境界分配多項式への代入が配位ごとの和と一致することも見る）、$(ka)^2\ne0$。
- 準備の第二（上からの評価の側）: $\frac1{(ka)^2}\cdot\iota(k^2\log Z^{\mathrm{op}}_{a,a}(q))=\Psi^{\mathrm{op}}_a(q)$ の四段
  （$n\cdot\iota(\nu)=\iota(n\nu)$ の逆向き・有理数倍の結合則・$\mathbb Q$ の約分 $\frac{k^2}{k^2a^2}=\frac1{a^2}$・密度の定義）を
  $\Lambda_{\mathbb Q}$ の有限台辞書の等号で一段ずつ。
- 準備の第三（下からの評価の側）: $\frac1{(ka)^2}\cdot\iota(2k(k-1)a\log q+k^2\log Z^{\mathrm{op}}_{a,a}(q))
  =\frac{2(k-1)}{ka}\cdot\iota(\log q)+\Psi^{\mathrm{op}}_a(q)$ の六段
  （$\iota$ の加法性・有理数倍の分配則・$n\cdot\iota(\nu)=\iota(n\nu)$ の逆向き・結合則・約分 $\frac{2k(k-1)a}{k^2a^2}=\frac{2(k-1)}{ka}$・準備の第二）。
- 本体: $0<q\le1$ で $\frac{2(k-1)}{ka}\cdot\iota(\log q)+\Psi^{\mathrm{op}}_a(q)\le_{\Lambda_{\mathbb Q}}\Psi^{\mathrm{op}}_{ka}(q)\le_{\Lambda_{\mathbb Q}}\Psi^{\mathrm{op}}_a(q)$、
  $1\le q$ でその反転。$\le_{\Lambda_{\mathbb Q}}$ は `def_rational_log_order_group_order` の決定手続き
  （分母の積を共通分母にした証人の $\Lambda$ の比較）で判定し、加えて `claim_scaled_embedding_order_transfer` の移送
  （$N=(ka)^2$、証人は $\Lambda$ の元そのもの）が `claim_open_square_block_tiling_log` の $\Lambda$ の比較と一致することも各段で見る。

有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

## Lean

具体版 `scaled_blockTilingUpperForm_eq`（準備の第二）・`scaled_blockTilingLowerForm_eq`（準備の第三）・
`rationalLogOrderLE_openSquareBlockTilingDensity_bounds_of_le_one`／`_of_one_le`（本体の二場合）
（`lean/Ising2DLambda/ThermodynamicLimit/OpenSquareBlockTilingDensity.lean`。
`claim_open_square_block_tiling_log` の Lean と `rationalLogOrderLE_scaled_toRational_iff (k*a)` の ← から組む。
`NeZero (k*a)` は `[NeZero a] [NeZero k]` から。$k-1$ は自然数のまま扱う）。
必要十分版は `twoSided_bounds_transport_through_monotone_map_necSuf`
（`lean/Ising2DLambda/NecSuf/ThermodynamicLimit/OpenSquareBlockTilingLog.lean`）をそのまま共有し、
導出版 `rationalLogOrderLE_openSquareBlockTilingDensity_bounds_of_le_one_from_necSuf`／`_of_one_le_from_necSuf`
（`OpenSquareBlockTilingDensityFromNecSuf.lean`。`ell := λ ↦ (1/(ka)²)·ι(λ)` で特殊化。二場合は `lower`・`upper` の入れ替え）。

## 実行方法

```sh
cd exact-solution-of-2d-ising-model-lambda
sage sagemath/check/open-square-block-tiling-density/check.sage
```
