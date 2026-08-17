# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地
- **2026-08-18 の tick 405 は、台帳の先頭行「$\mathcal F_L$ が空でないこと（$L\ge2$）」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_fisher_zero_set_nonempty`: $(0,0)$ のスピンだけを反転した配位で正の破れボンド数 $m$ と $\Omega_L(m)\ge1$ を得るため、$Z_L$ の正次数係数は零でない。係数を $\overline{\mathbb Q}$ へ送った多項式へ代数閉性を使って根を取った。$L=1$ は $Z_1=2$ で零点が無いことも SageMath で確認した。Lean 具体版・必要十分版・導出版。sorry 検査 1399 件・check 496 ブロック・verify-check-linkage 279 件・build:pdf 269 ページ通過。
- **2026-08-18 の tick 404 は、台帳の先頭行「$R$ の空でない有限集合は最小元をちょうど 1 つ持つ」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_real_algebraic_min_unique`（`claim_real_algebraic_order_transitive` の直後）: 空でない有限部分集合 $X\subset R$ に「$m\in X$ かつ任意の $y\in X$ について $y=m$ または $m<_Ry$」を満たす $m$ がちょうど 1 つ存在する。存在は $|X|$ の帰納法（三分法で新しい元 $x_1$ と古い最小元 $x_2$ を比べ、$x_1<_Rx_2$ の枝で tick 403 の推移律を使う）、一意性は三分法の排他性。骨組みは `claim_row_config_min_unique` と同じ。
  SageMath `check/real-algebraic-min-unique/`（3 節。`AA` のモデルで、6 元の基底集合の空でない部分集合 63 個すべての一意性・証人 $\sqrt{y-m}$ の非零性・帰納法の一歩の場合分け。通過）。Lean 具体版 `FisherZero/RealAlgebraicMinUnique.lean`（`existsUnique_realAlgebraicMin`。`Finset.Nonempty.cons_induction` で人手証明と同じ帰納法）。必要十分版は新設せず、行配位の最小元のために書いた `NecSuf.AlgebraicEigenvalue.existsUnique_min`（比較可能性・推移律・非対称性だけを仮定に取る形）を引く（同じ議論を二箇所に置かない）。導出版 `RealAlgebraicMinUniqueFromNecSuf.lean`。sorry 検査 1396 件・check 495 ブロック・verify-check-linkage 278 件・build:pdf 268 ページ通過。
  運用: この tick の走行中（01:37〜01:41）、別の対話セッション（tmux `math` の lambda 窓）が同じセクションを並行編集し、tick が書いた本文ブロックが相手の撤回操作で一度失われた。書き直して完了した。相手は自分の重複分を撤去して tick の結末を待つと宣言しており、origin/main への重複 push は無い。
- **2026-08-18 の tick 403 は、台帳の先頭行「$R$ の空でない有限集合は最小元をちょうど 1 つ持つ」の前提として欠けていた狭義順序の推移律を四層で閉じた（住処 Qbar、脱出なし）。**
  着手時の確認: `claim_real_algebraic_order_trichotomy` は「場合分けの網羅性だけを与える。順序が加法・乗法と両立することはここでは主張しない」と本文に明記されており、**推移律は本文にもなかった**（前 tick の MEMORY に確認せよと書いた点）。最小元の議論は推移律を要するので先に置いた。
  `claim_real_algebraic_order_transitive`（`claim_two_is_square_in_real_closed` の直後）: $a<_Rb$ かつ $b<_Rc$ ならば $a<_Rc$。証明は $c-a=(c-b)+(b-a)=u\cdot u+v\cdot v$ の一続き三段のあと、tick 400 の `claim_real_closed_sum_of_two_squares_is_square` で $u\cdot u+v\cdot v=w\cdot w$ と書き直し、$w\ne0$ を tick 399 の `claim_real_closed_sum_of_two_squares_zero` から出す。**直近 2 tick の補題がそのまま効いた。**
  SageMath `check/real-algebraic-order-transitive/`（3 節。`AA` のモデルで三つ組すべて・鎖の各段と証人の非零性・反射的でないことと非対称性。通過）。Lean 具体版 `FisherZero/RealAlgebraicOrderTransitive.lean`（`realAlgebraicLt_trans`）、必要十分版（可換環で「平方の和が平方」「平方の和が零なら各項が零」の 2 つを仮定に取るだけの形）、導出版。sorry 検査 1394 件・check 494 ブロック・verify-check-linkage 277 件・build:pdf 268 ページ通過。
