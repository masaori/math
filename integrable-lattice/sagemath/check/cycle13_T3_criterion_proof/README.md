# cycle 13 / T3 Pure: 判定式 $(★)$ $(☆)$ の証明ステップの機械検証

## 対象

証明本体は [`outputs/reports/cycle13_T3_mu_content_criterion_proof.md`](../../../outputs/reports/cycle13_T3_mu_content_criterion_proof.md)。
本ディレクトリはその**証明の各補題・定理を具体例で照合する**ためのもので、証明そのものではない。

証明する対象（cycle 12 T3 `cycle12_T3_nonzero_mu_p/` で数値照合のみだった 2 つ）:

- $(★)$ $\;N\cdot\kappa(X_N)=\kappa(X)\prod_{\zeta^N=1,\zeta\neq1}\det L(\zeta)$
- $(☆)$ $\;\mu_\ell=v_\ell\bigl(\mathrm{content}_z(\det L(z))\bigr)$

記号（$X$ 有限連結多重グラフ、voltage $\alpha:E\to\mathbb{Z}$、導来グラフ $X_N$、voltage ラプラシアン $L(z)$、
全域木数 $\kappa$）はすべて証明本体 §1 に定義がある。グラフの表現規約は cycle 12 の
`cycle12_T3_nonzero_mu_p/` と同一（辺は `(u, v, a)` の list、`u == v` はループ、`a` が voltage）。

## ファイル

- `proof_steps.sage` / `proof_steps.out` — 骨格（補題 A・B・C・D、定理 1・2・3）の検証と実行ログ。**自足**しており下記ライブラリを使わない
- `lib_voltage.sage` — 共通ライブラリ（$L(z)$、導来グラフの Kirchhoff 行列式、終結式による $\prod_{\zeta\neq1}D(\zeta)$、$g_X$、Weierstrass 不変量）
- `verify_star.sage` / `verify_star.out` — 命題 7.4（bouquet の content = ループ重複度の gcd）
- `verify_criterion.sage` / `verify_criterion.out` — 命題 7.3（$\mathbb{F}_\ell$ 判定）と命題 9.5（$p\neq\ell$ の下界・等式）

いずれも SageMath 10.6。計算は `ZZ` / `LaurentPolynomialRing(ZZ, 'z')` / `GF(ell)` の範囲で完結し、
`RR`・`CC` を使わない（＝ $\mathbb{R}$/$\mathbb{C}$ への脱出をしない。証明本体 §13）。

## 手順

このディレクトリで実行する。

```
cd integrable-lattice/sagemath/check/cycle13_T3_criterion_proof
sage proof_steps.sage
sage verify_star.sage
sage verify_criterion.sage
```

`proof_steps.sage` の乱数種は `set_random_seed(20260726)` で固定してあるので、乱択グラフを含めて出力は再現する。
`verify_star.sage` / `verify_criterion.sage` は乱択を使わず、対象グラフをすべて明示列挙している。

## 検証項目と結論

### `proof_steps.sage`

| Step | 検証内容 | 証明本体の対応 | 結果 |
|---|---|---|---|
| 1 | $\det(xI-L_{X_N})=\prod_{\zeta^N=1}\det(xI-L(\zeta))$ を $\mathbb{Q}(\zeta_N)[x]$ 上の厳密等式として照合 | 補題 A（DFT ブロック対角化） | 312 件、不一致 0 |
| 2 | $c(X_N)=\sum_{\zeta^N=1}\dim\ker L(\zeta)$ | 補題 B | 416 件、不一致 0 |
| 3 | $X_N$ 連結 $\iff \gcd(N,g_X)=1$（$g_X$ = 基本閉路 voltage の gcd） | 補題 C | 552 件、不一致 0 |
| 4 | $N\kappa(X_N)=\kappa(X)\prod_{\zeta\neq1}\det L(\zeta)$。左辺は導来グラフを構成して Kirchhoff 余因子、右辺は終結式で、**独立に**厳密計算 | 定理 1 $=(★)$ | 624 件（うち $X_N$ 非連結 129 件）、不一致 0 |
| 5 | $\mathrm{content}_z(\det L)=\mathrm{content}_z(P)=\mathrm{content}_T(P(1+T))$、および $\mu_{\text{Weierstrass}}=v_\ell(\mathrm{content})$ | 補題 D、定理 3 $=(☆)$ | 45 グラフ × 5 素数、不一致 0 |
| 6 | $\mathrm{ord}_\ell(\kappa_n)=\mu\ell^n+(\lambda_{\mathrm W}-1)n+\nu$。$\mu,\lambda_{\mathrm W}$ は $\det L(1+T)$ の係数だけから（$\kappa_n$ を一切見ずに）決め、$\nu$ は $n=n_{\max}$ で 1 回だけ決める | 定理 2、定理 3 | 明示 8 グラフの 22 塔で全 $n$ 一致。乱択 63 塔で $n_0$（漸近が成立し始める段）の分布は $0$:51, $1$:3, $2$:4, $3$:5 件 |
| 7 | $v_\ell(\mathrm{content})=0$ なのに $\ell\nmid N$ の段で $v_\ell(\kappa(X_N))>0$ になる witness の提示 | §9.4（適用範囲の限界） | 6 件提示 |

