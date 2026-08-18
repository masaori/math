# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地
- **2026-08-18 の tick 424 は、「先頭距離の詰め寄りから述語 Pinch を導く（接続の完成）」を四層で閉じ、零点の詰め寄りの言明を先頭距離の列 $\{d_1(L)\}$ の詰め寄りへ帰着した（住処 Qbar、脱出なし）。**
  `claim_leading_distance_pinching_implies_predicate`（主定理の印つき）: 「任意の $\eta\in\mathbb Q_{>0}$ にある $L\ge2$ で $d_1(L)<_R\eta$」という仮定から、任意の $\varepsilon\in\mathbb Q_{>0}$ で $\mathrm{Pinch}(\varepsilon)$。$\eta:=\varepsilon^2/4$ に仮定を当て、上界の同値で $\xi$ を、有理近似で $q$ を取り、和の平方の評価の差・二平方和の平方表示・$t\cdot t=2$ で $\varepsilon^2-\mathrm{dsq}(\xi,q)$ を零元でない平方 $z_3^2$ へ八段の鎖で変形した。SageMath は恒等式を `QQ` 記号で、合成を $L=2$ の実零点と `AA` で厳密検査。Lean 具体版・必要十分版（体と $1+1$ の平方表示・二平方和の二性質だけ。標数 2 の排除は sumEqZero 自身が担う）・導出版。レビューは tick 423 の有理近似を本文・SageMath（再実行）・Lean で突き合わせ、修正なし。sorry 検査 1457 件・check 514 ブロック・linkage 295 件・PDF 279 ページ通過。
- **2026-08-18 の tick 423 は、「挟み込み区間から臨界点への有理近似を取る」を四層で閉じた（住処 Qbar、脱出なし）。**
  正の有理網幅で臨界点を挟む上端 $q=(k+1)/N$ を取り、二つの平方差を二平方和の平方へまとめて $(x_c-q)^2<_R\delta$ を示した。平方の単調性は独立主張にせず証明内で展開した。SageMath `AA`/`QQ` 厳密検査、Lean 具体版・必要十分版・導出版。レビューは tick 422 の正の有理数の正値性を三層で突き合わせ、修正なし。式変形統一は姉妹側「$n_\mu^2=n_\mu$」の反交換関係からの移項を一続き二段へ直した。sorry 検査 1454 件・check 513 ブロック・linkage 294 件・PDF 278 ページ、姉妹側 check 300 ブロック・PDF 326 ページ通過。
