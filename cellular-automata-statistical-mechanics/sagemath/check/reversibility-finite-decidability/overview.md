# SageMath 検算: 大域写像の可逆性の有限決定

## 対象

**対象ラベル**: `claim_finite_self_map_injectivity_finite_decidability`

- 併せて検証するラベル: `claim_finite_self_map_injective_iff_surjective`、`claim_finite_self_map_injective_iff_all_periodic`
- 検証範囲: 単射性と全射性の同値（証明が使う像の個数の数え上げの各段を含む）、単射性と「全配位の最小前周期が 0」の同値（両方向の中間段を含む）、全対走査と最小前周期走査による有限決定
- 全数範囲: 配位数 $1,2,4$ の有限集合上の全自己写像、およびセル数 $1$ から $4$ の巡回舞台上の全 256 初等 CA 規則（合計 1,285 写像。うち単射な写像は 263）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_injective_iff_surjective.sage` | 単射 ⟺ 全射。前段（$\lvert\mathrm{Im}F\rvert\le\lvert A^V\rvert$、個数一致 ⟺ 集合一致）、単射なら個数一致、非単射なら $\mathrm{Im}F=\{Fy:y\in B\}$ で $\lvert\mathrm{Im}F\rvert\le\lvert A^V\rvert-1$ | PASS | 1,285 写像で一致 |
| `check_injective_iff_all_min_preperiod_zero.sage` | 単射 ⟺ 全配位で $\mu(y)=0$。単射かつ $\mu(y)\ge1$ の配位が存在しないこと、$\mu(y)=0$ なら $y=F(F^{k}y)$ となる $k$ の存在 | PASS | 1,285 写像・8,713 配位で一致 |
| `check_finite_decidability_pair_scan.sage` | 全対 $(y,y')$（$\lvert A^V\rvert^2$ 個）の走査で反例対が無いことと単射性・全射性の一致 | PASS | 1,285 写像・91,153 対で一致 |
| `check_finite_decidability_min_preperiod_scan.sage` | 全配位（$\lvert A^V\rvert$ 個）の最小前周期を前章の有限走査で求め、全て 0 であることと単射性の一致 | PASS | 1,285 写像・8,713 配位で一致 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- 配位数 $1,2,4$ では全自己写像を検査する。配位数 $8,16$ では全自己写像を列挙せず、セル数 $3,4$ の巡回舞台上の初等 CA が与える写像だけを検査する。
- 最小前周期は「最小前周期と最小周期」の章の検算と同じ手続き（最初の再訪、および $\mu\le\lvert A^V\rvert$ の範囲の走査）で求める。
- 全て有限集合と非負整数の等号・大小比較・加減法として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/reversibility-finite-decidability/check_*.sage; do sage "$file"; done
```
