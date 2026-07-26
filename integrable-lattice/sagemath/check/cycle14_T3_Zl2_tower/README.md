# cycle 14 / T3 Pure: $\mathbb{Z}_\ell^2$-塔（$d=2$）への拡張の機械検証

対象: `outputs/reports/cycle14_T3_Zl2_tower_criterion.md`（証明本体）の各補題・定理を、
有限個の具体例で機械的に照合する。

- スクリプト / 出力（SageMath 10.6）:
  - `zl2_tower.sage` / `zl2_tower.out`
- 実行: このディレクトリで `sage zl2_tower.sage`（所要 1〜2 分）。

**数値照合は証明ではない。** 本ディレクトリの役割は、証明の書き間違い（符号・添字・場合分けの
取りこぼし）の検出と、**証明できていない部分（レポート §7）について予想が破れていないかを見ること**
の 2 つに限られる。

---

## 1. 設定（記号と定義をすべて明示）

- 底グラフ $X$: 有限**多重グラフ**（多重辺・ループ可）。頂点 $0,\dots,m-1$。
- **voltage** $\alpha: E(X)\to\mathbb{Z}^2$。辺は `(u, v, (a,b))` の list で与える（`u == v` はループ）。
- **導来グラフ** $X_{N,N'}$: 頂点 $V\times(\mathbb{Z}/N\times\mathbb{Z}/N')$、
  底の辺 $e=(u,v,(a,b))$ は $NN'$ 本の辺 $(u,(i,j))\,\text{—}\,(v,(i+a,j+b))$ に持ち上がる。
- $N=N'=\ell^n$ の列が **$\mathbb{Z}_\ell^2$-塔**。$\kappa_n:=\kappa(X_{\ell^n,\ell^n})$（全域木数）。
- **2 変数 voltage ラプラシアン** $L(z,w)\in\mathrm{Mat}_m(\mathbb{Z}[z^{\pm},w^{\pm}])$、$\mathrm{mon}_e=z^aw^b$ として
  - 非ループ辺: $L_{uu}\mathrel{+}=1$, $L_{vv}\mathrel{+}=1$, $L_{uv}\mathrel{-}=\mathrm{mon}_e$, $L_{vu}\mathrel{-}=\mathrm{mon}_e^{-1}$
  - ループ: $L_{uu}\mathrel{+}=2-\mathrm{mon}_e-\mathrm{mon}_e^{-1}$
- $D(z,w)=\det L(z,w)$、$\mu=v_\ell(\mathrm{content}_{z,w}D)$、$f_1=\ell^{-\mu}D(1+T,1+S)\in\mathbb{Z}_\ell[[T,S]]$。
- $\Lambda_X\subseteq\mathbb{Z}^2$: 全域木を 1 つ固定したときの非木辺の基本閉路 voltage が生成する部分群。

すべて有限・整数係数・決定可能（$\mathbb{R}$ も数値近似も使わない）。

## 2. 計算方法（2 経路を独立に使う）

