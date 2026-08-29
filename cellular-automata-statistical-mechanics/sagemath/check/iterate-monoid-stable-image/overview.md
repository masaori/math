# SageMath 検算: 反復モノイドの冪等元が定める安定像

## 対象

**対象ラベル**: `claim_iterate_monoid_generator_bijective_on_stable_image`

- 併せて検証するラベル: `def_iterate_monoid_stable_image`、`claim_iterate_monoid_cycle_idempotent_retracts_stable_image`、`claim_iterate_monoid_stable_power_image_equals_stable_image`、`def_iterate_monoid_stable_image_inverse_candidate`、`claim_iterate_monoid_stable_image_finite_decidability`
- 検証範囲: 安定像 $Q_F=E_F(A^V)$、$E_F$ が $Q_F$ 上で恒等になること、$\mu_F\le n$ の全反復写像の像が $Q_F$ に一致すること、$F$ と $S_F=F^{e_F+\lambda_F-1}$ が $Q_F$ を保ち制限が互いに逆写像であること、有限真理値表からの $Q_F$ と制限写像の表の走査
- 全数範囲: セル数 0 の唯一の大域写像、および `1 <= |V| <= 3` の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_idempotent_retraction.sage` | 各 $z\in Q_F$ に証人 $y$（$z=E_F(y)$）を取り、$E_F(z)=E_F(E_F(y))=(E_F\circ E_F)(y)=E_F(y)=z$ を各等号ごとに検査 | PASS | 769 写像・安定像の点 2,201 個で成立 |
| `check_stable_power_images.sage` | $\mu_F\le n\le\mu_F+2\lambda_F+1$ の各 $n$ で $F^n\in C_F$、$E_F\circ F^n=F^n$、前章の逆元 $H\in C_F$ で $F^n\circ H=E_F$、点ごとに $F^n(y)=E_F(F^n(y))\in Q_F$ と $E_F(y)=F^n(H(y))\in\operatorname{im}F^n$、両包含から $\operatorname{im}F^n=Q_F$ | PASS | 769 写像・指数 4,362 個・点ごとの包含検査 22,964 件で成立 |
| `check_restricted_bijection.sage` | $z=F^{e_F}(y)$ に対し $F(z)=F^{e_F+1}(y)\in Q_F$、$S_F(z)=F^{2e_F+\lambda_F-1}(y)\in Q_F$、$F^{e_F+\lambda_F}=F^{e_F}$ と加法則から $F\circ S_F=S_F\circ F=E_F$、$Q_F$ 上で $F(S_F(z))=E_F(z)=z$ と $S_F(F(z))=E_F(z)=z$、制限が互いに逆で $F|_{Q_F}$ が全単射 | PASS | 769 写像・安定像の点 2,201 個で成立 |
| `check_finite_decidability.sage` | 後尾集合の最初の安定から $\mu_F$、正周期の逐次走査から $\lambda_F$、$\lambda_F\mid n$ の判定から $e_F$、合成の反復で $E_F$・$S_F$、全元へ $E_F$ を適用し重複を除いて $Q_F$、$Q_F$ 上の $E_F,F,S_F$ の表 | PASS | 769 写像・配位番号の比較 12,429 回・制限表 2,201 行で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像・任意の $n\ge\mu_F$ に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- `|V|=1,2,3` では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- 像の一致の検算で $n\ge\mu_F+\lambda_F$ の逆元は、周期の伝播で $F^n=F^{n'}$（$\mu_F\le n'<\mu_F+\lambda_F$）へ還元してから前章の指数 $e_F+n'(\lambda_F-1)$ を用いる。人手証明は逆元の存在だけを使うので、この還元は検算側の構成である。
- 全て有限集合の写像（配位番号の真理値表）の等号、非負整数の加減乗除・大小比較として厳密に検査する。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-stable-image/check_*.sage; do sage "$file"; done
```
