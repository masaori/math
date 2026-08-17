# SageMath 検算: 安定ファイバーの最小前周期層

## 対象

**対象ラベル**: `claim_iterate_monoid_stable_fiber_depth_transition`

- 併せて検証するラベル: `def_iterate_monoid_stable_fiber_depth_layer`、`claim_iterate_monoid_stable_fiber_depth_partition`、`claim_iterate_monoid_min_preperiod_decrements`、`claim_iterate_monoid_stable_fiber_depth_finite_decidability`
- 検証範囲: 層 $L_F(q,k)=\{y\in B_F(q)\mid\mu(y)=k\}$ の定義、各ファイバーの元がただ一つの層に属すことと層の非交差、$\mu(y)>0\Rightarrow\mu(F(y))=\mu(y)-1$ の二つの不等式の各段、$F(L_F(q,k))\subseteq L_F(\sigma_F(q),k-1)$ の三段、$\mu(y)\le M$ と $|B_F(q)|=\sum_{k\in[0,M]_{\mathbb N}}|L_F(q,k)|$、走査と一度だけの振り分けによる有限決定
- 全数範囲: セル数 0 の唯一の大域写像、および `1 <= |V| <= 3` の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_layer_partition.sage` | 各 $y\in B_F(q)$ で $y\in L_F(q,\mu(y))$、$y\in L_F(q,k)$ となる $k\in[0,M]_{\mathbb N}$ が $\mu(y)$ ただ一つ、$k\ne\ell$ の全順序対で $L_F(q,k)\cap L_F(q,\ell)=\varnothing$、各層がファイバーに含まれること | PASS | 769 写像・所属 3,585 件・順序対 99,778 件で成立 |
| `check_min_preperiod_decrement.sage` | $\mu(y)=m>0$ の各配位で、反復の等式 $F^{k}(F(y))=F^{k+1}(y)$、$(m-1,\pi(y))\in P(F(y))$ に至る三等号（$n\ge m-1$ の窓）と $\mu(F(y))\le m-1$、$(\mu(F(y))+1,\pi(F(y)))\in P(y)$ に至る三等号（$n\ge j+1$ の窓）と $m\le\mu(F(y))+1$、反対称性による等号を分けて検査 | PASS | 769 写像・$\mu>0$ の配位 1,384 件で成立（$\mu=0$ の 2,201 件は主張の前提外） |
| `check_layer_transition.sage` | 各 $q$・$k\ge1$・$y\in L_F(q,k)$ で、層の定義 ⇒ $F(y)\in B_F(\sigma_F(q))$（完全逆像）⇒ $\mu(F(y))=k-1$ ⇒ $F(y)\in L_F(\sigma_F(q),k-1)$ を段ごとに検査し、最後に像の包含 | PASS | 769 写像・正の層の元 1,384 件・空でない正の層 834 個で成立 |
| `check_finite_decidability.sage` | 全配位で $\pi(y)\ge1$、$\mu(y)+\pi(y)\le M$、$\mu(y)\le M$；走査 $[0,M]\times[1,M-i]$ で得た $\mu(y)$ が定義値に一致；各配位を $E_F(y)$ の $\mu(y)$ 層へ一度だけ加えて得た層が定義どおりの層に一致；$|B_F(q)|=\sum_{k\in[0,M]}|L_F(q,k)|$ | PASS | 769 写像・安定ファイバー 2,201 個・走査比較 16,997 回で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- `|V|=1,2,3` では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- 前章までの $Q_F$・$B_F(q)$・$\sigma_F$ は `iterate-monoid-stable-fiber-dynamics/_common.sage` の補助をそのまま使う。各配位の $\mu(y),\pi(y)$ は本章の `_common.sage` で、走査範囲の各候補について `def_periodicity_pairs` の全称文を窓 $M$ で判定して求める（有限集合上では窓 $M$ の一致が $n\ge i$ 全体の一致と同値であることを補助の注釈に記した）。
- 全て有限集合の写像（配位番号の真理値表）の等号、有限集合の所属・包含判定、非負整数の加減・大小比較として厳密に検査する。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-stable-fiber-depth/check_*.sage; do sage "$file"; done
```
