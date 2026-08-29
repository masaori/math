# SageMath 検算: 軌道の最終周期性

## 対象

**対象ラベル**: `claim_finite_self_map_repeating_tail`

- 併せて検証するラベル: `claim_orbit_collision`、`claim_collision_shift`、`claim_collision_finite_decidability`
- 検証範囲: 軌道衝突の上界、衝突の反復不変性、最終周期性、衝突組の走査回数
- 全数範囲: セル数 $0$ の唯一の配位、および $1\leq|V|\leq3$ の巡回舞台上の全 256 初等 CA 規則・全配位

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_orbit_collision_bound.sage` | $2^{|V|}+1$ 個の反復値の中に衝突がある | PASS | 3,585 軌道で成立 |
| `check_collision_shift.sage` | 各衝突が $0\leq k\leq2^{|V|}$ の追加反復で保たれる | PASS | 48,489 衝突・403,370 等式で成立 |
| `check_eventual_periodicity.sage` | 衝突から得た正の周期が上界を満たし、有限範囲で周期等式を保つ | PASS | 3,585 軌道・46,595 等式で成立 |
| `check_collision_scan_count.sage` | 候補組数と走査上界、配位等号の座標別等号への分解 | PASS | 3,585 軌道・16,997 配位等号・46,124 状態等号で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- $|V|=1,2,3$ では、巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- 最終周期性の普遍量化は有限検算では証明できないため、各軌道について衝突後 $2\cdot2^{|V|}+1$ 個の指数を検査する。普遍的な根拠は別検算の衝突の反復不変性と、人手証明の帰納法である。
- 全て有限集合と非負整数の等号・大小比較・四則演算として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/global-map-eventual-periodicity/check_*.sage; do sage "$file"; done
```
