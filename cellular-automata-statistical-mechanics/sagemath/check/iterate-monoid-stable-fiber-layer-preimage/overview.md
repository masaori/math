# SageMath 検算: 安定ファイバーの層別完全逆像

## 対象

**対象ラベル**: `claim_iterate_monoid_positive_depth_layer_exact_preimage`

- 併せて検証するラベル: `claim_iterate_monoid_zero_depth_maps_to_zero_depth`、`claim_iterate_monoid_zero_depth_layer_exact_preimage`、`claim_iterate_monoid_depth_layer_preimage_finite_decidability`
- 検証範囲: $\mu(y)=0\Rightarrow\mu(F(y))=0$（周期組 $(0,\pi(y))$ の移送の三等号と最小性）、$F^{-1}(L_F(\sigma_F(q),k))=L_F(q,k+1)$（$k\ge1$。両包含の各段）、$F^{-1}(L_F(\sigma_F(q),0))=L_F(q,0)\cup L_F(q,1)$（場合分けの各段）、局所真理値表からの有限決定（配位ごとに一度の $F$ 適用による振り分けと、定義どおりの完全逆像の一致）
- 全数範囲: セル数 0 の唯一の大域写像、および `1 <= |V| <= 3` の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_zero_layer_forward.sage` | $\mu(y)=0$ の各配位で $p:=\pi(y)\ge1$、$(0,p)\in P(y)$、窓内の全 $n$ で $F^{n+p}(F(y))=F^{n+p+1}(y)=F^{n+1}(y)=F^n(F(y))$ の三等号、$(0,p)\in P(F(y))$、最小性による $\mu(F(y))=0$ | PASS | 769 写像・$\mu=0$ の配位 2,201 件で成立 |
| `check_positive_layer_preimage.sage` | 各 $q$・$k\ge1$ で、包含 $\subseteq$（完全逆像 ⇒ $\mu(y)>0$ ⇒ 一段減少 ⇒ $\mu(y)=k+1$）と包含 $\supseteq$（$F(y)\in B_F(\sigma_F(q))$ かつ $\mu(F(y))=k$）の各段、両包含による集合の等号 | PASS | 769 写像・空でない組の等号 110 件・両包含の元 各 304 件で成立 |
| `check_zero_layer_preimage.sage` | 各 $q$ で、包含 $\subseteq$ の場合分け（$\mu(y)=0$ なら零層、$\mu(y)>0$ なら $\mu(y)=1$）と包含 $\supseteq$ の場合分け（零層保存・一段減少）、両包含による集合の等号 | PASS | 769 写像・ファイバーごとの等号 2,201 件・零層側 2,201 件・一層側 1,080 件で成立 |
| `check_finite_decidability.sage` | 配位ごとに一度の $F$ 適用と層への振り分けで全ての完全逆像を決定し、定義（全配位の所属検査）どおりの $F^{-1}(L_F(q',k))$ と空でない全ての組で一致すること、適用回数が配位数で尽きること | PASS | 769 写像・適用 3,585 回・比較 3,035 組で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- `|V|=1,2,3` では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- 前章までの $Q_F$・$B_F(q)$・$\sigma_F$・$\mu(y),\pi(y)$・層 $L_F(q,k)$ は `iterate-monoid-stable-fiber-depth/_common.sage` の補助をそのまま使う。完全逆像の一括走査は、ファイバーと層の分割性（既証明）を根拠に配位ごとに一度だけ振り分ける。分割性自体も走査内で配位数の一致・非交差として検査する。
- 全て有限集合の写像（配位番号の真理値表）の等号、有限集合の所属・合併・包含判定、非負整数の加減・大小比較として厳密に検査する。浮動小数点と `R/C` 脱出はない。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-stable-fiber-layer-preimage/check_*.sage; do sage "$file"; done
```