- **2026-08-18 の tick 422 は、「挟み込み区間から臨界点への有理近似を取る」を論法単位の 2 行へ割り、その最初「正の有理数は実閉部分体で正である」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_positive_rational_positive_in_real_closed`: 任意の $q\in\mathbb Q_{>0}$ について $0<_Rq$。帰納法で 1 以上の自然数 $n$ を零元でない $c\in R$ の平方 $n=c\cdot c$ に表し（帰納段は二平方和の平方表示 $n+1=c^2+1^2=e^2$ と零性 $e\ne0$）、$q=a/b$ の分子分母に当てて $q=(c\cdot d^{-1})^2$、証人の非零性から結論した。この主張は次のセクションで $\mathbb Q$ の狭義比較を差 $q-p\in\mathbb Q_{>0}$ を通して $<_R$ へ移す根拠になる。SageMath `check/positive-rational-positive-in-real-closed/`（`AA` 厳密、帰納段 32 段と標本 6+3 個）。Lean 具体版・必要十分版（体の四則と二平方和の二性質だけ。標数の仮定も不要——sumEqZero 自身が標数零相当を担う）・導出版。レビューは tick 421 の有理等分区間を本文・SageMath（再実行）・Lean で突き合わせ、修正なし。sorry 検査 1451 件・check 512 ブロック・linkage 293 件・PDF 277 ページ通過。
- **2026-08-18 の tick 421 は、台帳の先頭行「臨界点を挟む有理等分区間」を四層で閉じた（住処 Qbar、脱出なし）。** 有限な下側候補の最大元を取り、正値性で候補の非空性、上界で最上端の排除、三分法で次の等分点より臨界点が小さいことを示した。レビューでは前 tick の Lean 具体版で三段を一度の `ring` に畳んでいた箇所を本文と一対一の三段へ直して先行 push し、全検証（sorry 検査 1448 件・check 511 ブロック・linkage 292 件・PDF 277 ページ）を通した。
- **2026-08-18 の tick 420 は、台帳の先頭行「臨界点は一より小さい」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_critical_point_lt_one`: 第 5 条件の $s=w^2$ と二平方和の平方表示 $s+1=v^2$（$v\ne0$）を用い、$1-x_c=2-s=((2-s)(s+1))\cdot(v^{-1})^2=s\cdot(v^{-1})^2=(w\cdot v^{-1})^2$ と変形し、$u:=w\cdot v^{-1}\ne0$（体は零因子を持たない）から $x_c<_R1$ とした。レビューで、tick 419 の Lean 定理 3 件が sorry 検査の対象配列へ未登録（台帳の「1457 件」は実態 1439 件と食い違い）と分かり、今 tick の 3 件と併せて登録した（1445 件）。SageMath `check/critical-point-lt-one/`（`AA` 厳密）、Lean 具体版・必要十分版・導出版。sorry 検査 1445 件・check 510 ブロック・verify-check-linkage 291 件・build:pdf 276 ページ通過。
- 全章（何も言っていない主張の一掃）: 1 セクション
- 零点の詰め寄り・固有値の代数性（本文の lean: から引かれていない Lean の配線）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 臨界指数を零点列で書く | 有限サイズスケーリングの読み（ℝ 脱出） | todo | 距離列の増大率と指数 $\nu$ の読み取り。実対数・極限を使うのでここだけ脱出を宣言する。厳密に言える範囲は討議ノート「何が厳密で何が非厳密か」に従って絞る |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録
- 2026-08-18（tick 424）: 台帳の先頭行「先頭距離の詰め寄りから述語 Pinch を導く（接続の完成）」を実行し、`claim_leading_distance_pinching_implies_predicate` を有理近似の直後に置いた（主定理の印つき）。$\eta:=\varepsilon^2/4$、上界の同値（$t:=\eta$）、有理近似（$\delta:=\eta$）、一意表示 $\xi=\alpha+\beta\omega$、証人 $c_1,c_2,g$、$t\cdot t=2$、二平方和の平方表示の三重適用（$z_1,z_2,z_3$）で $\varepsilon^2-\mathrm{dsq}(\xi,q)=z_3^2$、$z_3\ne0$。SageMath `check/leading-distance-pinch-connection/`（恒等式は `QQ` 記号、合成は $L=2$ の実零点 16 個と `AA`）。Lean 具体版・必要十分版・導出版を sorry 検査へ登録（1457 件）。check 514 ブロック・linkage 295 件・PDF 279 ページ通過。
- 2026-08-18（tick 423）: 台帳の先頭行「挟み込み区間から臨界点への有理近似を取る」を実行し、`claim_critical_point_rational_approximation` を正の有理数の正値性の直後に置いた。$p=k/N\le_Rx_c<_Rq=(k+1)/N$ と $h=q-p=1/N$ から $h-(q-x_c)=x_c-p$、平方差 $h^2-(q-x_c)^2=(h-(q-x_c))(h+(q-x_c))$ を作り、各因子を二平方和の性質で平方表示した。$\delta-h^2$ の正値性と合わせて $(x_c-q)^2<_R\delta$。平方の単調性は四則を独立主張にしない規則に従って証明内へ展開した。SageMath `AA`/`QQ` 厳密、Lean 具体版・必要十分版・導出版。sorry 検査 1454 件・check 513 ブロック・linkage 294 件・PDF 278 ページ通過。
- 2026-08-18（tick 422）: 「挟み込み区間から臨界点への有理近似を取る」に着手し、本文に無い「正の有理数は実閉部分体で正である」（$\mathbb N$ の帰納法という独立の論法）が要ると分かったので 2 行へ割り、その最初を実行した。`claim_positive_rational_positive_in_real_closed` を有理等分区間の直後に置いた。帰納法（$1=1\cdot1$、$n+1=c^2+1^2=e^2$、零性で $e\ne0$）と分子分母の証人 $w=c\cdot d^{-1}$。SageMath `AA` 厳密、Lean 具体版・必要十分版・導出版を sorry 検査へ登録（1451 件）。check 512 ブロック・linkage 293 件・PDF 277 ページ通過。
- 2026-08-18（tick 421）: 台帳の先頭行「臨界点を挟む有理等分区間」を実行し、`claim_critical_point_rational_partition_interval` を上界の直後に置いた。$S_N:=\{j\in\mathbb N\mid j<N+1,\ j/N<_Rx_c\text{ または }j/N=x_c\}$ の最大元 $k$ を取り、$0\in S_N$、$N\notin S_N$、$k+1\notin S_N$ から $k+1\le N$ と $k/N\le_Rx_c<_R(k+1)/N$ を得た。SageMath `AA`/`QQ` 厳密検査、Lean 具体版・必要十分版（有限候補・最大元・三分法だけ）・導出版。sorry 検査 1448 件・check 511 ブロック・verify-check-linkage 292 件・PDF 277 ページ通過。
- 2026-08-18（tick 420）: 台帳の先頭行「臨界点は一より小さい」を実行し、`claim_critical_point_lt_one` を正値性の直後に置いた。第 5 条件と二平方和の平方表示から $1-x_c=(w\cdot v^{-1})^2$、証人の非零性で $x_c<_R1$。SageMath `AA` 厳密検査、Lean 具体版・必要十分版・導出版。tick 419 分と今回分の Lean 6 件を sorry 検査へ登録（1445 件）。check 510 ブロック・verify-check-linkage 291 件・PDF 276 ページ通過。
## 式変形の書き方の統一（並列の作業ストリーム。毎 tick 1 件）

