# MEMORY — 2次元 Ising 模型の厳密解（Λ・Fisher 零点の立場）

作業前に [README.md](README.md) と リポジトリ直下の [docs/context/](../docs/context/) を全て読むこと。

## 現在の到達点（2026-08-08 時点）

章「分配多項式」（定義 4 件・主張 3 件）、章「有限系の自由エントロピー」（定義 4 件・主張 5 件）、
章「転送行列」（定義 11 件・主張 6 件・定理 1 件。$Z_L=\operatorname{Tr}(T^L)$ まで）、
および章「固有値の代数性」の入口（定義 1 件・主張 1 件。行配位の辞書式順序）が、
四層すべて（記述・SageMath・Lean 具体版・Lean 必要十分版）を満たした。

| 層 | 状態 |
| --- | --- |
| 記述（構造化テキスト） | 上記の定義 19 件・主張 15 件・定理 1 件・注意 1 件。`npm run check` と `npm run build:pdf` が全通過 |
| SageMath 検証 | `partition-polynomial-coefficient-sum` / `partition-polynomial-coefficient-representation` / `free-entropy-definition` / `free-entropy-additivity` / `transfer-matrix-row-decomposition` / `transfer-matrix-trace-formula` / `transfer-matrix-power-entry` / `transfer-matrix-trace` / `row-config-order` を実行済み（$L=1,2,3$ で成立、厳密計算） |
| Lean 具体版 | 定義 19 件と主張 15 件と定理 1 件。`lake build` と `check-no-sorry.sh`（定理 53 件を登録）が通る |
| Lean 必要十分版 | 主張 13 件と定理 1 件について作成済み（$\Phi_L(1)=L^2\ell_2$ と辺の行ごとの分割には置いていない。前者は既存の主張をつなぐだけ、後者は番号の付け方そのもので抽象化すると同じ言明になるため。後者の必要性は分解の必要十分版の仮定として検査されている）。数え上げ側は有限型と有界な自然数値写像だけ、値の側は可換モノイド／可換群／可換半環／狭義順序半環だけを仮定する |

Lean の環境は 2026-08-08 に整えた。`lake update` → `lake exe cache get` → `lake build` が通り、
mathlib の実体は `lean/lake-manifest.json` で固定してある（`.lake/` は git 管理外）。
詳細は [lean/README.md](lean/README.md)。

書いた内容は、格子・配位・破れボンド数・多重度・分配多項式 $Z_L\in\mathbb{Z}[x]$ の定義と、
次の 3 つの主張の証明である。この範囲に $\mathbb{R}/\mathbb{C}$ は現れない。

- 配位全体は破れボンド数の値ごとに類別される（被覆と互いに素性）。
- 分配多項式の係数は多重度である（$Z_L=\sum_{m=0}^{2L^2}\Omega_L(m)x^m$）。
  分配多項式の定義は $\sum_{\sigma}x^{b(\sigma)}$ であり、係数表示は定義ではなく主張である。
- 多重度の総和は配位の総数に等しい（$\sum_m\Omega_L(m)=2^{L^2}$）。

章「有限系の自由エントロピー」では、素因数分解の指数 $v_p$、対数順序群
$\Lambda=\{\,\lambda:\mathcal{P}\to\mathbb{Z}\ \text{有限台}\,\}$、正の有理数の対数
$\log q=\sum_p w_p(q)\ell_p$、および $\Phi_L(q)=\log Z_L(q)$ を定義し、次の 2 つを示した。
この範囲にも $\mathbb{R}/\mathbb{C}$ は現れない（$\log$ は級数でも実対数でもなく素因数分解である）。

- 有理数の指数は表示の取り方によらない（$a/b=a'/b'$ ならば $v_p(a)-v_p(b)=v_p(a')-v_p(b')$）。
- 分配多項式の正の有理点での値は正の有理数である（したがって $\Phi_L(q)$ が定まる）。
- 対数の加法性 $\log(q_1q_2)=\log q_1+\log q_2$。これが $\log$ を対数と呼ぶ根拠である。
- 対数の冪の法則 $\log(q^k)=k\log q$（$k\in\mathbb{N}$。$k=0$ の場合が $\log 1=0$）。
- $\Phi_L(1)=L^2\ell_2$。すべての配位を等しく数える点での自由エントロピーは配位の総数の対数に等しい。