対象グラフは、cycle 12 の例 1–6（$\mu_2=2\,\&\,\mu_3=1$ / $\mu_2=4$ / $\mu_{23}=1$ / 3 頂点 / $\mu_3=2$ / $\mu_5=1$）に加えて、

- $\chi(X)=0$ の bouquet（1 頂点 1 ループ）— 証明が $\chi(X)\neq0$ を必要としないことの確認
- $\det L\equiv0$ の退化例（voltage 全部 $0$ の三角形など）
- $\ell$-塔が非連結になる退化例（voltage $2$ のループのみ、$\ell=2$）
- 乱択 40 件（頂点 $\le3$、辺 $\le6$、voltage $\in[-3,3]$、ループ・多重辺込み）

の計 52 件。

## 実行ログの要点

`proof_steps.out` の Step 6 の表より（$\mu,\lambda_{\mathrm W}$ は $\det L(1+T)$ から、$\mathrm{ord}_\ell(\kappa_n)$ は Kirchhoff から）:

| グラフ | $\ell$ | $\mu$ | $\lambda_{\mathrm W}$ | $\lambda=\lambda_{\mathrm W}-1$ | $\nu$ | $\mathrm{ord}_\ell(\kappa_n)$ |
|---|---|---|---|---|---|---|
| 例1 | 2 | 2 | 2 | 1 | $-2$ | 0, 3, 8, 17, 34, 67, 132 |
| 例1 | 3 | 1 | 2 | 1 | 0 | 1, 4, 11, 30, 85 |
| 例2 | 2 | 4 | 2 | 1 | $-2$ | 2, 7, 16, 33, 66, 131, 260 |
| 例3 | 23 | 1 | 2 | 1 | $-1$ | 0, 23 |
| 例4 | 2 | 4 | 2 | 1 | $-2$ | 2, 7, 16, 33, 66, 131 |
| 例5 | 3 | 2 | **4** | **3** | $-2$ | 0, 7, 22, 61 |
| 例6 | 5 | 1 | 2 | 1 | $-1$ | 0, 5, 26 |
| bouquet 1ループ（$\chi=0$） | 2 | 0 | 2 | 1 | 0 | 0, 1, 2, 3, 4, 5, 6 |

cycle 12 では $(\mu,\lambda,\nu)$ を $\kappa_n$ の**フィット**で求めていたが、ここでは $\mu$ と $\lambda$ を
$\det L(1+T)$ の係数だけから決めており、フィットしていない（$\nu$ のみ 1 点で決める）。
例 5 の $\lambda=3$ が $\lambda_{\mathrm W}=4$ から出ることが、cycle 12 README §6 の
「$\lambda$ の一般則は今回の対象外」に対する答えになっている。

### `verify_star.sage`（D 節）／`verify_criterion.sage`（F・G 節）

| 節 | 検証内容 | 証明本体の対応 | 結果 |
|---|---|---|---|
| D | $m=1$ で $\mathrm{content}_z(\det L)=\gcd_a m_a$、および「$\mu_\ell>0\iff$ 全ての $m_a$ が $\ell$ で割れる」 | 命題 7.4 | bouquet 15 件（負 voltage・voltage 0 混在・$\ell$ 重の組み合わせを含む）、FAIL 0 |
| F | $\mu_\ell>0\iff\det(L\bmod\ell)=0$ over $\mathbb{F}_\ell(z)$、および $\mu_\ell=\max\{k: D\equiv0\bmod\ell^{k}\}$ | 命題 7.3 | 10 グラフ × $\ell\in\{2,3,5,23\}$ = 40 件、FAIL 0 |
| G | $v_p(\kappa_n)=v_p(\kappa_0)-v_p(\ell^n)+\mu_p(\ell^n-1)+v_p(R_n)$ と下界 $v_p(\kappa_n)\ge\mu_p\ell^n+(v_p(\kappa_0)-\mu_p)$ | 命題 9.5 | 5 グラフ × 複数の $p$ の 11 組、FAIL 0 |

