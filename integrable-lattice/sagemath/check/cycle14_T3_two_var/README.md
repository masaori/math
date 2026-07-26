# cycle 14 / T3 Pure: $\mathbb{Z}_\ell^2$-塔（$d=2$）の検証

## 対象

証明本体は [`outputs/reports/cycle14_T3_two_variable_criterion.md`](../../../outputs/reports/cycle14_T3_two_variable_criterion.md)。
ここはその**各ステップの機械検証**であり、**証明ではない**。

検証対象は、底グラフ $X$（有限多重グラフ、頂点 $m$ 個）に voltage $\alpha:E\to\mathbb{Z}^2$ を与えて作る
導来グラフ $X_{N,N'}$（頂点 $V\times(\mathbb{Z}/N)\times(\mathbb{Z}/N')$）と、
2 変数 voltage ラプラシアン $L(z,w)\in\mathrm{Mat}_m(\mathbb{Z}[z^{\pm1},w^{\pm1}])$、
$D=\det L$、および $\ell$-塔 $\kappa_n=\kappa(X_{\ell^n,\ell^n})$（全域木数）である。

cycle 13 の 1 変数版（[`cycle13_T3_criterion_proof/`](../cycle13_T3_criterion_proof/)）の素直な拡張として書いた。

> **注意（重複）**: 同じ課題が別セッションでも実行され、[`cycle14_T3_Zl2_tower/`](../cycle14_T3_Zl2_tower/) と
> `outputs/reports/cycle14_T3_Zl2_tower_criterion.md` が先に main に入っている。共通部分（$(★_2)$、連結性の
> 格子判定、下界 $a\ge\mu$、上界が未証明であること）は両者独立に同じ結論に達しており矛盾はない。
> 差分は本ディレクトリのレポート §12 にまとめてある。本ディレクトリ固有の検証は **Step 6（DuBose–Vallières
> §7 の 5 例の再現）**、**Step 8（非退化条件と閉形式）**、**Step 9（点ごとの付値）** である。

## 実行

```
cd integrable-lattice/sagemath/check/cycle14_T3_two_var
sage two_var.sage
```

実行ログは `two_var.out`（SageMath 10.6 で取得）。所要時間は数十分程度。
計算はすべて整数・円分体上の**厳密演算**（終結式・Smith 標準形・素イデアル付値）で、浮動小数点を使わない。

## 手順（Step 1–9）

