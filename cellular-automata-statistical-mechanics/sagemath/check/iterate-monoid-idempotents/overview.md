# SageMath 検算: 反復モノイドの冪等元

## 対象

**対象ラベル**: `claim_positive_idempotent_iterate_exists`

- 併せて検証するラベル: `claim_iterate_collision_gives_repeating_tail`、`claim_iterate_monoid_idempotents_finite_decidability`、`claim_nonidentity_idempotent_not_forced`、`claim_iterate_monoid_idempotent_uniqueness_fails`
- 検証範囲: 衝突からの以後の周期、正の冪等指数の構成（$i=0$ と $i\ge1$ の場合分け）、冪等元全体の 2 値状態等号走査による有限決定、恒等 CA と定値規則による 2 つの反例
- 全数範囲: セル数 $0$ の唯一の大域写像、および $1\leq|V|\leq3$ の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）。反例 2 件は構造化記述が構成する一元舞台の有限対象そのもの

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_collision_eventual_period.sage` | 衝突 $F^i=F^j$、$p=j-i\ge1$ から、$n\ge i$ の各 $n$（有限範囲）で人手証明の各行 $F^{n+p}=F^{(i+k)+p}=F^{(i+p)+k}=F^{j+k}=F^j\circ F^k=F^i\circ F^k=F^{i+k}=F^n$ を一行ずつ検査 | PASS | 769 写像・6,431 行グループで成立 |
| `check_positive_idempotent_exists.sage` | $i=0$ なら $e=p$（$F^p=F^0$ と $\operatorname{id}$ の冪等）、$i\ge1$ なら $e=ip\ge i$（加法則 $F^{e+e}=F^e\circ F^e$ と、以後の周期を指数 $e,e+p,\dots,e+(i-1)p$ へ $i$ 回適用）で $F^e\circ F^e=F^e$ を構成どおり検査 | PASS | 769 写像（$i=0$: 229、$i\ge1$: 540）・周期適用 650 行で成立 |
| `check_idempotents_finite_decidability.sage` | 衝突による有限代表 $P_F$ の各 $G$ について $G\circ G=G$ を全配位・全セルの 2 値状態等号の連言へ分解した走査で判定し、定義 $\{G\in P_F\mid G\circ G=G\}$ と一致すること、単位元が常に属すること、等号検査回数が $\lvert P_F\rvert\cdot 2^{\lvert V\rvert}\cdot\lvert V\rvert$ 以下であることを検査 | PASS | 769 写像・冪等元計 1,309 個・30,136 状態等号検査で成立 |
| `check_nonidentity_not_forced.sage` | 一元舞台・恒等局所規則 $f_v(x)=x(v)$ から大域写像を構成し、$P_F=\{\operatorname{id}\}$ で単位元でない冪等元が存在しないことを検査 | PASS | 反例の全数検査で成立 |
| `check_uniqueness_fails.sage` | 一元舞台・定値局所規則 $f_v(x)=0$ から大域写像を構成し、$F\circ F=F$、$F^0=\operatorname{id}$ も冪等、証人 $y(v)=1$ で $F(y)(v)=0\neq1=F^0(y)(v)$、よって相異なる 2 つの冪等元があることを検査 | PASS | 反例の全数検査で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。反例 2 件だけは、構造化記述が構成する有限対象そのものなので全数検査が主張の範囲を尽くす。
- $|V|=1,2,3$ では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- 「以後の周期」と正冪等指数の普遍量化（すべての $n\ge i$）は有限検算では尽くせないため、最初の衝突 $j$ を基準にした有限範囲で検査する。普遍的な根拠は人手証明の式変形である。
- 全て有限集合の写像（配位番号の真理値表）の等号、2 値状態の等号、非負整数の四則・大小比較として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-idempotents/check_*.sage; do sage "$file"; done
```