対象グラフは cycle 12 の例 1–6 に加え、bouquet（$\{1,2\}$, $\{1,1\}$）、4 頂点の例、負 voltage の例。

**G 節で分かったこと**: $p\neq\ell$ のとき下界は等号になるとは限らない。$v_p(R_n)$ が
$n$ の途中で $0$ から正へ増えてそこで止まる実例が 2 件ある。

| グラフ | $\ell$ | $p$ | $v_p(\kappa_n)$（$n=0,1,\dots$） |
|---|---|---|---|
| cycle 12 例 5 | 2 | 5 | 0, 0, **2**, 2, 2 |
| bouquet $\{1,2\}$ | 2 | 3 | 0, 0, **2**, 2, 2, 2 |

すなわち $v_p(R_n)$ は「常に $0$」でも「単調に増え続ける」でもない。
**その有界性（＝ $v_p(\kappa_n)=\mu_p\ell^n+O(1)$ になるか）は証明本体でも未解決**（同 §9.5、§10-6）。

### 救済元から持ち込まなかったもの（判断の記録）

`verify_star.sage` / `verify_criterion.sage` は救済PR #25（ブランチ `worktree-nifty-drifting-engelbart`）
由来だが、**節単位で取捨した**。落とした節と理由は次のとおり。

| 落とした節 | 内容 | 落とした理由 |
|---|---|---|
| `verify_star.sage` A | $(★)$ を 19 グラフ × $N=1..12$ で照合 | `proof_steps.sage` Step 4 が同じ主張を 624 件（$X_N$ 非連結 129 件を含む）で照合済み |
| 同 B | 連結成分数 $=\gcd(d,N)$ と $\det L(\zeta)\neq0$ の同値 | Step 2（552 件）・Step 3（416 件）が同じ主張を照合済み（$d$ は Step 3 の $g_X$ と同一の量） |
| 同 C | content 保存 $\mathrm{content}_z(D)=\mathrm{content}_T(P(1+T))$ | Step 5 が 45 グラフ × 5 素数で照合済み |
| `verify_criterion.sage` E | 岩澤型漸近 $v_\ell(\kappa_n)=\mu\ell^n+(\lambda_{\mathrm W}-1)n+\nu$ の照合 | Step 6 が明示 8 グラフ 22 塔＋乱択 63 塔で照合済み（救済元は明示 21 塔のみで乱択なし） |
| `.sage.py` 3 個 | Sage プリパーサ生成物 | 生成物。`sage` 実行で自動生成される |
| `.out` 2 個 | 救済元の実行ログ | 本ディレクトリで再実行して取り直した（上記の取捨を反映するため） |

残した前段（`lib_voltage.sage` 全体と、`verify_criterion.sage` の例 1–6 の辺リスト定義）は、
F 節・G 節がスクリプトとして自足するために必要なものである。
`lib_voltage.sage` には落とした節でしか使わない関数（`num_components` / `voltage_index`）も含むが、
ライブラリとしての完全性を保つため残した。

## 結論

証明本体 §3–§7 の補題 A・B・C・D、定理 1・2・3 は、上記 52 グラフの範囲で 1 件も破れなかった。
とくに定理 1 $(★)$ は、$X_N$ が非連結になる 129 件（cycle 12 README が仮定で除外していたケース）を
含めて $0=0$ の形で成立している。

追加した 3 節（D・F・G）についても、命題 7.3・命題 7.4・命題 9.5 は
上記の対象範囲で 1 件も破れなかった（FAIL 数 0）。

## 限界（正直に）

- **これらは有限個の例での照合であって、証明ではない。** 証明本体は
  `outputs/reports/cycle13_T3_mu_content_criterion_proof.md` §3–§9 にある。
  本ディレクトリの役割は、証明の書き間違い（符号・添字・場合分けの取りこぼし）の検出に限られる。
- Step 6 の $n_0>0$（乱択 12 塔）は漸近式が $n\ge n_0$ でのみ成立することの現れであり、
  証明の主張と矛盾しない。ただし **$n_0$ の明示的上界は証明本体でも与えていない**（同 §10-9）。
- 検証した $n$ の範囲は有限（$\ell=2$ で $n\le6$、$\ell=3$ で $n\le4$、$\ell=23$ で $n\le1$）。
- 乱択の範囲（頂点 $\le3$、辺 $\le6$、voltage $\in[-3,3]$）の外については何も言えない。
- $\mathbb{Z}_\ell^d$-塔（$d\ge2$）は対象外（証明本体 §10-10）。