規則は両プロジェクトの README にある「式変形は一続きにする。根拠は行末に $(\because\ \dots)$ で書く」。
**毎 tick 1 件だけ**書き換え、検証を通し、ここへ記録する。中身は変えない（書き方だけ）。

- 2026-08-18（tick 423）: 姉妹側「$n_\mu^2=n_\mu$」（`009_eigenvalues_of_V.ts`）の (2) で、反交換関係から $\psi_{-\mu}\psi_\mu^\dagger=I-n_\mu$ を散文の「移項」で済ませていた箇所を、一続き二段（反交換関係と行列の加法／数演算子の定義）の式変形と行末根拠へ揃えた（内容・参照は不変）。姉妹側 check 300 ブロック・PDF 326 ページ通過。

- 2026-08-18（tick 422）: 姉妹側「冪等行列のトレースは像の次元」（`009_eigenvalues_of_V.ts`）の Step 1 の鎖 $Q(x-Qx)=Qx-Q^2x=Qx-Qx=0$ で、根拠の無かった最終行 $=0$ へ行末の $(\because\ \text{同じ項の差は零元})$ を足した（内容・参照は不変）。姉妹側 check 300 ブロック・PDF 326 ページ通過。

- 2026-08-18（tick 421）: 姉妹側「$V_1,V_2$ を $Z,Y,\varepsilon$ で表す」（`004_transfer_matrix.ts`）の Step 2 で、順方向 $Y_mZ_{m+1}=-i\sigma_m^z\sigma_{m+1}^z$ と逆向き $\sigma_m^z\sigma_{m+1}^z=iY_mZ_{m+1}$ に分かれていた二つの表示を、一続きの式変形へ統合した（内容・根拠・参照は不変）。姉妹側 check 300 ブロック・PDF 326 ページ通過。

- 2026-08-18（tick 420）: 姉妹側「$V_1,V_2$ を $Z,Y,\varepsilon$ で表す」（`004_transfer_matrix.ts`）の Step 1 で、一般式を $Z_m,Y_m,\varepsilon$ へ適用した三行の表示に、それぞれ「上の一般式と各記号の定義」を行末根拠として追加した（内容・参照は不変）。姉妹側 check 300 ブロック・PDF 327 ページ通過。

### 本プロジェクト（`exact-solution-of-2d-ising-model-lambda`）

| 証明 | 状態 |
|---|---|
| 分配多項式の係数は多重度である | 済（2026-08-08） |
| 多重度の総和は配位の総数に等しい | 済（2026-08-08） |
| すべての配位を等しく数える点での自由エントロピー | 済（2026-08-08） |

（済んだ分の一覧は [auto-loop-archive.md](auto-loop-archive.md)。）

