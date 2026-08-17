# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地
- **2026-08-18 の tick 408 は、台帳の先頭行「分配多項式の臨界点での値は正錐に入り、$x_c$ は Fisher 零点でない」を論法単位の 3 行（自然数倍の場合分け／有限和の帰納法／背理法）へ割り、その最初「正錐の元の自然数倍は零元または正錐の元である」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_quadratic_positive_cone_nat_mul`（`claim_quadratic_positive_cone_pow_closed` の直後）: $\xi\in P_s$ と $c\in\mathbb N$ について $c\cdot\xi\in Q_s$、$c=0$ ならば $c\cdot\xi$ は零元、$1\le c$ ならば $c\cdot\xi\in P_s$。零の場合は証人 $(0,0)$、正の場合は `claim_positive_rational_in_positive_cone` と乗法閉性 2 本を引く。分配多項式の臨界点での値の各項 $\Omega_L(m)\,x_c^m$ を多重度の零・正で分けて扱う根拠になる。
  SageMath `check/positive-cone-nat-mul/`（$s$ 2 通り × 正錐の代表 4 個 × $c\in\{0,1,2,3,5,7\}$ の 48 組。`QQ`/`QQbar` 厳密）。Lean 具体版 `FisherZero/PositiveConeNatMul.lean`、必要十分版 `NecSuf/FisherZero/PositiveConeNatMul.lean`（自然数の場合分け・零吸収・正の添字の所属・閉性だけを仮定に取り、環も体も順序も使わない）、導出版。sorry 検査 1411 件・check 499 ブロック・verify-check-linkage 282 件・build:pdf 270 ページ通過。式変形統一は姉妹側を 1 件（下の並列ストリームの記録）。
- **2026-08-18 の tick 407 は、台帳の先頭行「正錐の元の冪は正錐の元である」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_quadratic_positive_cone_pow_closed`: $\xi\in P_s$ と $m\in\mathbb N$ に対して $\xi^m\in Q_s$ かつ $\xi^m\in P_s$。$m=0$ は tick 406 の $1\in P_s$、帰納段は `claim_quadratic_multiplication_mem` と `claim_quadratic_positive_cone_mul_closed` を引いた。
  SageMath `check/positive-cone-pow/`（$s$ 2 通り × 正錐の代表例 4 個 × $m=0,\ldots,9$、帰納段 72 件。`QQ`/`QQbar` 厳密）。Lean 具体版・必要十分版・導出版。sorry 検査 1407 件・check 498 ブロック・verify-check-linkage 281 件・build:pdf 270 ページ通過。式変形統一は姉妹側「$V_1,V_2$ を $Z,Y,\varepsilon$ で表す」の Step 2 で、散文と単独の等式に分かれていた $\sigma_m^z\sigma_{m+1}^z=iY_mZ_{m+1}$ の導出を一続き三段・各行の根拠つきへ揃えた（内容不変）。姉妹側 check・PDF 325 ページ通過。
- **2026-08-18 の tick 406 は、台帳の先頭行「先頭距離 $d_1(L)$ の定義と正値性」を 5 行へ割り直し、その最初「正の有理数は正錐の元である」を四層で閉じた（住処 Qbar、脱出なし）。**
  割り直しの理由: 先頭距離の正値性は $x_c\notin\mathcal F_L$ を経由し、それには「正錐の元での分配多項式の値が正錐に入る」機構（冪・自然数倍・有限和）が丸ごと欠けていた。論法単位（表示の確認／冪の帰納法／値の評価と非零／距離の零性の同値／最小元の定義）で 5 行にした。
  `claim_positive_rational_in_positive_cone`（`claim_quadratic_positive_cone_mul_closed` の直後）: 任意の $q\in\mathbb Q_{>0}$ について $q\in Q_s$ かつ $q\in P_s$。表示の証人は $(q,0)$、正錐の第一条件で閉じる。のちに $\Omega_L(m)\ge1$ 倍を正錐の乗法として扱う根拠になる。
  SageMath `check/positive-rational-in-positive-cone/`（$s$ 2 通り × 正の有理数 6 個、非正 4 個の排除。`QQ`/`QQbar` 厳密）。Lean 具体版 `FisherZero/PositiveRationalInPositiveCone.lean`（`positiveRational_mem_positiveCone`）、必要十分版は既存の `positive_of_representation_necSuf` を引く（同じ議論を二箇所に置かない）、導出版 `PositiveRationalInPositiveConeFromNecSuf.lean`。sorry 検査 1403 件・check 497 ブロック・verify-check-linkage 280 件・build:pdf 269 ページ通過。