- **2026-08-18 の tick 402 は、台帳の先頭行「臨界点への距離の二乗の定義」を本文と Lean 具体版で閉じた（定義ブロックなので必要十分版と SageMath は置かない。住処 Qbar、脱出なし）。**
  `def_distance_squared_to_critical_point`（`def_distance_squared_to_rational` の直後）: $\xi=a+b\omega$ の一意表示と、前 tick の `claim_critical_point_mem_real_closed` が与える $x_c\in R$ を用い、$\mathrm{dsq}_c(\xi):=(a-x_c)(a-x_c)+b\cdot b\in R$ を直接定義した。初稿にあった一般写像 $\mathrm{dsq}_R$ と有理点一致補題は、1 ブロックで 2 つの定義を置くことになり、後続も使わないため削除した。
  Lean 具体版 `FisherZero/DistanceSquaredToCriticalPoint.lean`（`criticalPointRealClosed`（`Classical.choose`）とその値 `criticalPointRealClosed_val`・`distanceSquaredToCriticalPoint`）。lake build・sorry 検査 1391 件・check 493 ブロック・verify-check-linkage 276 件・build:pdf 267 ページ通過。
- **2026-08-18 の tick 401 は、台帳の先頭行「$x_c$ が実閉部分体 $R$ の元であること」を四層で閉じた（住処 Qbar、脱出なし）。主定理の印を付けた。**
  `claim_critical_point_mem_real_closed`（`claim_two_is_square_in_real_closed` の直後）: $s\cdot s=2$ を満たす $s\in\overline{\mathbb Q}$ は $R$ の元であり、したがって $x_c=-1+s\in R$。証明は第 4 条件で $s=a+b\omega$ と一意表示し、展開と一意性から $a\cdot a-b\cdot b=2$、$2ab=0$ を読み、$b=0$ の枝は $s=a\in R$、$a=0$ の枝は $-2=b\cdot b$（$b\ne0$）となって前 tick の `claim_two_is_square_in_real_closed` の後半に反するので起きない。最後に部分体の加法で $-1+s\in R$。
  SageMath `check/critical-point-mem-real-closed/`（5 節。$R$ のモデルは `AA`、$\omega$ は `QQbar(I)`。2 根がどちらも `AA` の元であること・一意表示の 2 等式・$a=0$ の枝が起きないこと・$x_c$ が自己双対方程式の根であること・$-2$ の平方根は `AA` の外。通過）。Lean 具体版 `FisherZero/CriticalPointMemRealClosed.lean`（`sqrtTwo_mem_realClosed`・`criticalPoint_mem_realClosed`）。定義でなく主張だが、必要十分版は前 tick の Gauss の恒等式と三分法に尽きているので新しくは置かない。sorry 検査 1390 件・check 492 ブロック・verify-check-linkage 276 件・build:pdf 267 ページ通過。
