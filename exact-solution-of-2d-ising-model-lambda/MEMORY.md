# MEMORY — 2次元 Ising 模型の厳密解（Λ・Fisher 零点の立場）

作業前に [README.md](README.md) と リポジトリ直下の [docs/context/](../docs/context/) を全て読むこと。

## 現在の到達点（2026-08-08 時点）

章「分配多項式」（定義 4 件・主張 3 件）と、章「有限系の自由エントロピー」の定義部分
（定義 4 件・主張 2 件）が、四層すべて（記述・SageMath・Lean 具体版・Lean 必要十分版）を満たした。

| 層 | 状態 |
| --- | --- |
| 記述（構造化テキスト） | 上記の定義 8 件・主張 5 件・注意 1 件。`npm run check` と `npm run build:pdf` が全通過 |
| SageMath 検証 | `partition-polynomial-coefficient-sum` / `partition-polynomial-coefficient-representation` / `free-entropy-definition` を実行済み（$L=1,2,3$ で成立、厳密計算） |
| Lean 具体版 | 定義 8 件と主張 5 件。`lake build` と `check-no-sorry.sh`（定理 12 件を登録）が通る |
| Lean 必要十分版 | 主張 5 件について作成済み。数え上げ側は有限型と有界な自然数値写像だけ、値の側は可換モノイド／可換群／狭義順序半環だけを仮定する |

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

## 進め方（自動ループ）

このプロジェクトは **30 分に 1 回の自動ループ**で進む。手順の正本は
[docs/tasks/auto-loop-runbook.md](docs/tasks/auto-loop-runbook.md)、進捗の正本は
[docs/tasks/auto-loop-state.md](docs/tasks/auto-loop-state.md) である（このファイルではない）。

- 1 tick = 既存出力のレビューと修正 → セクションを **1 つだけ** 前進 → 検証 → push → 停止。
- 各 tick は launchd（`com.masaori.ising-lambda-auto-loop`）が起動する
  **独立した Claude セッション**で走る。会話の文脈は持ち越さない。
- 次に何をするかは、下の「次回やること」ではなく**状態台帳のセクション表**を見る。

## 次回やること

1. **$\log$ の加法性（$\log(q_1q_2)=\log q_1+\log q_2$）と $\Phi_L$ の基本性質**。
   定義までは済んでいるので、対数と呼ぶ根拠にあたる加法性から書く。
2. **章「転送行列」**。$T(x)\in M_{2^L}(\mathbb{Z}[x])$ と $Z_L(x)=\operatorname{Tr}T(x)^L$。
   指数形 $e^{K\sigma\sigma'}$ を経由しない経路で書く（README「形式変数のまま進む」）。

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
- 本文の地の文に強調記法（`**`）を使わない（他プロジェクトと同じ運用）。
- 姉妹プロジェクト `exact-solution-of-2d-ising-model/` の計算を引き写さない。
  可算側で書き直せるかを毎回問う（README「姉妹プロジェクトとの違い」）。

## 完了済み

- プロジェクト雛形の作成（構造化テキスト・SageMath・Lean・docs、および検査の一式）。
- 住処 `habitat` と脱出 `realEscape` の型・実行時強制、負テスト 8 件・実行時テスト 9 件。
- 可算な住処を宣言したブロックの数式に $\mathbb{R}/\mathbb{C}$ が現れないことの機械検査。