- **2026-08-18 の tick 405 は、台帳の先頭行「$\mathcal F_L$ が空でないこと（$L\ge2$）」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_fisher_zero_set_nonempty`: $(0,0)$ のスピンだけを反転した配位で正の破れボンド数 $m$ と $\Omega_L(m)\ge1$ を得るため、$Z_L$ の正次数係数は零でない。係数を $\overline{\mathbb Q}$ へ送った多項式へ代数閉性を使って根を取った。$L=1$ は $Z_1=2$ で零点が無いことも SageMath で確認した。Lean 具体版・必要十分版・導出版。sorry 検査 1399 件・check 496 ブロック・verify-check-linkage 279 件・build:pdf 269 ページ通過。
- **2026-08-18 の tick 404 は、台帳の先頭行「$R$ の空でない有限集合は最小元をちょうど 1 つ持つ」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_real_algebraic_min_unique`（`claim_real_algebraic_order_transitive` の直後）: 空でない有限部分集合 $X\subset R$ に「$m\in X$ かつ任意の $y\in X$ について $y=m$ または $m<_Ry$」を満たす $m$ がちょうど 1 つ存在する。存在は $|X|$ の帰納法（三分法で新しい元 $x_1$ と古い最小元 $x_2$ を比べ、$x_1<_Rx_2$ の枝で tick 403 の推移律を使う）、一意性は三分法の排他性。骨組みは `claim_row_config_min_unique` と同じ。
  SageMath `check/real-algebraic-min-unique/`（3 節。`AA` のモデルで、6 元の基底集合の空でない部分集合 63 個すべての一意性・証人 $\sqrt{y-m}$ の非零性・帰納法の一歩の場合分け。通過）。Lean 具体版 `FisherZero/RealAlgebraicMinUnique.lean`（`existsUnique_realAlgebraicMin`。`Finset.Nonempty.cons_induction` で人手証明と同じ帰納法）。必要十分版は新設せず、行配位の最小元のために書いた `NecSuf.AlgebraicEigenvalue.existsUnique_min`（比較可能性・推移律・非対称性だけを仮定に取る形）を引く（同じ議論を二箇所に置かない）。導出版 `RealAlgebraicMinUniqueFromNecSuf.lean`。sorry 検査 1396 件・check 495 ブロック・verify-check-linkage 278 件・build:pdf 268 ページ通過。
  運用: この tick の走行中（01:37〜01:41）、別の対話セッション（tmux `math` の lambda 窓）が同じセクションを並行編集し、tick が書いた本文ブロックが相手の撤回操作で一度失われた。書き直して完了した。相手は自分の重複分を撤去して tick の結末を待つと宣言しており、origin/main への重複 push は無い。
