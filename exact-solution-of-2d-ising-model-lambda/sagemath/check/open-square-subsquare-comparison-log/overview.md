# SageMath Check: 開境界正方形と部分正方形の比較の対数化（Λ の鎖。q は 1 以下）

## 対象

**対象ラベル**: `claim_open_square_subsquare_comparison_log_le_one`

- 実行日: 2026-08-16
- 状態: PASS（形 $(a,L)\in\{(1,2),(1,3),(2,3)\}$ × 有理点 6 点、216 検査。所要 4 秒程度（初回起動込みで 1 分））
- 帰属: `ZZ`/`QQ` と素因数分解、有限台辞書による厳密計算。浮動小数点は使わない
  （主張は $\Lambda$ で閉じており、実数体も実対数も現れない）。

## 検査内容

証明の段ごとに検査する（$n:=L^2-a^2$）。

- **準備の第一**: $Z^{\mathrm{op}}_{a,a}(q),Z^{\mathrm{op}}_{L,L}(q)\in\mathbb{Q}_{>0}$
  （$\mathbb{Z}[x]$ の開境界分配多項式への代入と配位和の一致も見る）、両端の値 $q^{a+L}Z^{\mathrm{op}}_{a,a}(q)$、
  $2^{n}(1+q)^{2n}Z^{\mathrm{op}}_{a,a}(q)$ が $\mathbb{Q}_{>0}$ の元であること。
- **準備の第二**: $\log2=\ell_2$（有限台辞書 $\{2\mapsto1\}$）。
- **準備の第三（前半）** 二段: `claim_log_additive`・`claim_log_power`（$k:=a+L$）を $\Lambda$ の有限台辞書の等号で。
  **後半** 四段: `claim_log_additive`・`claim_log_additive`・`claim_log_power`（$k:=n$ と $k:=2n$ を二項へ同時適用）・準備の第二。
- **本体**: $(a+L)\log q+\log Z^{\mathrm{op}}_{a,a}(q)=\log(\text{下端の値})\le_\Lambda\log Z^{\mathrm{op}}_{L,L}(q)\le_\Lambda\log(\text{上端の値})=n\ell_2+2n\log(1+q)+\log Z^{\mathrm{op}}_{a,a}(q)$。
  $\le_\Lambda$ は $\mathrm{rat}_\Lambda$ を通した $\mathbb{Q}$ の比較（`def_log_order_group_order`）で判定し、
  `claim_rational_log_order_iff` の移送（`claim_open_square_subsquare_comparison_rational_le_one` の $\mathbb{Q}$ の比較と一致すること）も各段で見る。

形は一辺 4 以上を含めない（$4\times4$ の配位和は 10 分を超える）。有理点は $\{1/10,1/3,1/2,2/3,9/10,1\}$（主張の範囲 $0<q\le1$）。

## 検査できないこと（黙って広げない）

有限標本検査であり、すべての $a,L,q$ についての主張の証明ではない。一般の証明は Lean 具体版
`ThermodynamicLimit/OpenSquareSubsquareComparisonLog.lean`（`logOrderLE_openSquareSubsquareLog_bounds_of_le_one` と準備の等式 2 本）、
必要十分版は「開境界正方形のブロック敷き詰め評価の対数化」の `twoSided_bounds_transport_through_monotone_map_necSuf` を共有、
導出版 `OpenSquareSubsquareComparisonLogFromNecSuf.lean`。

## 実行方法

```sh
sage sagemath/check/open-square-subsquare-comparison-log/check.sage
```
