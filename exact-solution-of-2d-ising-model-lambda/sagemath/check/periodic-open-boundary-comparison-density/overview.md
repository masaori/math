# SageMath Check: 周期境界と開境界の密度の比較（Λ_Q 版。q は 1 以下）

## 対象

**対象ラベル**: `claim_periodic_open_boundary_comparison_density_le_one`

- 実行日: 2026-08-17
- 状態: PASS（$L\in\{1,2,3\}$ × 有理点 6 点、252 検査。所要 3 秒程度）
- 帰属: `ZZ`/`QQ` と素因数分解、有限台辞書による厳密計算。浮動小数点は使わない
  （主張は $\Lambda_{\mathbb{Q}}$ で閉じており、実数体も実対数も現れない）。

## 検査内容

証明の段ごとに検査する。

- **準備の第一**: $Z_L(q),Z^{\mathrm{op}}_{L,L}(q)\in\mathbb{Q}_{>0}$、$L\ne0$、$L^2\ne0$。
- **準備の第二** 七段: $\frac{1}{L^2}\cdot\iota(2L\log q+\log Z^{\mathrm{op}}_{L,L}(q))$ を
  $\iota$ の加法性・有理数倍の分配則・$n\cdot\iota(\nu)=\iota(n\nu)$・結合則・$\mathbb{Q}$ の約分
  $\frac{1}{L^2}\cdot2L=\frac{2}{L}$・密度の定義・加法の可換性で
  $\Psi^{\mathrm{op}}_L(q)+\frac{2}{L}\cdot\iota(\log q)$ へ整える各段を $\Lambda_{\mathbb{Q}}$ の有限台辞書の等号で。
- **本体**: 左右の不等式を `def_rational_log_order_group_order` の決定手続き（共通分母 $N$ での証人の
  $\Lambda$ の比較）で判定し、`claim_scaled_embedding_order_transfer` の移送（$N=L^2$ を共通分母とする証人の
  $\Lambda$ の比較＝`claim_periodic_open_boundary_comparison_log_le_one` の $\Lambda$ の比較）と一致することも各段で見る。

周期境界の辺は、開境界正方形の辺と $2L$ 本の境界横断辺の和として組み立てる（`periodic-open-boundary-comparison-log` と同じ模型）。
有理点は $\{1/10,1/3,1/2,2/3,9/10,1\}$（主張の範囲 $0<q\le1$）。

## 検査できないこと（黙って広げない）

有限標本検査であり、すべての $L,q$ についての主張の証明ではない。一般の証明は Lean 具体版
`ThermodynamicLimit/PeriodicOpenComparisonDensity.lean`（`rationalLogOrderLE_periodicOpenDensity_bounds_of_le_one` と準備の等式 `scaled_periodicOpenLowerForm_eq`）、
必要十分版は「開境界正方形のブロック敷き詰め評価の対数化」の `twoSided_bounds_transport_through_monotone_map_necSuf` を共有、
導出版 `PeriodicOpenComparisonDensityFromNecSuf.lean`。

## 実行方法

```sh
sage sagemath/check/periodic-open-boundary-comparison-density/check.sage
```
