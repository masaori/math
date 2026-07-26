# T3: トレース列の $p$ 冪法周期 $\pi(p,k)$ — 上界の検査、Wall 型等号の反例探索、$\pi(p,1)$ の公式検証

本ディレクトリは cycle 3〜8 にわたって T3 トラック（周期構造）で走らせた 6 本のスクリプトと、その実行ログをまとめて置いている。スクリプト個別の説明は `wall_type_period` を除き `*_README.md`（`wall_search_README.md`, `wall_nondegenerate_README.md`, `wall_large_scale_README.md`, `pi_p1_closed_form_README.md`, `pi_p1_refined_README.md`）に既にあり、**本 `README.md` はそれらを統合した目次・要約**である。個別の詳細は各 `*_README.md` を参照する。

## 対象（何を検証したか）

$T\in M_d(\mathbb{Z})$、$Z_N=\operatorname{Tr}T^N$ とし、$\pi(p,k)$ を「$Z_N \bmod p^k$ の列の最終周期」とする。検証したのは次の 3 点。

1. **上界** $\pi(p,k)\mid p^{k-1}\pi(p,1)$ が実例で成り立つか（`wall_type_period`）。
2. **Wall 型等号** $\pi(p,2)=p\,\pi(p,1)$ が成り立つか、破れるか（`wall_search`, `wall_nondegenerate`, `wall_large_scale`）。対象は一般の $2\times2$ companion 行列（Lucas/Pell 列）と、六頂点模型の整数転送行列。
3. **$\pi(p,1)$ の公式** $\pi(p,1)=\operatorname{lcm}\{\operatorname{ord}(\lambda)\}$（全固有値版）と $\operatorname{lcm}\{\operatorname{ord}(\lambda): p\nmid m_\lambda\}$（重複度で絞った版）の、実測値との一致（`pi_p1_closed_form`, `pi_p1_refined`, `pi_p1_strict_demo`）。

## 手順（どのスクリプトを何の設定で実行したか）

周期の実測はすべて共通の方法による。$T \bmod m$ の冪 $T^N$ を $N=1$ から進めて行列が既出になる点で（前周期, 行列周期）を取り、そのうえでトレース列 $Z_N \bmod m$ が実際に持つ最小周期を、行列周期の約数の中から探して返す。転送行列は六頂点の $L$ 型作用素をテンソル積し補助空間でトレースして構成する（$d=2^L$）。

| スクリプト | ログ | 走査範囲 |
|---|---|---|
| `wall_type_period.sage` | `wall_type_period.out` | 六頂点 $(a,b,c,L)=(1,1,2,2),(1,1,1,2),(2,1,1,2)$、$p\in\{3,5,7\}$、$k=1,2,3$ |
| `wall_search.sage` | `wall_search.out` | 群1: companion $x^2-ax+b$、$a\in1..7$, $b\in\{1,-1,2,-2,3\}$, $p\in\{3,5,7,11,13\}$（$p\nmid b$）／群2: 六頂点 5 例 × $p\in\{3,5,7,11\}$（$p\nmid\det$） |
| `wall_nondegenerate.sage` | `wall_nondegenerate.out` | 非退化（charpoly に円分因子なし）に限定。群1: $a\in0..8$, $b\in-4..4\setminus\{0\}$, $p\in\{3,5,7,11,13,17,19,23\}$／群2: 六頂点 8 例 × $p\in\{3,\dots,19\}$ |
| `wall_large_scale.sage` | `wall_large_scale.out` | 六頂点 $L=2$、$a,b,c\in1..7$、非退化、$p\in\{3,5,7\}$（$p\nmid\det$） |
| `pi_p1_closed_form.sage` | `pi_p1_closed_form.out` | 六頂点 7 種 × $p\in\{3,5,7,11,13\}$（$p\nmid\det$）、計 25 例 |
| `pi_p1_refined.sage` | `pi_p1_refined.out` | 六頂点 6 種 × 素数、計 27 例 |
| `pi_p1_strict_demo.sage` | `pi_p1_strict_demo.out` | 構成例 $T=\operatorname{diag}(A^{\times p},B)$（$A$＝$x^2-3x+1$ の companion, $B$＝$x-2$ の companion）、$p\in\{5,7,11,13\}$ |

## 結論（実行ログから読み取れる事実）

### 1. 上界 $\pi(p,k)\mid p^{k-1}\pi(p,1)$

`wall_type_period.out` の 3 例 × 3 素点＝9 ケースすべてで判定 True。測定値は $(a,b,c)$ に依らず $p=3$ で $\pi(p,1{..}3)=[2,6,18]$、$p=5$ で $[4,20,100]$、$p=7$ で $[6,42,294]$ であった。この 9 ケースでは等号（Wall 型）も成立している。

### 2. Wall 型等号の反例

