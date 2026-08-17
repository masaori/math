# SageMath Check: 周期境界と開境界の境界評価の対数化（Λ の鎖。q は 1 以下）

## 対象

**対象ラベル**: `claim_periodic_open_boundary_comparison_log_le_one`

- 実行日: 2026-08-17
- 状態: PASS（$L\in\{1,2,3\}$ × 有理点 6 点、126 検査。所要 3 秒程度（初回起動込みで 11 秒））
- 帰属: `ZZ`/`QQ` と素因数分解、有限台辞書による厳密計算。浮動小数点は使わない
  （主張は $\Lambda$ で閉じており、実数体も実対数も現れない）。

## 検査内容

証明の段ごとに検査する。

- **準備の第一**: $Z_L(q),Z^{\mathrm{op}}_{L,L}(q)\in\mathbb{Q}_{>0}$、下端の値 $q^{2L}Z^{\mathrm{op}}_{L,L}(q)$ が
  $\mathbb{Q}_{>0}$ の元であること。
- **準備の第二** 二段: `claim_log_additive`・`claim_log_power`（$k:=2L$）を $\Lambda$ の有限台辞書の等号で。
- **本体**: $2L\log q+\log Z^{\mathrm{op}}_{L,L}(q)=\log(\text{下端の値})\le_\Lambda\Phi_L(q)=\log Z_L(q)\le_\Lambda\log Z^{\mathrm{op}}_{L,L}(q)$。
  $\le_\Lambda$ は $\mathrm{rat}_\Lambda$ を通した $\mathbb{Q}$ の比較（`def_log_order_group_order`）で判定し、
  `claim_rational_log_order_iff` の移送（`claim_periodic_open_boundary_comparison_rational` の $\mathbb{Q}$ の比較と一致すること）も各段で見る。

周期境界の辺は、開境界正方形の辺と $2L$ 本の境界横断辺の和として組み立てる（$L=1,2$ では境界横断辺が
重なるが、`def_partition_polynomial` のとおり多重辺として数える。`periodic-open-boundary-comparison-rational` と同じ模型）。
有理点は $\{1/10,1/3,1/2,2/3,9/10,1\}$（主張の範囲 $0<q\le1$）。

## 検査できないこと（黙って広げない）

有限標本検査であり、すべての $L,q$ についての主張の証明ではない。一般の証明は Lean 具体版
`ThermodynamicLimit/PeriodicOpenComparisonLog.lean`（`logOrderLE_periodicOpenLog_bounds_of_le_one` と準備の等式 `logRat_periodicOpenLowerValue_eq`）、
必要十分版は「開境界正方形のブロック敷き詰め評価の対数化」の `twoSided_bounds_transport_through_monotone_map_necSuf` を共有、
導出版 `PeriodicOpenComparisonLogFromNecSuf.lean`。

## 実行方法

```sh
sage sagemath/check/periodic-open-boundary-comparison-log/check.sage
```