| Step | 検証内容 | 対応する主張 |
|---|---|---|
| 1 | $\det(xI-L_{X_{N,N'}})=\prod_{\zeta^N=1}\prod_{\xi^{N'}=1}\det(xI_m-L(\zeta,\xi))$ を $\mathbb{Q}(\zeta_{\mathrm{lcm}})[x]$ 上の厳密等式として照合 | 補題 A2（2 重離散 Fourier によるブロック対角化） |
| 2 | $c(X_{N,N'})=\sum_{\zeta,\xi}\dim\ker L(\zeta,\xi)$ | 補題 B2 |
| 3 | $X_{N,N'}$ 連結 $\iff$ $X$ 連結 かつ $B+(N\mathbb{Z}\oplus N'\mathbb{Z})=\mathbb{Z}^2$（$B$ = 基本閉路 voltage の生成格子、判定は Smith 標準形） | 補題 C2 |
| 4 | $NN'\kappa(X_{N,N'})=\kappa(X)\prod_{(\zeta,\xi)\neq(1,1)}\det L(\zeta,\xi)$。**左辺は導来グラフの Kirchhoff 余因子、右辺は (a) 円分体上の直接積 (b) 2 段終結式 の 2 通りで独立に計算**して 3 つが一致するかを見る | 定理 1 $=(★_2)$ |
| 5 | $v_\ell(\mathrm{content}_{z,w}D)=\min_{i,j}v_\ell(c_{ij})$（$D(1+T,1+S)=\sum c_{ij}T^iS^j$）。単項式因子を掛けた別正規化でも不変であること | 補題 D2 |
| 6 | **外部照合**: DuBose–Vallières, Algebraic Combinatorics **6** (2023) 1331–1346, §7 の数値例 5 件について、論文の $\mathrm{ord}_\ell(\kappa_n)$ の表と論文の公式を、本スクリプトの $(★_2)$ 経由の計算で再現する | 定理 1 の外部検証 |
| 7 | $\mathrm{ord}_\ell(\kappa_n)$ を基底 $[\ell^{2n},\,n\ell^n,\,\ell^n,\,n,\,1]$ で fit（最大の 5 段で解き、それより小さい $n$ で検算）し、$\ell^{2n}$ の係数 $a$ が $\mu=v_\ell(\mathrm{content}_{z,w}\det L)$ と一致するかを見る | 定理 3（$a\ge\mu$）、定理 4（$a=\mu$） |
| 8 | **非退化条件**（$f=\det L(1+T,1+S)$ の $\bmod\ \ell$ 還元の最低次斉次部分 $H$ が $\mathbb{P}^1(\mathbb{F}_\ell)$ 上に零点をもたない）を判定し、非退化な塔で閉形式 $\mathrm{ord}_\ell(\kappa_n)=\mu\ell^{2n}+\frac{k(\ell+1)}{\ell-1}\ell^n-2n+\nu$（$k=\mathrm{ord}(\bar f)$、$\nu$ は最大の $n$ で 1 回だけ決める）を全段で照合 | 定理 5 |
| 9 | 非退化なら $v_\ell(\det L(\zeta,\xi))=\mu+k/\varphi(\ell^{\max(i,j)})$（$\mathrm{ord}\,\zeta=\ell^i$, $\mathrm{ord}\,\xi=\ell^j$, $\varphi(\ell^{\max})>k$）を、円分体 $\mathbb{Q}(\zeta_{\ell^n})$ の $\ell$ の上の唯一の素イデアルで**点ごとに**直接確認 | 補題 8.4（証明の中心） |

## 対象グラフ

- DuBose–Vallières §7 の例 (1)(2)(3)(5)（bouquet、voltage は $\mathbb{Z}^2$ 値）。
  例 (1) は $\ell^n\times\ell^n$ トーラス（voltage $(1,0),(0,1)$）、例 (2) はそれを 2 重化した content $=2$ の例。
- 自前の例: 2 頂点の平行多重辺、2 頂点＋ループ、3 ループ bouquet、3 頂点三角形、
  content が $3$ になる例、塔が非連結になる退化例（voltage $(2,0),(0,2)$）、
  $\det L\equiv0$ になる退化例（$w$ 方向の voltage が無い）。
- 乱択 24 件（$m\le3$、辺数 $2$–$4$、voltage 成分 $-2$–$2$）。

素数は $\ell\in\{2,3\}$ を主に、$\ell\in\{5,7,23\}$ を一部で使う。塔の段数の上限は
$\ell=2$ で $n\le6$、$\ell=3$ で $n\le4$、$\ell=5$ で $n\le3$、$\ell=7$ で $n\le2$
（$(★_2)$ の右辺を 2 段終結式で厳密計算する時間の都合。$\ell=3$, $n=5$ は 1 グラフあたり約 9 分かかる）。
Step 6 の DuBose–Vallières 例だけは論文の表と突き合わせるため $\ell=2$ で $n\le6$、$\ell=3$ で $n\le4$ を使う。

**Step 7（5 係数の fit）は 5 段以上必要なので $\ell=2$ でのみ実行する。** $\ell=3$ については、
Step 6 で論文自身の公式（例 (4) $4\cdot3^n-2n-4$、例 (5) $\frac{20}{3}3^n-2n-8$、どちらも $\ell^{2n}$ の係数 $=0=v_3(\mathrm{content})$）
を再現することが $a=v_\ell(\mathrm{content})$ の外部由来の確認になっており、
$\ell=3,5,7$ については Step 8（未知数が $\nu$ だけなので少ない段数でも独立な照合が取れる）で扱う。

## 結論（`two_var.out` の実測。SageMath 10.6、EXIT=0）

| Step | 件数 | 不一致 |
|---|---|---|
| 1 補題 A2 | 180 | **0** |
| 2 補題 B2 | 576 | **0** |
| 3 補題 C2 | 1296（うち非連結 549） | **0** |
| 4 定理 1 $(★_2)$ | 563（うち両辺 $0$ の退化ケース 222） | **0** |
| 5 補題 D2 | 155 | **0** |
| 6 DuBose–Vallières §7 | 5 例 | **5 例すべて一致** |
| 7 $a$ vs $v_\ell(\mathrm{content})$ | 13 件（fit 有効 8 / 無効 5） | 有効 8 件で **0** |
| 8 非退化＋閉形式 | 判定 30（非退化 9） | 非退化 9 件で **0** |
| 9 補題 8.4（点ごとの付値） | 472（対象外 56） | **0** |

- **Step 6 が最重要**: 論文の表 $\mathrm{ord}_\ell(\kappa_n)$ と本計算が 5 例すべてで完全に一致した。
  本計算は $(★_2)$ ＋ 2 段終結式（整数演算のみ）、論文は Artin–Ihara $L$ 函数の特殊値の高精度数値計算、
  という**独立な経路**である。
  さらに論文の例 (4)（$\ell=3$、$\ell^n\times\ell^n$ トーラス）の公式 $4\cdot3^n-2n-4$ は、
  レポート定理 5 の予言 $\mu\ell^{2n}+\frac{k(\ell+1)}{\ell-1}\ell^n-2n+\nu$（$\mu=0$, $k=2$）と**係数まで一致**する。
- Step 7: fit 窓 $n=2..6$ が漸近域に入っている（out-of-sample の $n=1$ を再現する）8 件では
  $a=v_2(\mathrm{content}_{z,w}\det L)$ が例外なく成立。content が $\ell$ で割れる例（論文の例 (2)、$\mu=1$）でも成立した。
  **残り 5 件は fit 窓が漸近域に未到達で無効**（例: 論文の例 (3) は論文自身が「$4\le n\le10$ で成立」と書いており、
  fit は非整数の $a=23/144$ を返す。文献は $a$ が非負整数だと述べているので、これは fit の無効性の徴候であって
  定理の反例ではない）。スクリプトはこの 5 件を比較対象から除外して報告する。
- Step 8: 非退化 9 件（$\ell=3$ が 7 件、$\ell=5$ が 1 件、$\ell=7$ が 1 件）で閉形式が全段成立。
  $\ell=7$ のトーラスでは $\ell^n$ の係数が $\frac{k(\ell+1)}{\ell-1}=\frac83$ と予言どおり（$\nu=-8/3$）。
  退化 21 件（$\ell=2$ のトーラス、$\ell=5$ のトーラス等）は定理 5 の射程外で、実際 $n\ell^n$ 項が現れる。
  **$\ell=2$ では非退化な例が 1 件も見つからなかった**（bouquet では $H\equiv(\sum a_i^2)T^2+(\sum b_i^2)S^2$ が
  $\bmod\,2$ で必ず $\mathbb{P}^1(\mathbb{F}_2)$ 有理零点をもつため）。本プロジェクトの主対象がここに入る。
- Step 9: 定理 5 の中心となる補題（点ごとの付値 $\mu+k/\varphi(\ell^{\max(i,j)})$）は 472 件で不一致 0。

## 限界（重要）

1. **これは有限個の例での照合であって証明ではない。** 証明本体はレポートの §3–§8。
2. **Step 7 の fit は 5 点から 5 個の係数を解いたものであり、それ自体は何も証明しない。**
   多項式形（$\mathrm{ord}_\ell(\kappa_n)=P(\ell^n,n)$）自体は DuBose–Vallières Theorem A / Monsky Theorem 5.6
   という外部定理に依拠している。
3. **$a\le\mu$（定理 4 の上からの不等式）は本サイクルで証明できていない**（レポート §9-1）。
   Step 7 の一致はその証拠にすぎない。自前に証明したのは下界 $a\ge\mu$（定理 3）だけである。
4. **退化ケース（$H$ が $\mathbb{P}^1(\mathbb{F}_\ell)$ 上に有理零点をもつ）の $\ell^n$ 係数・$n\ell^n$ 係数は決めていない。**
   本プロジェクトの主対象である $L\times L$ トーラスの $\ell=2$ 塔はこの退化ケースに入る。
5. 標本範囲は上記「対象グラフ」に書いた範囲に限る。**0 件の観察（反例が見つからなかったこと）を
   仮説の支持根拠として一般化しない。**
6. 塔の段数が小さい（$\ell=2$ で $n\le7$）ので、$n_0$（漸近が成立し始める段）が大きい例を
   取りこぼしている可能性がある。