| ログ | 対象 | 検査数 | 破れ |
|---|---|---|---|
| `wall_search.out` 群1 | 一般 companion（退化例を含む） | （出力に検査数なし） | **18 件** |
| `wall_search.out` 群2 | 六頂点 5 例 | （出力に検査数なし） | 0 件 |
| `wall_nondegenerate.out` 群1 | 非退化 companion | 472 | **10 件**（$\approx2.1\%$） |
| `wall_nondegenerate.out` 群2 | 非退化 六頂点 8 例 | 43 | 0 件 |
| `wall_large_scale.out` | 非退化 六頂点 $a,b,c\in1..7$ | **572** | **26 件**（$\approx4.5\%$） |

- 非退化 companion の破れの実例（`wall_nondegenerate.out` が全 10 件を列挙）: $x^2-2x-1$（Pell）$p=13$ で $\pi(p,1)=\pi(p,2)=28$、$x^2-6x+1$ $p=13$、$x^2-7x+1$ $p=3$、$x^2\pm3$ $p=11$ ほか。Pell については $p=7$ で $(\text{成立},6,42)$、$p=29$ で $(\text{成立},20,580)$ と、素数によって成否が分かれることも記録されている。
- 六頂点の破れの実例（`wall_large_scale.out` は 26 件中先頭 20 件を出力）: $(a,b,c,p)=(1,4,6,3),(2,2,6,3),(3,3,5,5),(3,3,7,7),\dots$。破れた素数は $p=3$ が多数を占める。
- **したがって、Wall 型等号は六頂点の可積分転送行列でも破れる。** `wall_search.out`・`wall_nondegenerate.out` の群2 で六頂点の破れが 0 件だったのは、標本が小さい範囲での結果にすぎず、範囲を $a,b,c\in1..7$ へ拡げると 572 件中 26 件の破れが現れた。0 件の観察は「可積分性が Wall 等式を保護する」の支持根拠にならない（`wall_nondegenerate_README.md` が当時、基準率 2.1% なら 43 件中 0 件は約 0.40 の確率で起こると記録し、有意でないと判定していた）。

### 3. $\pi(p,1)$ の公式

- `pi_p1_closed_form.out`: 六頂点 25 例すべてで、実測 $\pi(p,1)$ と $\operatorname{lcm}\{\operatorname{ord}(\lambda)\}$（全固有値の $\overline{\mathbb{F}_p}$ 乗法的順序の lcm）が**一致**（$\pi=\mathrm{lcm}$ が 25 件、$\pi\mid\mathrm{lcm}$ が 25 件）。
- `pi_p1_refined.out`: 六頂点 27 例すべてで実測 $\pi(p,1)=\operatorname{lcm}\{\operatorname{ord}(\lambda):p\nmid m_\lambda\}$。ただしこの 27 例では絞り込み版と全固有値版が一致しており（`lcm_refined<lcm_all` は 0 件）、両公式を区別する例はここには現れていない。
- `pi_p1_strict_demo.out`: 区別する例を意図的に構成したもの。$T=\operatorname{diag}(A^{\times p},B)$ で $p=7$ のとき $\pi=3=\mathrm{lcm}_{\text{refined}}$ に対し $\mathrm{lcm}_{\text{all}}=24$、$p=13$ のとき $\pi=12$ に対し $\mathrm{lcm}_{\text{all}}=84$ と真に小さい。$p=5,11$ では両者一致。4 例すべてで $\pi=\mathrm{lcm}_{\text{refined}}$。

## 限界

- **本ディレクトリの計算はすべて数値検証であり、証明ではない。** 上界 $\pi(p,k)\mid p^{k-1}\pi(p,1)$（Pisano 型、既知）や $\pi(p,1)$ の公式（指標の一次独立による）の証明は本ディレクトリの外にあり、ここにあるのはその整合性検査である。
- 一方、Wall 型等号については話が逆で、**反例が 1 つ出た時点でそれは反証として有効**である。上表の破れ件数は、等号が一般には成り立たないことの根拠になる（成り立つことの根拠にはならない）。
- 周期の実測は、$T^N \bmod m$ が有限個の行列しか取らないことに依拠する探索であり、上限内で周期が見つからない場合の扱いは各スクリプトの `maxN` に依存する（`wall_large_scale.sage` では `maxN=20000`、`skip=0`）。
- 標本範囲は上表のとおり有限で、六頂点は $L=2,3$、重み $1..7$、素数は $23$ 以下に限られる。破れ率 $2.1\%$／$4.5\%$ はこの範囲での実測値であって、母集団の破れ率ではない。両者の差が統計的に有意かどうかの検定は行っていない。
- `wall_search.out` の群1 の 18 件には、退化例（$x^2-x+1$ は 1 の原始 6 乗根、$x^2-2x+1$ は unipotent）が多数含まれる。これらは Wall–Sun–Sun 型の真の反例とは性格が異なる。非退化に限定した数字は `wall_nondegenerate.out` の 472 件中 10 件のほうである。
- `wall_search.out` の群1・群2 は検査総数を出力していないため、破れ件数から破れ率を読むことはできない。
- $\pi(p,1)$ の 2 つの公式を区別する `pi_p1_strict_demo` の例は**六頂点模型ではなく人工的な構成行列**であり、可積分模型でこの区別が現れることを示したものではない。
- 破れる素数に $p=3$ が多いという傾向は観察であって、特徴づけは得られていない。
