# SageMath 検算: 大域写像の反復が生成する有限可換モノイド

## 対象

**対象ラベル**: `claim_iterate_powers_form_finite_commutative_monoid`

- 併せて検証するラベル: `claim_iterate_composition_addition`、`claim_iterate_map_collision_finite_representatives`、`claim_iterate_monoid_finite_decidability`
- 検証範囲: 反復回数の加法と写像合成の一致、反復写像の衝突と有限代表集合、有限可換モノイドの公理、真理値表からの有限決定
- 全数範囲: セル数 $0$ の唯一の大域写像、および $1\leq|V|\leq3$ の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_composition_addition.sage` | 基底段 $F^0\circ F^n=F^n=F^{0+n}$ と帰納段の各行 $F^{m+1}\circ F^n=(F\circ F^m)\circ F^n=F\circ(F^m\circ F^n)=F\circ F^{m+n}=F^{(m+n)+1}$ を真理値表の合成で検査 | PASS | 769 写像・26,265 等式で成立 |
| `check_power_collision.sage` | 衝突 $F^i=F^j$（$0\leq i<j\leq K=M^M$）の存在、反復不変性 $F^{i+p+k}=F^{j+k}=F^j\circ F^k=F^i\circ F^k=F^{i+k}$、除法 $n-i=qp+r$ による $F^n=F^{i+r}$ と $i+r<j$、$|P_F|\leq j\leq K$ | PASS | 769 写像・7,969 反復不変性等式・11,569 還元等式で成立 |
| `check_finite_commutative_monoid.sage` | $F^0=\operatorname{id}\in P_F$、合成の閉性、可換性、結合律、$|P_F|\leq M^M$ を $P_F$ の全元の組で検査 | PASS | 769 写像・6,972 組・29,548 三つ組で成立 |
| `check_monoid_finite_decidability.sage` | 局所真理値表から大域真理値表を得ること、反復写像の等号を全配位・全セルの 2 値状態等号へ分解した走査で衝突と元の同一視を決定すること、指数の加法と代表への還元で得た合成表が真理値表の合成と一致すること、等号検査の回数が有限であること | PASS | 769 写像・6,972 合成表成分・28,199 状態等号検査で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- $|V|=1,2,3$ では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- 人手証明の衝突上界 $K=M^M$（$|V|=3$ で $8^8$）までは走査せず、検算では $M+\operatorname{lcm}(1,\dots,M)$ 以内で最初の衝突を見つけ、その衝突指数 $j$ が $K$ 以下であることを検査する。加法則・反復不変性・還元の普遍量化は有限検算では尽くせないため、指数 $j+2$ を基準にした有限範囲で検査する。普遍的な根拠は人手証明の帰納法である。
- 全て有限集合の写像（配位番号の真理値表）の等号と非負整数の四則・除法・大小比較として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid/check_*.sage; do sage "$file"; done
```