- 全章（何も言っていない主張の一掃）: 1 セクション
- 零点の詰め寄り・固有値の代数性（本文の lean: から引かれていない Lean の配線）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 臨界指数を零点列で書く | 分配多項式の臨界点での値は正錐の元である | todo | 有限和の帰納法。各項 $\Omega_L(m)\,x_c^m$ は `claim_quadratic_positive_cone_nat_mul` で零元または正錐（冪は `claim_quadratic_positive_cone_pow_closed`、$x_c\in P_s$ は `def_critical_point`）。和は `claim_quadratic_positive_cone_add_closed`（正錐＋零元は $\overline{\mathbb Q}$ の四則）。正の項の存在は $\Omega_L(0)\ge1$（全スピン一致の配位。本文に無ければ証明内で示す） |
| 臨界指数を零点列で書く | $x_c$ は Fisher 零点でない | todo | 前行の値が $P_s$ に入ることと $0\notin P_s$（`claim_quadratic_zero_representation` の組 $(0,0)$ は三条件を満たさない）から値が非零。`def_finite_lattice_fisher_zeros` へ当てる背理法。骨組みは `claim_positive_rational_not_fisher_zero` と同じ |
| 臨界指数を零点列で書く | 零点と臨界点の距離の二乗の零性は一致と同値 | todo | `claim_distance_squared_zero_iff_equal` の $q\in\mathbb Q$ を $x_c\in R$ へ置き換えるだけ（証明は同じ骨組み。$q\in R$ の根拠が `claim_critical_point_mem_real_closed` に変わる） |
| 臨界指数を零点列で書く | 先頭距離 $d_1(L)$ の定義と正値性 | todo | $d_1(L):=\min_{\xi\in\mathcal F_L}\mathrm{dsq}_c(\xi)\in R$（最小元は `claim_real_algebraic_min_unique`、非空は `claim_fisher_zero_set_nonempty`、有限は `claim_fisher_zero_set_finite_card_bound`）。正値性は非零（前 2 行）＋二平方和が平方（`claim_real_closed_sum_of_two_squares_is_square`）＋順序の定義 |
| 臨界指数を零点列で書く | 先頭距離の列と詰め寄りの述語の接続（可算な言明） | todo | $\{d_1(L)\}_{L\ge2}$ と `def_zero_pinching_predicate` を結ぶ。量化は $\mathbb Q$ 上 |
| 臨界指数を零点列で書く | 有限サイズスケーリングの読み（ℝ 脱出） | todo | 距離列の増大率と指数 $\nu$ の読み取り。実対数・極限を使うのでここだけ脱出を宣言する。厳密に言える範囲は討議ノート「何が厳密で何が非厳密か」に従って絞る |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録
- 2026-08-18（tick 408）: 台帳の先頭行「分配多項式の臨界点での値は正錐に入り、$x_c$ は Fisher 零点でない」を論法単位の 3 行（自然数倍の場合分け／有限和の帰納法／背理法）へ割り、その最初「正錐の元の自然数倍は零元または正錐の元である」を四層で閉じた。`claim_quadratic_positive_cone_nat_mul` を冪の閉性の直後に置いた。SageMath 48 組、Lean 具体版・必要十分版・導出版。sorry 検査 1411 件・check 499 ブロック・verify-check-linkage 282 件・PDF 270 ページ通過。
- 2026-08-18（tick 407）: 台帳の先頭行「正錐の元の冪は正錐の元である」を実行し、`claim_quadratic_positive_cone_pow_closed` を正の有理数の正錐所属の直後に置いた。自然数の帰納法で、基底は $1\in Q_s\cap P_s$、帰納段は $Q_s$ の乗法閉性と正錐の乗法閉性を引く。SageMath 1 節、Lean 具体版・必要十分版・導出版。sorry 検査 1407 件・check 498 ブロック・verify-check-linkage 281 件・PDF 270 ページ通過。
- 2026-08-18（tick 406）: 台帳の先頭行「先頭距離 $d_1(L)$ の定義と正値性」を論法単位の 5 行（正の有理数は正錐／冪は正錐／値が正錐で $x_c\notin\mathcal F_L$／距離の零性の同値／最小元の定義と正値性）へ割り直し、その最初「正の有理数は正錐の元である」を四層で閉じた。`claim_positive_rational_in_positive_cone` を `claim_quadratic_positive_cone_mul_closed` の直後に置いた。SageMath 1 節、Lean 具体版・導出版（必要十分版は既存 `positive_of_representation_necSuf` を再利用）。sorry 検査 1403 件・check 497 ブロック・PDF 269 ページ通過。
- 2026-08-18（tick 405）: 台帳の先頭行「$\mathcal F_L$ が空でないこと（$L\ge2$）」を四層で閉じた。一スピン反転から正次数の非零係数を作り、$\overline{\mathbb Q}$ の代数閉性で根を取った。SageMath は $L=1$ の例外と $L=2,3$ の正次数係数・根を厳密確認。Lean 具体版・必要十分版・導出版。sorry 検査 1399 件・check 496 ブロック・verify-check-linkage 279 件・PDF 269 ページ通過。式変形統一は姉妹側「$V_1,V_2$ を $Z,Y,\varepsilon$ で表す」の境界項 $\sigma_M^z\sigma_1^z$ の二等号を、一続き二段・各行の根拠つきへ揃えた（内容不変）。
- 2026-08-18（tick 404）: 台帳の先頭行「$R$ の空でない有限集合は最小元をちょうど 1 つ持つ」を四層で閉じ、`claim_real_algebraic_min_unique` を推移律の直後に置いた。存在は $|X|$ の帰納法（三分法＋推移律）、一意性は三分法の排他性。必要十分版は行配位の最小元の `existsUnique_min` を再利用（同じ議論を二箇所に置かない）。SageMath 3 節、Lean 具体版・導出版。sorry 検査 1396 件・check 495 ブロック・PDF 268 ページ通過。
## 式変形の書き方の統一（並列の作業ストリーム。毎 tick 1 件）

規則は両プロジェクトの README にある「式変形は一続きにする。根拠は行末に $(\because\ \dots)$ で書く」。
**毎 tick 1 件だけ**書き換え、検証を通し、ここへ記録する。中身は変えない（書き方だけ）。

- 2026-08-18（tick 408）: 姉妹側「$V_1,V_2$ を $Z,Y,\varepsilon$ で表す」（`004_transfer_matrix.ts`）の Step 3 で、散文「両辺に $-i$ を掛け」と単独の等式に分かれていた $\sigma_M^z\sigma_1^z=-i\,\varepsilon\,Y_MZ_1$ の導出を、$(-i)\cdot i=1$ を明示する一続き三段・各行の根拠つきへ揃えた（内容・参照は不変。tick 407 が Step 2 に施した形と同型）。姉妹側 check・PDF 325 ページ通過。

