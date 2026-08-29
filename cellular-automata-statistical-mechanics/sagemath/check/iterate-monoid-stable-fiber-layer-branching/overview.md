# SageMath 検算: 安定ファイバーの層別分岐個数

## 対象

**対象ラベル**: `claim_iterate_monoid_positive_depth_layer_predecessor_count`

- 併せて検証するラベル: `claim_iterate_monoid_finite_subset_preimage_decomposition`、`claim_iterate_monoid_zero_depth_layer_predecessor_count`、`claim_iterate_monoid_depth_layer_branching_finite_decidability`
- 検証範囲: 各有限部分集合 $T\subseteq A^V$ での $F^{-1}(T)=\bigcup_{z\in T}\operatorname{Pre}_F(z)$（所属同値の各段）、正の層の保存式 $|L_F(q,k+1)|=\sum_{z\in L_F(\sigma_F(q),k)}b_F(z)$（4 等号の各段）、零層の保存式 $|L_F(q,0)|+|L_F(q,1)|=\sum_{z\in L_F(\sigma_F(q),0)}b_F(z)$（5 等号の各段）、局所真理値表からの有限決定（数え上げ走査と有限加算が定義どおりの値に一致）
- 全数範囲: セル数 0 の唯一の大域写像、および `1 <= |V| <= 3` の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_subset_preimage_decomposition.sage` | 各舞台の配位集合の全ての部分集合 $T$ について、$y\in F^{-1}(T)\iff F(y)\in T\iff\exists z\in T,F(y)=z\iff\exists z\in T,y\in\operatorname{Pre}_F(z)\iff y\in\bigcup_{z\in T}\operatorname{Pre}_F(z)$ の各段と、集合の等号 | PASS | 769 写像・部分集合 70,658 個・所属同値 542,722 件で成立 |
| `check_positive_layer_branching.sage` | 各 $q$・$k\ge1$ で、$\vert L_F(q,k+1)\vert=\vert F^{-1}(L_F(\sigma_F(q),k))\vert=\vert\bigcup_z\operatorname{Pre}_F(z)\vert=\sum_z\vert\operatorname{Pre}_F(z)\vert=\sum_z b_F(z)$ の 4 等号（前像非交差は対ごとの共通部分の空で検査） | PASS | 769 写像・個数等号 12,737 組（どちらかの辺が空でない組 834）で成立 |
| `check_zero_layer_branching.sage` | 各 $q$ で、$\vert L_F(q,0)\vert+\vert L_F(q,1)\vert=\vert L_F(q,0)\cup L_F(q,1)\vert$（層の非交差）から $\sum_z b_F(z)$ までの 5 等号 | PASS | 769 写像・安定ファイバー 2,201 個で成立 |
| `check_finite_decidability.sage` | 配位ごとに一度の $F$ 適用の数え上げ走査で全 $b_F(z)$ を決定し（定義どおりの $\vert\operatorname{Pre}_F(z)\vert$ と一致）、有限加算した層別総和が正の層・零層の両保存式と定義どおりの完全逆像の個数に一致すること | PASS | 769 写像・適用 3,585 回・正の層 12,737 組・零層 2,201 組で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- `|V|=1,2,3` では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- $Q_F$・$B_F(q)$・$\sigma_F$・$\mu(y)$・層 $L_F(q,k)$・完全逆像は前二章の `_common.sage` の補助をそのまま使う。$\operatorname{Pre}_F(z)$・$b_F(z)$ は定義どおり全配位の等号検査で計算する。
- 全て有限集合の写像（配位番号の真理値表）の等号、有限集合の所属・合併・共通部分・包含判定、非負整数の加算・等号として厳密に検査する。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-stable-fiber-layer-branching/check_*.sage; do sage "$file"; done
```