- 全章（何も言っていない主張の一掃）: 1 セクション
- 零点の詰め寄り・固有値の代数性（本文の lean: から引かれていない Lean の配線）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 臨界指数を零点列で書く | 先頭距離 $d_1(L)$ の定義と正値性 | todo | $d_1(L):=\min_{\xi\in\mathcal F_L}\mathrm{dsq}_c(\xi)\in R$。正値性は $x_c\notin\mathcal F_L$（係数が自然数で $x_c$ が正錐 $P_s$ の元なので値が正錐に入る。`claim_positive_rational_not_fisher_zero` と同じ論法） |
| 臨界指数を零点列で書く | 先頭距離の列と詰め寄りの述語の接続（可算な言明） | todo | $\{d_1(L)\}_{L\ge2}$ と `def_zero_pinching_predicate` を結ぶ。量化は $\mathbb Q$ 上 |
| 臨界指数を零点列で書く | 有限サイズスケーリングの読み（ℝ 脱出） | todo | 距離列の増大率と指数 $\nu$ の読み取り。実対数・極限を使うのでここだけ脱出を宣言する。厳密に言える範囲は討議ノート「何が厳密で何が非厳密か」に従って絞る |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録
- 2026-08-18（tick 405）: 台帳の先頭行「$\mathcal F_L$ が空でないこと（$L\ge2$）」を四層で閉じた。一スピン反転から正次数の非零係数を作り、$\overline{\mathbb Q}$ の代数閉性で根を取った。SageMath は $L=1$ の例外と $L=2,3$ の正次数係数・根を厳密確認。Lean 具体版・必要十分版・導出版。sorry 検査 1399 件・check 496 ブロック・verify-check-linkage 279 件・PDF 269 ページ通過。式変形統一は姉妹側「$V_1,V_2$ を $Z,Y,\varepsilon$ で表す」の境界項 $\sigma_M^z\sigma_1^z$ の二等号を、一続き二段・各行の根拠つきへ揃えた（内容不変）。
- 2026-08-18（tick 404）: 台帳の先頭行「$R$ の空でない有限集合は最小元をちょうど 1 つ持つ」を四層で閉じ、`claim_real_algebraic_min_unique` を推移律の直後に置いた。存在は $|X|$ の帰納法（三分法＋推移律）、一意性は三分法の排他性。必要十分版は行配位の最小元の `existsUnique_min` を再利用（同じ議論を二箇所に置かない）。SageMath 3 節、Lean 具体版・導出版。sorry 検査 1396 件・check 495 ブロック・PDF 268 ページ通過。
- 2026-08-18（tick 403）: 最小元の行の前提として欠けていた狭義順序の推移律を四層で閉じ、`claim_real_algebraic_order_transitive` を `claim_two_is_square_in_real_closed` の直後に置いた（本文の三分法は網羅性だけで、推移律は無かった）。直近 2 tick の 2 補題（平方の和が平方・平方の和が零なら各項が零）から出る。SageMath 3 節、Lean 具体版・必要十分版（2 性質を仮定に取る可換環の形）・導出版。sorry 検査 1394 件・check 494 ブロック・PDF 268 ページ通過。
- 2026-08-18（tick 402）: 台帳の先頭行「臨界点への距離の二乗の定義」を本文と Lean 具体版で閉じた（定義ブロック）。第 2 引数を $R$ の元へ広げた $\mathrm{dsq}_R$ を定義し、有理点の場合が既存の $\mathrm{dsq}$ と一致することを明記して、$\mathrm{dsq}_c(\xi):=\mathrm{dsq}_R(\xi,x_c)$ と置いた。check 493 ブロック・PDF 267 ページ通過。
- 2026-08-18（tick 401）: 台帳の先頭行「$x_c$ が実閉部分体 $R$ の元であること」を四層で閉じ、`claim_critical_point_mem_real_closed`（主定理の印）を `claim_two_is_square_in_real_closed` の直後に置いた。$s=a+b\omega$ の一意表示から $2ab=0$ を読み、$a=0$ の枝を前 tick の $-2$ の非平方性で潰した。SageMath 5 節、Lean 具体版（`sqrtTwo_mem_realClosed`・`criticalPoint_mem_realClosed`）。sorry 検査 1390 件・check 492 ブロック・PDF 267 ページ通過。
## 式変形の書き方の統一（並列の作業ストリーム。毎 tick 1 件）

規則は両プロジェクトの README にある「式変形は一続きにする。根拠は行末に $(\because\ \dots)$ で書く」。
**毎 tick 1 件だけ**書き換え、検証を通し、ここへ記録する。中身は変えない（書き方だけ）。

- 2026-08-18（tick 405）: 姉妹側「$V_1,V_2$ を $Z,Y,\varepsilon$ で表す」（`004_transfer_matrix.ts`）の Step 1 で、一行に二つの等号を置いていた境界項 $\sigma_M^z\sigma_1^z$ の計算を、一続き二段へ分け、各行末にクロネッカー積の積の規則を明記した（内容・参照は不変）。姉妹側 check・PDF 325 ページ通過。

