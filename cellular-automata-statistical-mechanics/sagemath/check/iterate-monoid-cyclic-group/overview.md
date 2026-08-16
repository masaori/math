# SageMath 検算: 反復モノイドの巡回部がなす有限巡回群

## 対象

**対象ラベル**: `claim_iterate_monoid_cycle_part_group_laws`

- 併せて検証するラベル: `def_iterate_monoid_cycle_operation_and_successor`、`claim_iterate_monoid_cycle_part_is_cyclic_of_order_min_period`、`claim_iterate_monoid_cycle_group_finite_decidability`
- 検証範囲: 巡回部 $C_F$ の合成の閉性、唯一の冪等元 $E_F=F^{e_F}$ の左右単位元性、各元の逆元 $F^{e_F+n(\lambda_F-1)}$、$K_F=F^{e_F+1}$ の群の冪による巡回生成と位数 $\lambda_F$、有限真理値表からの演算表・逆元・生成元の走査
- 全数範囲: セル数 0 の唯一の大域写像、および `1 <= |V| <= 3` の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_closure_and_identity.sage` | $G=F^{\mu_F+a},H=F^{\mu_F+b}$ の積が $F^{2\mu_F+a+b}$ で $2\mu_F+a+b\ge\mu_F$ より $C_F$ に属すること、可換律・結合律、$E_F\circ G=F^{e_F+n}=F^{n+q\lambda_F}=F^n$（$e_F=q\lambda_F$、伝播を $q$ 段逐次適用）と $G\circ E_F=G$ | PASS | 769 写像・積 3,906 組・単位元検査 1,412 件・伝播 1,038 段で成立 |
| `check_inverse.sage` | $m=e_F+n(\lambda_F-1)\ge e_F\ge\mu_F$ から $H=F^m\in C_F$、$n+m=e_F+n\lambda_F$、伝播を $n$ 段逐次適用して $G\circ H=F^{e_F}=E_F$、可換性から $H\circ G=E_F$。参考として $C_F$ 内で逆元がちょうど一つ | PASS | 769 写像・逆元 1,412 個・伝播 2,333 段で成立 |
| `check_successor_generates.sage` | $K_F\in C_F$、群の冪 $K_F^{\langle r\rangle}$ の再帰と帰納段 $F^{2e_F+r+1}=F^{e_F+r+1}$、$F^{e_F},\ldots,F^{e_F+\lambda_F-1}$ が $C_F$ を尽くすこと（$\mu_F$ からの一周期への還元）、二元が等しければ剰余が等しく $r=r'$ となる相異性、$K_F$ の位数が $\lambda_F$ | PASS | 769 写像・群冪 2,181 件・相異対 1,247 組で成立 |
| `check_finite_decidability.sage` | 後尾集合の最初の安定から $\mu_F$、正周期の逐次走査から $\lambda_F$、$\lambda_F\mid n$ の判定から $e_F$、大域真理値表の合成で $E_F$・$K_F$・合成表を作り、各行で積が $E_F$ となる列がちょうど一つ存在して逆元を与えること、$K_F$ の冪が $C_F$ を尽くし位数が $\lambda_F$ | PASS | 769 写像・真理値表比較 6,737 回・逆元走査 1,412 行で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- `|V|=1,2,3` では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- 逆元の一意性の行は主張の外の参考であり、命題として述べていない。
- 全て有限集合の写像（配位番号の真理値表）の等号、非負整数の加減乗除・大小比較として厳密に検査する。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-cyclic-group/check_*.sage; do sage "$file"; done
```