- 2026-08-18（tick 407）: 姉妹側「$V_1,V_2$ を $Z,Y,\varepsilon$ で表す」（`004_transfer_matrix.ts`）の Step 2 で、散文「両辺に $i$ を掛ける」と単独の等式に分かれていた $\sigma_m^z\sigma_{m+1}^z=iY_mZ_{m+1}$ の導出を、$i(-i)=1$ を明示する一続き三段・各行の根拠つきへ揃えた（内容・参照は不変）。姉妹側 check・PDF 325 ページ通過。

- 2026-08-18（tick 406）: 姉妹側「クロネッカー積上の Pauli 行列の積公式」（`004_transfer_matrix.ts`）の Step 1 で、一行に等号 3〜4 個と根拠 1 つで書かれていた $\sigma^x\sigma^x=I$ と $\sigma^y\sigma^z=i\sigma^x$ の二本の鎖を、各一続き（1 行 1 等号・行末根拠つき）へ揃えた（内容・参照は不変）。姉妹側 check・PDF 325 ページ通過。

- 2026-08-18（tick 405）: 姉妹側「$V_1,V_2$ を $Z,Y,\varepsilon$ で表す」（`004_transfer_matrix.ts`）の Step 1 で、一行に二つの等号を置いていた境界項 $\sigma_M^z\sigma_1^z$ の計算を、一続き二段へ分け、各行末にクロネッカー積の積の規則を明記した（内容・参照は不変）。姉妹側 check・PDF 325 ページ通過。

- 2026-08-18（tick 404）: 姉妹側「クリフォード群（正規化群）の定義」（`008_TV1_hatZ_hatY_part1.ts`）で、$\mathcal C_M$ が部分群であることの散文中の鎖 $(g_1g_2)\mathcal P_M(g_1g_2)^{-1}=g_1(g_2\mathcal P_Mg_2^{-1})g_1^{-1}=\mathcal P_M$ を一続き三段（行末根拠つき。積の逆元と結合則／$g_2\in\mathcal C_M$／$g_1\in\mathcal C_M$）へ揃えた（内容・参照は不変）。姉妹側 check・PDF 325 ページ通過。


### 本プロジェクト（`exact-solution-of-2d-ising-model-lambda`）

| 証明 | 状態 |
|---|---|
| 分配多項式の係数は多重度である | 済（2026-08-08） |
| 多重度の総和は配位の総数に等しい | 済（2026-08-08） |
| すべての配位を等しく数える点での自由エントロピー | 済（2026-08-08） |

（済んだ分の一覧は [auto-loop-archive.md](auto-loop-archive.md)。）

## レビュー記録
- 2026-08-18（tick 408）: tick 407 の「正錐の元の冪は正錐の元である」の本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、一致した。修正なし。この主張は臨界点での値の各項の冪を担い、今 tick の自然数倍と後続の有限和の帰納法が直接引くため「何も言っていない主張」ではない。本文末尾「この先に書くこと」とセクション表の食い違いなし。
- 2026-08-18（tick 407）: tick 406 の「正の有理数は正錐の元である」の本文・SageMath・Lean 具体版・既存必要十分版からの導出版を突き合わせ、一致した。修正なし。この主張は $q\in Q_s$ と $q\in P_s$ を確定し、今 tick の冪の基底 $1\in P_s$ と後続の自然数係数倍が直接引くため「何も言っていない主張」ではない。本文末尾「この先に書くこと」とセクション表の食い違いなし。
- 2026-08-18（tick 406）: tick 405 の「$\mathcal F_L$ が空でないこと（$L\ge2$）」の本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、一致した。修正なし。この主張は最小元の定義（先頭距離）の非空条件を担うため「何も言っていない主張」ではない。本文末尾「この先に書くこと」とセクション表の食い違いなし。
- 2026-08-18（tick 405）: tick 404 の「実閉部分体の空でない有限集合は最小元をちょうど 1 つ持つ」の本文・SageMath・Lean 具体版・既存必要十分版からの導出版を突き合わせ、一致した。修正なし。この主張は有限集合での最小元の存在・一意性を述べ、後続の先頭距離定義が直接引くため「何も言っていない主張」ではない。
- 2026-08-18（tick 404）: tick 403 の「実代数的数の狭義順序は推移的である」の本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、一致した。修正なし。この主張は最小元の存在の帰納法が直接引くため「何も言っていない主張」ではない。
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