1. **左辺（導来グラフ直接）**: $X_{N,N'}$（$mNN'$ 頂点）を実際に構成し、Kirchhoff の
   matrix-tree 定理で $\kappa$ を厳密整数として計算する。
2. **右辺（終結式）**: $D=z^rw^sF$（$F\in\mathbb{Z}[z,w]$）と分解し
   $$\prod_{(\zeta,\xi)\neq(1,1)}F(\zeta,\xi)
   =\mathrm{Res}_z\Bigl(\tfrac{z^N-1}{z-1},\ \mathrm{Res}_w(w^{N'}-1,\,F)\Bigr)\cdot
    \mathrm{Res}_w\Bigl(\tfrac{w^{N'}-1}{w-1},\ F(1,w)\Bigr)$$
   で厳密整数として計算する（$w^{N'}-1$ と $\frac{z^N-1}{z-1}$ はモニックなので終結式は値の積に等しい）。
   $\zeta,\xi$ は 1 の冪根なので $z^rw^s$ の寄与は絶対値 1 であり、$v_\ell$ にも $\pm$ 以外の影響を与えない。
   このため $(★_2)$ の照合は**絶対値**で行っている（$\det L(\zeta,\xi)\ge0$ なので真の積は正）。

この 2 経路が独立であることが、$(★_2)$ の照合（Step 3）と塔の照合（Step 4c）の意味を担保している。

## 3. 検証項目と結果

例は**明示 15 件＋乱択 30 件＝45 件**（乱択は seed 20260726 固定、頂点数 $\le3$、辺数 2–5、
voltage 成分 $\in\{-2,\dots,2\}$）。明示例には $L\times L$ トーラス、cycle 12 の例を 2 方向化したもの、
および退化例（$\Lambda_X$ の階数 1、$X$ 非連結、$\det L\equiv0$、$\ell=2$ 塔だけが壊れる例）を含む。

| Step | 検証内容 | レポートの主張 | 結果 |
|---|---|---|---|
| 1 | $\det(xI-L_{X_{N,N'}})=\prod_{\zeta,\xi}\det(xI_m-L(\zeta,\xi))$（円分体上の厳密等式） | 補題 A2 | **315 件、不一致 0** |
| 2 | $c(X_{N,N'})=\sum_{\zeta,\xi}\dim\ker L(\zeta,\xi)$ / $X_{N,N'}$ 連結 $\iff\Lambda_X+(N\mathbb{Z}\times N'\mathbb{Z})=\mathbb{Z}^2$ | 補題 B2, C2 | **405 件（非連結 143 件）、不一致 0** |
| 3 | $NN'\kappa(X_{N,N'})=\kappa(X)\prod_{(\zeta,\xi)\neq(1,1)}\det L(\zeta,\xi)$ | 定理 1′ $(★_2)$ | **450 件（両辺 0 の退化 142 件を含む）、不一致 0** |
| 4(i) | $E_n:=\mathrm{ord}_\ell(\kappa_n)-v_\ell(\kappa(X))+2n-(\ell^{2n}-1)\mu\ \ge 0$ | 定理 2′（下界） | **86 塔、違反 0** |
| 4(ii) | $E_n/\ell^{2n}$ が末尾 3 点で減少（$E_n=o(\ell^{2n})$ の支持） | 主要項 $=\mu$（**未証明**） | **86 塔、例外 0** |
| 4(iii) | $a\ell^{2n}+bn\ell^n+c\ell^n+dn+e$ に 6 点以上が厳密に乗るか、乗るなら $a=\mu$ か | Greenberg 形＋主要項 | **14 塔で厳密に乗り、14 塔すべてで $a=\mu$** |
| 4c | $\mathrm{ord}_\ell(\kappa_n)$ を導来グラフ直接と終結式で独立計算し照合 | 定理 1′ の独立確認 | **299 件、不一致 0** |
| 5 / 5b | $f_1\bmod\ell=T^aS^b\times$単元 の塔で $G_n=(E_n-(a+b)n\ell^n)/\ell^n$ の増分が増大しないか | 定理 3′ | **5 塔（$\mu>0$ 1 件を含む）、増大 0** |
| 6 | $\mu=0$ でも $\ell\nmid(N,N')$ の段で $v_\ell(\kappa(X_{N,N'}))>0$ になる witness | §10.1 の射程外 | **484 件中 203 件が witness** |
| 7 | 明示例の Greenberg 係数 $(a,b,c,d,e)$ と成立し始める段 $n_0$ | — | **10 塔、すべて $a=\mu$、$n_0\le2$** |

**標本範囲（明示する）**: $\ell\in\{2,3,5\}$。塔の段は $\ell=2$ で $n\le7$、$\ell=3$ で $n\le4$、$\ell=5$ で $n\le3$。
Step 1–3 の $(N,N')$ は $\{1,\dots,6\}^2$ の 10 通り以内かつ頂点数 $mNN'\le220$。
Step 5b の探索は 2 頂点・平行辺 voltage $\subset\{(0,0),(1,0),(2,0),(0,1),(1,1)\}$（本数 3–4）＋
各頂点ループ voltage $\in\{(1,0),(0,1),(1,1)\}$ の **945 件**。

**0 件の観察は根拠に使っていない。** Step 6 は 203 件の witness を、Step 5b は 1 件の $\mu>0$ 例を、
それぞれ具体的に提示している。Step 5b で「$\mu>0$ かつ単項式還元」が 1 件しか出なかったことは、
上記 945 件の範囲内の事実であって、それ以上の意味をもたない。

## 4. 主要な観測

### 4.1 $L\times L$ トーラス

底グラフ $=$ 1 頂点・ループ voltage $(1,0),(0,1)$。$X_{N,N}$ は $N\times N$ 離散トーラスそのもので、
$\kappa(X_{N,N})=\tau(N)$（cycle 11 T1 の $\tau(L)$）。

$$D=4-z-z^{-1}-w-w^{-1},\qquad \mathrm{content}=1,\quad \mu_\ell=0\ (\forall\ell).$$

実測 $\mathrm{ord}_2(\tau(2^{n}))$（$n=0..7$）$=0,5,19,61,167,417,987,2261$ で、$n\ge1$ において

$$\mathrm{ord}_2\bigl(\tau(2^{n})\bigr)=2\,n\,2^{n}+4\cdot2^{n}-6n-1$$

が**厳密に成立**する（$n=0$ では成立しない）。$4^n$ の項がない＝主要項の係数 $=0=\mu$。

### 4.2 $\mu>0$ の 2 変数例（定理 3′ の適用例）

2 頂点、平行辺 voltage $\{(0,0),(2,0),(1,1),(1,1)\}$、各頂点にループ voltage $(1,0)$。
$\ell=2$ で $\mu=1$、$f_1\bmod2=T^2S^2\times$単元（$(a,b)=(2,2)$）。実測 $\mathrm{ord}_2(\kappa_n)$
（$n=0..7$）は $2,14,64,206,624,1914,6164,21070$ で、$n\ge2$ において

$$\mathrm{ord}_2(\kappa_n)=1\cdot4^{n}+4\,n\,2^{n}+9\cdot2^{n}-6n-8$$

が厳密に成立する（$n=1$ のみ式の値 $16$ と実測 $14$ が食い違う。$n=0$ は偶然一致）。
定理 3′ の予測（$4^n$ の係数 $=\mu=1$、$n2^n$ の係数 $=a+b=4$）と一致。

## 5. 証明していること・していないことの区別（厳密に）

**レポートで証明済み（数値はその確認）**:

- 補題 A2 / B2 / C2（対角化・連結成分数・連結性の部分群判定）。
- 定理 1′ $(★_2)$: 任意の有限アーベル群 voltage、連結性の仮定なし。
- 定理 2′: 下界 $\mathrm{ord}_\ell(\kappa_n)\ge\mu\ell^{2n}-\mu+v_\ell(\kappa(X))-2n$。
- 定理 3′: $f_1\bmod\ell$ が $T^aS^b\times$単元 のとき
  $\mathrm{ord}_\ell(\kappa_n)=\mu\ell^{2n}+(a+b)n\ell^n+O(\ell^n)$。

**証明していない（数値は予想が破れていないことを示すだけ）**:

- 一般の場合の**上界** $E_n=O(n\ell^n)$、すなわち主要項の係数が $\mu$ に一致すること。
  詰まった 1 点はレポート §7.4 に具体化した（$f_1$ の零点が $\ell$ 冪ねじれ点にどれだけ近づきうるかの
  一様評価。文献では Monsky, Math. Ann. 255 (1981) の Theorem 5.6 が担う部分）。
- $L\times L$ トーラスは**定理 3′ の仮定を満たさない**（$\bmod\,2$ で $f_1=(T+S)(T+S+TS)\times$単元 で
  単項式でない）。したがって §4.1 の式は $n\le7$ での一致にすぎない。
- $n\ell^n$ の係数の一般公式、低次の係数、$n_0$ の上界。
- 非対角の段 $(\ell^n,\ell^{n'})$（$n\neq n'$）、および $\ell\nmid N$ の段（Step 6 の 203 件が反例）。

**新規性は主張しない。** DuBose–Vallières, *On $\mathbb{Z}_\ell^d$-towers of graphs*, Algebraic Combinatorics
6 (2023) 1331–1346（本文取得済み）の Theorem A が漸近形を述べ、同論文が「$X^d$ と $YX^{d-1}$ の
係数には明示公式が既にある（Cuoco–Monsky Definition 1.1 / 1.2）」と明記している。詳細はレポート §11。

## 6. cycle 12 / cycle 13 との関係

- cycle 12 `cycle12_T3_nonzero_mu_p/`（$d=1$、$\mu_\ell>0$ の例の構成）と
  cycle 13 `cycle13_T3_criterion_proof/`（$d=1$、$(★)$ と $(☆)$ の証明の検証）の続き。
- cycle 13 report §10-8 が「$d\ge2$ の塔は対象外＝$L\times L$ トーラスには適用できない」と明記した
  その部分に対応する。$(★)$ の 2 変数版は**素直に通った**（Step 1–3）。
  通らなかったのは岩澤型漸近の上界だけである。