- 2026-08-18（tick 404）: 姉妹側「クリフォード群（正規化群）の定義」（`008_TV1_hatZ_hatY_part1.ts`）で、$\mathcal C_M$ が部分群であることの散文中の鎖 $(g_1g_2)\mathcal P_M(g_1g_2)^{-1}=g_1(g_2\mathcal P_Mg_2^{-1})g_1^{-1}=\mathcal P_M$ を一続き三段（行末根拠つき。積の逆元と結合則／$g_2\in\mathcal C_M$／$g_1\in\mathcal C_M$）へ揃えた（内容・参照は不変）。姉妹側 check・PDF 325 ページ通過。

- 2026-08-18（tick 402）: 姉妹側のフェルミオン証明（`008_TV1_hatZ_hatY_part2.ts`）で、a) の係数の括弧を因数分解する三段の式を、一続きの式変形と行末根拠へ揃えた（内容・参照は不変）。姉妹側 check・PDF 325 ページ通過。

- 2026-08-18（tick 398）: 姉妹側「行列の内積とノルム」（`005_exp_conjugation_proof.ts` の Step 4）で、散文中に埋まっていた鎖 $\sum_{i,j}|a_{ij}|^2=\|A\|^2$ すなわち $\langle A,A\rangle=(\|A\|^2)_{\mathbb C}$ を、一続き二段（行末根拠つき。上の鎖／ノルムの定義）へ揃えた（内容・参照は不変）。姉妹側 check・PDF 325 ページ通過。姉妹側の残りは 004 のその他・005 の Step 3 以降の残り・008 系の以降の節。005 の `ad`・内積の同値の鎖（1183 行・463 行付近）は statement の記法注記なので対象外と確認した（対象は証明の散文中の鎖）。

### 本プロジェクト（`exact-solution-of-2d-ising-model-lambda`）

| 証明 | 状態 |
|---|---|
| 分配多項式の係数は多重度である | 済（2026-08-08） |
| 多重度の総和は配位の総数に等しい | 済（2026-08-08） |
| すべての配位を等しく数える点での自由エントロピー | 済（2026-08-08） |

（済んだ分の一覧は [auto-loop-archive.md](auto-loop-archive.md)。）

## レビュー記録
- 2026-08-18（tick 405）: tick 404 の「実閉部分体の空でない有限集合は最小元をちょうど 1 つ持つ」の本文・SageMath・Lean 具体版・既存必要十分版からの導出版を突き合わせ、一致した。修正なし。この主張は有限集合での最小元の存在・一意性を述べ、後続の先頭距離定義が直接引くため「何も言っていない主張」ではない。
- 2026-08-18（tick 404）: tick 403 の「実代数的数の狭義順序は推移的である」の本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、一致した。修正なし。この主張は最小元の存在の帰納法が直接引くため「何も言っていない主張」ではない。
- 2026-08-18（tick 402）: tick 401 の「臨界点が実閉部分体の元であること」の本文・SageMath・Lean を突き合わせ、論法の一致を確認した。この主張は値の住処を確定し、今 tick の定義が直接引くため「何も言っていない主張」ではない。修正なし。今 tick の初稿は 1 ブロック内の二定義と未使用の一致補題を削除した。
- 2026-08-18（tick 398）: tick 397 の「零点密度の挟み込み」の本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、一致した。修正 1 件: 本文末尾「この先に書くこと」に済んだ「零点密度の挟み込み」の項目が残っていたので消した（runbook「項目が済んだら消す」）。
- 2026-08-17（tick 394）: 前 tick の「相異なる点の重複度は、一次因子を割り出した商へ引き継がれる」の本文・SageMath・Lean 具体版・必要十分版からの導出版を突き合わせ、一致した。修正なし。「何も言っていない主張」の観点では、$g\ne0$ は重複度の well-defined 性を担い、主不等式は今 tick の帰納法が残りの各点へ繰り返し使うため残す。
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
