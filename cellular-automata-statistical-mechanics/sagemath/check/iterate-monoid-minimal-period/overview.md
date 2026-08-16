# SageMath 検算: 反復モノイドの最小正周期

## 対象

**対象ラベル**: `claim_iterate_monoid_minimal_period_divides_every_period`

- 併せて検証するラベル: `def_iterate_monoid_minimal_positive_period`、`claim_iterate_monoid_period_propagates_after_collision_start`、`claim_iterate_monoid_minimal_period_finite_decidability`
- 検証範囲: 正周期の集合 $\Pi_F=\{p>0\mid F^{\mu_F}=F^{\mu_F+p}\}$ の非空性と最小元 $\lambda_F$、$p\in\Pi_F$ の $n\ge\mu_F$ への伝播、除法 $p=q\lambda_F+r$ からの帰納法と $r=0$、$p=1,2,\ldots$ の走査による有限決定
- 全数範囲: セル数 $0$ の唯一の大域写像、および $1\le|V|\le3$ の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_period_propagates.sage` | $\Pi_F\ne\emptyset$ と、各 $p\in\Pi_F$・$n\in[\mu_F,\mu_F+j+1]$ で $F^{n+p}=F^k\circ F^{\mu_F+p}=F^k\circ F^{\mu_F}=F^{\mu_F+k}=F^n$（$n=\mu_F+k$）を一行ずつ | PASS | 769 写像・5,580 行で成立 |
| `check_minimal_period_divides.sage` | 各 $p\in\Pi_F$ で除法 $p=q\lambda_F+r$、帰納法 $F^{\mu_F+r}=F^{\mu_F+r+d\lambda_F}$（$d=0..q$）の各段、$F^{\mu_F+r+q\lambda_F}=F^{\mu_F+p}=F^{\mu_F}$、$r>0$ なら最小性に矛盾、よって $r=0$ で $\lambda_F\mid p$ | PASS | 769 写像・周期 1,207 個・帰納段 1,747 行で成立 |
| `check_finite_decidability.sage` | 最初の安定位置から $\mu_F$ を求め、$p=1,2,\ldots$ の順に $F^{\mu_F}=F^{\mu_F+p}$ を全配位・全セルの 2 値等号の連言で判定し、最初に成り立つ $p$ が定義から独立に求めた $\lambda_F$ に等しいこと（上限を付けず、停止は $\Pi_F$ の非空性による） | PASS | 769 写像・2 値等号 10,863 回で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- $|V|=1,2,3$ では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- $\Pi_F$ の元は、衝突指数 $j$ を超えると新しい反復写像が現れないことを使い、$p\le j$ の有限列挙で尽くす。伝播の「すべての $n\ge\mu_F$」は有限範囲で検査し、普遍的な根拠は人手証明である。
- `check_minimal_period_divides.sage` の `lam == j - i` の検査は参考であり、人手証明はこれを使わない。
- 全て有限集合の写像（配位番号の真理値表）の等号、非負整数の加減・除法・大小比較として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-minimal-period/check_*.sage; do sage "$file"; done
```
