# SageMath 検算: 安定ファイバー間の一段発展

## 対象

**対象ラベル**: `claim_iterate_monoid_stable_fiber_exact_preimage`

- 併せて検証するラベル: `def_iterate_monoid_stable_fiber_index_map`、`claim_iterate_monoid_cycle_idempotent_commutes_with_generator`、`claim_iterate_monoid_stable_fiber_image_can_be_strict`、`claim_iterate_monoid_stable_fiber_dynamics_finite_decidability`
- 検証範囲: 安定像上の添字写像 $\sigma_F(q)=F(q)$ が定義され $Q_F$ 上で全単射であること、$E_F\circ F=F\circ E_F$、完全逆像 $F^{-1}(B_F(\sigma_F(q)))=B_F(q)$ の両包含、一元舞台の定値規則による反例 $F(B_F(q))\subsetneq B_F(\sigma_F(q))$、有限走査による $\sigma_F$ の表・像・完全逆像の決定
- 全数範囲: セル数 0 の唯一の大域写像、および `1 <= |V| <= 3` の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_index_map.sage` | 各 $q\in Q_F$ で $\sigma_F(q)=F(q)\in Q_F$、$\sigma_F$ が $Q_F$ 上で単射かつ全射 | PASS | 769 写像・安定像の点 2,201 個で成立 |
| `check_commutation.sage` | 各 $y$ で $E_F(F(y))=F^{e_F+1}(y)$、$F^{e_F+1}(y)=F(E_F(y))$ を等号ごとに検査 | PASS | 769 写像・配位 3,585 個で成立 |
| `check_exact_preimage.sage` | 順方向: $y\in B_F(q)$ なら $E_F(F(y))=F(E_F(y))=F(q)=\sigma_F(q)$。逆方向: $F(y)\in B_F(\sigma_F(q))$ なら $F(E_F(y))=E_F(F(y))=\sigma_F(q)=F(q)$ と $Q_F$ 上の単射性から $E_F(y)=q$。最後に集合の等号 | PASS | 769 写像・順方向 3,585 件・逆方向 3,585 件で成立 |
| `check_image_can_be_strict.sage` | 大域写像の真理値表 $[F(x_0),F(x_1)]=[0,0]$ について人手証明の各段（$F^0\ne F^1$、$F^1=F^2$、$\mu_F=\lambda_F=e_F=1$、$E_F=F$、$Q_F=\{x_0\}$、$B_F(x_0)=\{x_0,x_1\}$、$\sigma_F(x_0)=x_0$、$F(B_F(x_0))=\{x_0\}\subsetneq B_F(x_0)$）を検査。併せて全数範囲で $F(B_F(q))\subseteq B_F(\sigma_F(q))$ が常に成り立つこと | PASS | 反例成立。769 写像で包含成立、真の包含となる組 $(F,q)$ は 724 件 |
| `check_finite_decidability.sage` | 前章の走査で得た $Q_F$・$B_F(q)$ から、$Q_F$ の各元へ $F$ を適用した表、$B_F(q)$ の全元へ $F$ を適用し重複を除いた像、$A^V$ の各元の像の所属検査で得た完全逆像が定義どおりの集合に一致すること | PASS | 769 写像・配位番号の比較 14,441 回で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- `|V|=1,2,3` では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- 反例の検算は、人手証明の $N(v)=\{v\}$・定値規則 $f_v(a)=0$ が定める大域写像の真理値表 $[0,0]$ を直接与えて行う（同じ真理値表は一元巡回舞台の初等 CA 規則 0 からも得られる）。
- 全て有限集合の写像（配位番号の真理値表）の等号、有限集合の所属・包含判定として厳密に検査する。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-stable-fiber-dynamics/check_*.sage; do sage "$file"; done
```
