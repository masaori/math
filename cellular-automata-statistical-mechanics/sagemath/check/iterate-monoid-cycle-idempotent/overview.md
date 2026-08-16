# SageMath 検算: 反復モノイドの巡回部にある唯一の冪等元

## 対象

**対象ラベル**: `claim_iterate_monoid_cycle_idempotent_unique`

- 併せて検証するラベル: `def_iterate_monoid_stable_period_multiple_exponents`、`claim_iterate_monoid_stable_period_multiple_exists`、`def_iterate_monoid_minimal_stable_period_multiple`、`def_iterate_monoid_cycle_idempotent_candidate`、`claim_iterate_monoid_cycle_idempotent_candidate_is_idempotent`、`claim_iterate_monoid_cycle_idempotent_finite_decidability`
- 検証範囲: 安定後の周期倍数指数の存在と最小元 $e_F$、候補 $E_F=F^{e_F}$ の巡回部への所属と冪等性、巡回部の冪等元の一意性（人手証明の各段）、有限真理値表からの走査
- 全数範囲: セル数 0 の唯一の大域写像、および `1 <= |V| <= 3` の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_stable_period_multiple_exists.sage` | 証人 $\mu_F\lambda_F\in D_F$、有限範囲で列挙した $D_F$ の最小元 $e_F$ が $\mu_F\le e_F$ かつ $\lambda_F\mid e_F$ を満たし、それ未満に $D_F$ の元がないこと | PASS | 769 写像で成立 |
| `check_candidate_is_idempotent.sage` | $E_F\in C_F$、周期の伝播 $F^{e_F}=F^{e_F+q\lambda_F}$（$e_F=q\lambda_F$）の逐次適用、$E_F\circ E_F=F^{e_F+e_F}=F^{e_F+q\lambda_F}=F^{e_F}=E_F$ | PASS | 769 写像・伝播 630 段で成立 |
| `check_uniqueness.sage` | 巡回部の全元 $G=F^{\mu_F+r}$ を走査し、冪等な $G$ について $F^{2n}=F^n$、$s=(\mu_F+2r)\bmod\lambda_F$ による周期の除去、$r=s$、$\lambda_F\mid n$、$e_F\le n$、伝播で $F^{e_F}=F^n$、$G=E_F$ を検査。各写像で巡回部の冪等元がちょうど一つ | PASS | 769 写像・巡回部の元 1,412 個・冪等元 769 個（各写像に一つ）で成立。参考: 過渡部の冪等元は 540 写像で $F^0$ のみ |
| `check_finite_decidability.sage` | 後尾集合の最初の安定から $\mu_F$、正周期の逐次走査から $\lambda_F$、$\mu_F$ から順に $\lambda_F\mid n$ を判定して $e_F$ を求め、大域真理値表を $e_F$ 回合成した写像が $E_F$ に一致して冪等であること | PASS | 769 写像・真理値表比較 2,831 回・整除判定 1,157 回で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- `|V|=1,2,3` では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- $D_F$ の最小元は、証人 $\mu_F\lambda_F$ が属することを使って $0..\mu_F\lambda_F$ の有限範囲で列挙した。無限集合 $D_F$ 全体の列挙ではない。
- 過渡部の冪等元についての行は主張の外の反例探索であり、命題として述べていない。
- 全て有限集合の写像（配位番号の真理値表）の等号、非負整数の加減乗除・大小比較として厳密に検査する。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-cycle-idempotent/check_*.sage; do sage "$file"; done
```
