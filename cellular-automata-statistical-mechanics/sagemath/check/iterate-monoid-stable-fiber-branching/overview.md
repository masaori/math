# SageMath 検算: 安定ファイバー間の分岐個数

## 対象

**対象ラベル**: `claim_iterate_monoid_stable_fiber_predecessor_count_conservation`

- 併せて検証するラベル: `def_iterate_monoid_stable_fiber_predecessor_set`、`def_iterate_monoid_stable_fiber_predecessor_count`、`claim_iterate_monoid_stable_fiber_predecessors_disjoint`、`claim_iterate_monoid_stable_fiber_preimage_decomposition`、`claim_iterate_monoid_stable_fiber_branching_finite_decidability`
- 検証範囲: 一段前像集合 $\operatorname{Pre}_F(z)$ と一段前像数 $b_F(z)$、$z\ne w$ での非交差、完全逆像 $F^{-1}(B_F(\sigma_F(q)))=\bigcup_{z\in B_F(\sigma_F(q))}\operatorname{Pre}_F(z)$ の所属同値の各段、保存式 $|B_F(q)|=\sum_{z\in B_F(\sigma_F(q))}b_F(z)$ の 4 等号、全組走査と有限加算による有限決定
- 全数範囲: セル数 0 の唯一の大域写像、および `1 <= |V| <= 3` の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_predecessors_disjoint.sage` | 各 $z$ で $\operatorname{Pre}_F(z)$ の元が $F(y)=z$ を満たすこと、$z\ne w$ の全順序対で $\operatorname{Pre}_F(z)\cap\operatorname{Pre}_F(w)=\varnothing$（両方に属す $y$ があれば $F(y)=z=w$ の矛盾） | PASS | 769 写像・順序対 17,920 件・所属 3,585 件で成立 |
| `check_preimage_decomposition.sage` | 各 $q\in Q_F$・各 $y\in A^V$ で、完全逆像への所属 ⟺ $F(y)\in B_F(\sigma_F(q))$ ⟺ $\exists z,\ F(y)=z$ ⟺ $\exists z,\ y\in\operatorname{Pre}_F(z)$ ⟺ 有限合併への所属、を段ごとに検査し、最後に集合の等号 | PASS | 769 写像・所属 12,737 件で成立 |
| `check_count_conservation.sage` | $\lvert B_F(q)\rvert=\lvert F^{-1}(B_F(\sigma_F(q)))\rvert=\lvert\bigcup_z\operatorname{Pre}_F(z)\rvert=\sum_z\lvert\operatorname{Pre}_F(z)\rvert=\sum_z b_F(z)$ の 4 等号を分けて検査（非交差も再確認） | PASS | 769 写像・安定ファイバー 2,201 個で成立 |
| `check_finite_decidability.sage` | $A^V\times A^V$ の全組 $(y,z)$ で $F(y)=z$ を検査して得た $\operatorname{Pre}_F(z)$・$b_F(z)$ が定義どおりの値に一致し、各 $B_F(\sigma_F(q))$ 上の有限加算が保存式の値に一致すること | PASS | 769 写像・配位番号の比較 21,505 回・加算 3,585 回で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- `|V|=1,2,3` では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- 前章の $Q_F$・$B_F(q)$・$\sigma_F$ は `iterate-monoid-stable-fiber-dynamics/_common.sage` の補助をそのまま使う。
- 全て有限集合の写像（配位番号の真理値表）の等号、有限集合の所属・包含判定、非負整数の加算として厳密に検査する。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-stable-fiber-branching/check_*.sage; do sage "$file"; done
```