## レビュー記録
- 2026-08-18（tick 424）: tick 423 の「挟み込み区間から取る臨界点の有理近似」を本文・SageMath（再実行して通過）・Lean 具体版・必要十分版で突き合わせ、一致した。網幅・等分区間・平方差の因数分解・二平方和の合成が必要十分核 `rational_approximation_square_lt_necSuf` と一対一で、今 tick の接続が直接引くため「何も言っていない主張」ではない。修正なし。本文末尾とセクション表の食い違いなし。
- 2026-08-18（tick 423）: tick 422 の「正の有理数は実閉部分体で正である」を本文・SageMath（再実行して通過）・Lean 具体版・必要十分版・導出版で突き合わせ、一致した。自然数の帰納法、分子分母の平方証人、比の平方表示が一対一であり、今 tick の $\mathbb Q$ の狭義比較を $<_R$ へ移す箇所が直接引くため「何も言っていない主張」ではない。修正なし。本文末尾とセクション表の食い違いなし。
- 2026-08-18（tick 422）: tick 421 の「臨界点を挟む有理等分区間」を本文・SageMath（再実行して通過）・Lean で突き合わせ、一致した。候補集合 $S_N$・最大元・上端の排除・最大性の四段が Lean の filter/max' 構成と一対一。修正なし。本文末尾「この先に書くこと」とセクション表の食い違いなし。
- 2026-08-18（tick 421）: tick 420 の「臨界点は一より小さい」を本文・SageMath・Lean で突き合わせた。主張と計算は一致し、後続の有理等分が上端 $N/N$ を候補から除くため直接引くので「何も言っていない主張」ではない。ただし Lean 具体版が本文の展開・$s^2=2$ の代入・整理という三段を一度の `ring` に畳んでいたため、本文と一対一の三段へ直し、前進前に commit `7e634bc8` を push した。本文末尾とセクション表の食い違いなし。
- 2026-08-18（tick 420）: tick 419 の「臨界点の正値性」を本文・SageMath（再実行して通過）・Lean で突き合わせ、証明内容は一致した。ただし Lean 定理 3 件（具体版・必要十分版・導出版）が `check-no-sorry.sh` の対象配列に未登録で、台帳の「sorry 検査 1457 件」が committed の実態（1439 件）と食い違っていた。3 件を登録して修正した（登録漏れは検査の穴になる）。本文末尾「この先に書くこと」とセクション表の食い違いなし。
## 判断待ち（人間に問うべき論点）

- **content のファイルを分けるときの文書順の決め方。** システムは `content/` のファイル名昇順を
  文書順とみなすが、リポジトリの規約はファイル名の連番を禁じている。
  2026-08-08（tick 5）に 2 つめの章を書くときこれに当たった。連番は振らず、章ごとにファイルを
  分けることもせず、**本文を 1 ファイル `content/main-text.ts` へまとめて章を見出しブロックで
  区切る**形にした（ファイルが 1 つなら配列順がそのまま文書順になり、論点に当たらないため。
  旧ファイル名 `partition-polynomial.ts` は 1 章分しか指さないので改名した）。
  これは論点の解決ではなく回避である。本文が育ってファイルを分けたくなった時点で決着が要る。
  → **決着の案（人間の判断を待つ）**: システム側（リポジトリ直下 `structured-latex/`）に
  文書順の明示的な宣言（例えば `content/order.ts` にファイル名を並べる）を入れ、
  ファイル名昇順という暗黙の規則をやめる。この変更はシステム側の入力言語に触るため、
  他プロジェクト（`exact-solution-of-2d-ising-model/` 等）にも影響する。

## cron（launchd）

- ラベル: `com.masaori.ising-lambda-auto-loop`
- 定義: `~/Library/LaunchAgents/com.masaori.ising-lambda-auto-loop.plist`
- 実体: `scripts/auto-loop-tick.sh`（毎時 5 分、見送られたときの再試行が 35 分。45 分で打ち切る）
- ログ: `logs/auto-loop.log`（git 管理外）
- 各 tick は**独立した新しいセッション**として走る（文脈を持ち越さない。持ち越すのは
  この台帳とリポジトリの中身だけ）。使うエージェントは **Claude と Codex の交互**
  （Claude は `claude-fable-5` の effort medium、Codex は `gpt-5.6-sol` の reasoning medium）。
  片方が使用量の上限に当たった間は、期限を `logs/claude-blocked-until` へ記録してもう片方だけで回す。
- 監査は別ジョブ（毎時 55 分の軽い監査 `scripts/audit-light.sh`、毎日 04:20 の重い監査
  `scripts/audit-loop.sh`）。PDF は `scripts/refresh-pdf.sh` が 5 分おきに最新へ保つ。

停止・再開・頻度変更は、**自分で `launchctl` を叩かず** tmux セッション `local-pc-management` の
ウィンドウ `tick窓口` へ依頼する（2026-08-16 に経路が固定された。`launchd-tick-loop` skill）。