章「転送行列」では、行配位 $\tau\in R_L$、配位の第 $i$ 行への制限 $\rho_i(\sigma)$、
行内破れ数 $b_\mathrm{h}$、行間破れ数 $b_\mathrm{v}$ を定義し、次の 2 つを示した。
この範囲にも $\mathbb{R}/\mathbb{C}$ は現れない。

- 辺の番号の集合は行ごとに分割される（各行 $L$ 本・互いに素・合併がもとの集合・端点が番号から読める）。
- 破れボンド数は行内の破れと行間の破れに分かれる
  （$b(\sigma)=\sum_i b_\mathrm{h}(\rho_i(\sigma))+\sum_i b_\mathrm{v}(\rho_i(\sigma),\rho_{i+1}(\sigma))$）。
  これが転送行列を作る足場である。第 1 の和は行ごとに閉じ、第 2 の和は隣り合う 2 行だけを結ぶ。

さらに、行配位の族 $C_L$ と写像 $\mathrm{rows}:\Sigma_L\to C_L$・$\mathrm{conf}:C_L\to\Sigma_L$、
行配位を添字とする行列 $\mathrm{Mat}_{R_L}(\mathbb{Z}[x])$ とその積・冪・トレース、および転送行列
$T_{\tau,\tau'}=x^{b_\mathrm{h}(\tau)+b_\mathrm{v}(\tau,\tau')}$ を定義し、次の 2 つを示した。
指数形 $e^{K\sigma\sigma'}$ は経由していない。

- 配位全体と行配位の族全体は 1 対 1 に対応する（$\mathrm{rows}$ が全単射で逆写像が $\mathrm{conf}$）。
- 配位の重みは行に沿った転送行列の成分の積である
  （$\prod_i T_{\rho_i(\sigma),\rho_{i+1}(\sigma)}=x^{b(\sigma)}$）。
  すなわち分配多項式の和の 1 つの項が、転送行列の成分から得られる。

さらに、長さ $k$ の道（写像 $p:\{0,1,\dots,k\}\to R_L$ の全体）と道に沿った成分の積
$w_A(p)=\prod_{i=0}^{k-1}A_{p(i),p(i+1)}$ を定義し、次を示した。道の定義域は整数の集合であり、
行配位の族（剰余類の集合の上の写像）とは別の対象である。

- 行列の冪の成分は、道に沿った成分の積の和である
  （$(A^k)_{\tau,\tau''}=\sum_{p\in W_{L,k}(\tau,\tau'')}w_A(p)$。$k$ についての帰納法）。

さらに、閉じた道の全体 $W^{\mathrm{cl}}_L=\{p\in W_{L,L}\mid p(0)=p(L)\}$ と、行配位の族から
閉じた道を作る写像 $\Theta$（$(\Theta(c))(i)=c(\pi(i))$）・その逆向きの $\Xi$ を定義し、
章「転送行列」の目標を示した。ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- 行配位の族全体と閉じた道全体は 1 対 1 に対応する（$\Theta$ が全単射で逆写像が $\Xi$）。
- 分配多項式は転送行列の冪のトレースである（$Z_L=\operatorname{Tr}(T^L)$）。
  $2^{L^2}$ 個の項の和として定義された分配多項式が、$2^L$ 次の行列の冪から計算できることになる。

章「固有値の代数性」では、行列式を書くために要る添字集合の線形順序を用意した。
スピン値の番号 $\varepsilon(+1)=0$・$\varepsilon(-1)=1$、値の異なる列番号の集合
$D(\tau,\tau')\subset\{0,\dots,L-1\}$、その最小元 $k_0$、および
$\tau\prec\tau'\iff\tau\ne\tau'$ かつ $k_0$ の位置で $\varepsilon$ の値が小さい、を定義し、次を示した。
ここにも $\mathbb{R}/\mathbb{C}$ は現れない。

- 行配位の辞書式順序は線形順序である（三分律と推移律）。
  行配位に番号を付けて番号の大小を借りると番号の付け方に依存するので、$R_L$ の上に直接定めた。

## 進め方（自動ループ）

このプロジェクトは **30 分に 1 回の自動ループ**で進む。手順の正本は
[docs/tasks/auto-loop-runbook.md](docs/tasks/auto-loop-runbook.md)、進捗の正本は
[docs/tasks/auto-loop-state.md](docs/tasks/auto-loop-state.md) である（このファイルではない）。

- 1 tick = 既存出力のレビューと修正 → セクションを **1 つだけ** 前進 → 検証 → push → 停止。
- 各 tick は launchd（`com.masaori.ising-lambda-auto-loop`）が起動する
  **独立した Claude セッション**で走る。会話の文脈は持ち越さない。
- 次に何をするかは、下の「次回やること」ではなく**状態台帳のセクション表**を見る。

## 次回やること

1. **行配位の置換とその符号**（章「固有値の代数性」の続き）。行列式を置換にわたる和として
   定めるために、置換の集合と、転倒数で定める符号を用意する。転倒数を書くために要る
   添字集合の線形順序（行配位の辞書式順序）は済んでいる。台帳の todo の先頭。

## 未解決の設計問題

- **content のファイルを分けるときの文書順の決め方。** システム（リポジトリ直下
  `structured-latex/`）は `content/` のファイル名昇順を文書順とみなす。一方リポジトリの規約は
  ファイル名の連番プレフィックスを禁じている。2026-08-08 に 2 つめの章を書くときこれに当たったので、
  本文を 1 ファイル `content/main-text.ts` にまとめたまま章を見出しブロックで区切る形にした
  （ファイルを分けない限り配列順が文書順として機能し、衝突しないため）。
  本文が育ってファイルを分けたくなった時点で決着が要る
  （システム側に明示的な順序宣言を入れるのが筋。人間へ提案してから決める）。

## 確認事項・注意

- **検証コードが本文の定義そのものを実装しているかを疑う。** `_shared/defs.sage` の
  `partition_polynomial(L)` は当初、分配多項式を多重度ベクトルから作っていた。本文の定義は
  配位ごとの単項式の和なので、これは定義ではなく係数表示を実装していたことになり、
  係数表示の検証が構成から自明（＝何も確かめない）になっていた。2026-08-08 のレビューで
  定義どおりの実装へ直し、多重度から作る側を `partition_polynomial_from_multiplicity(L)` へ分けた。
- **検証が本文を直させた例を消さない。** 辺集合を「2 元集合の集合」として定義していたため
  周期境界の $L\le2$ で $|E_L|=2L^2$ が破れていた。SageMath 検証が検出し、本文を
  「辺の番号の集合（横向き・縦向きに分割）と端点写像」の定義へ直した。
  経緯は `sagemath/check/partition-polynomial-coefficient-sum/overview.md` に残してある。
- **行への制限は $\rho_i(\sigma)$ と書く。$\sigma_i$ と書かない。** $\sigma$ は格子全体の配位を表す
  記号として固定してあり、添字を付けた形に別の意味を持たせないため（README「記号の濫用を排除する」）。
- 本文の地の文に強調記法（`**`）を使わない（他プロジェクトと同じ運用）。
- 姉妹プロジェクト `exact-solution-of-2d-ising-model/` の計算を引き写さない。
  可算側で書き直せるかを毎回問う（README「姉妹プロジェクトとの違い」）。

## 完了済み

- プロジェクト雛形の作成（構造化テキスト・SageMath・Lean・docs、および検査の一式）。
- 住処 `habitat` と脱出 `realEscape` の型・実行時強制、負テスト 8 件・実行時テスト 9 件。
- 可算な住処を宣言したブロックの数式に $\mathbb{R}/\mathbb{C}$ が現れないことの機械検査。
