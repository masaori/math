# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地
- **2026-08-18 の tick 415 は、台帳の先頭行「順序の加法単調性」を独立した主張にしないと確定し、todo から除いた。**
  $b<_Rc$ から $a+b<_Ra+c$ を得る段は、差 $(a+c)-(a+b)=c-b$ が変わらないという $R$ の四則と `def_real_algebraic_strict_order` の定義を展開するだけであり、runbook が削除対象として明記する「両辺に同じものを足す」ブロックそのものである。本文・SageMath・Lean は追加せず、後続「和の平方の評価」の該当行末へ「$R$ の四則と狭義順序の定義」と書く。式変形統一は姉妹側「$V_1$ の固有空間への制限」の Step 4 冒頭で、$G-G^{(\pm)}$ の一等号に束ねていた定義の代入・分配・共通項の相殺を一続き三段へ開いた。sorry 検査 1433 件・check 506 ブロック・verify-check-linkage 287 件・build:pdf 274 ページ、および姉妹側 check 300 ブロック・PDF 326 ページ通過。
- **2026-08-18 の tick 414 は、台帳の先頭行「先頭距離の列と詰め寄りの述語の接続」を論法単位の 5 行へ割り、その最初「先頭距離が上界未満であることと上界未満の零点の存在は同値」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_leading_distance_lt_iff_close_zero`: $L\ge2$、$t\in R$ について $d_1(L)<_Rt\iff\exists\xi\in\mathcal F_L,\ \mathrm{dsq}_c(\xi)<_Rt$。左向きは $d_1(L)\in D_L$ の証人、右向きは最小性の場合分け（等しい枝は書き換え、大きい枝は `claim_real_algebraic_order_transitive`）。のちに $t:=\varepsilon\cdot\varepsilon$（$\varepsilon\in\mathbb Q_{>0}$）と取り、`def_zero_pinching_predicate` と同じ形の $\mathbb Q$ 上の量化の言明へ結ぶ接続である。
  SageMath `check/leading-distance-lt-iff/`（$L=2$ × $s$ 2 根 × 上界 4 個の 8 組で真偽の一致。`AA` 厳密）。Lean 具体版 `CriticalExponent/LeadingDistanceLtIff.lean`、必要十分版 `NecSuf/CriticalExponent/LeadingDistanceLtIff.lean`（`min_lt_iff_exists_lt_necSuf`。証人の存在・最小性・推移律だけを仮定し、体・三分法・有限集合・零元を落とす）、導出版。sorry 検査 1433 件・check 506 ブロック・verify-check-linkage 287 件・build:pdf 274 ページ通過。
- **2026-08-18 の tick 413 は、台帳の先頭行「先頭距離の正値性」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_leading_distance_positive`: $d_1(L)\in D_L$ の証人 $\xi\in\mathcal F_L$ を取り、$d_1(L)=0$ なら `claim_critical_distance_squared_zero_iff_equal` から $\xi=x_c$ となって `claim_critical_point_not_fisher_zero` に反する。さらに距離の二乗を `claim_real_closed_sum_of_two_squares_is_square` で $w^2$ と書き、非零性から $w\ne0$、`def_real_algebraic_strict_order` から $0<_Rd_1(L)$ を得た。
  SageMath は $L=2$ の全 16 零点・$s^2=2$ の二根で距離と最小値の正値性を `QQbar`/`AA` で厳密確認。Lean 具体版・必要十分版・導出版。sorry 検査 1430 件・check 505 ブロック・verify-check-linkage 286 件・build:pdf 273 ページ通過。式変形統一は姉妹側「$\mathbf{end}$ は単位的 $\mathbb C$-代数の同型」の Step 4 結論を四段の鎖へ揃え、姉妹側 check・PDF 326 ページ通過。
- **2026-08-18 の tick 412 は、台帳の先頭行「先頭距離 $d_1(L)$ の定義と正値性」を論法単位の 2 行（定義の well-defined 性／正値性）へ割り、その最初「先頭距離 $d_1(L)$ の定義」を本文と Lean 具体版で閉じた（定義ブロックなので必要十分版と SageMath は置かない。住処 Qbar、脱出なし）。**
  最終章の見出し「臨界指数を零点列で書く」を熱力学極限章の後に立て、`def_leading_distance` をその先頭に置いた（well-defined 性が熱力学極限章の `claim_fisher_zero_set_finite_card_bound` を引くため、前方参照を作らない位置はここになる）。$D_L:=\{y\in R\mid\exists\xi\in\mathcal F_L,\ y=\mathrm{dsq}_c(\xi)\}$ が空でなく（`claim_fisher_zero_set_nonempty`）有限（値の集合の元の個数は $\mathcal F_L$ を超えない）なので、`claim_real_algebraic_min_unique` で最小元がちょうど 1 つ取れ、それを $d_1(L)\in R$ とした。
  Lean 具体版 `CriticalExponent/LeadingDistance.lean`（`leadingDistanceFinset`（`Set.Finite.toFinset`）・`mem_leadingDistanceFinset`・`leadingDistanceFinset_nonempty`・`leadingDistance`（`Classical.choose`）・`leadingDistance_isMin`・`leadingDistance_unique`）。sorry 検査 1427 件・check 504 ブロック・verify-check-linkage 285 件・build:pdf 273 ページ通過。
- **2026-08-18 の tick 411 は、台帳の先頭行「零点と臨界点の距離の二乗の零性は一致と同値」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_critical_distance_squared_zero_iff_equal`: 一意表示 $\xi=a+b\omega$ と $x_c\in R$ を用い、$\mathrm{dsq}_c(\xi)=0\iff\xi=x_c$ を有理点版と同じ背理法で示した。$b\ne0$ なら $w=(a-x_c)b^{-1}$ が $w^2=-1$ を満たして `claim_neg_one_not_square` に反し、$b=0$ なら零因子が無いことから $a=x_c$。
  SageMath は $s^2=2$ の二根と代数的数 9 点ずつの 18 組を `AA`/`QQbar` で厳密確認。Lean 具体版、既存の必要十分核 `distanceSquaredOfPair_eq_zero_iff_necSuf`、導出版。sorry 検査 1424 件・check 502 ブロック・verify-check-linkage 285 件・build:pdf 272 ページ通過。式変形統一は姉妹側「$\mathbf{end}$ は単位的 $\mathbb C$-代数の同型」の Step 1 で、線型独立性の三等号を一続き三段・各行の根拠つきへ揃えた。姉妹側 check・PDF 326 ページ通過。
- 全章（何も言っていない主張の一掃）: 1 セクション
- 零点の詰め寄り・固有値の代数性（本文の lean: から引かれていない Lean の配線）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 臨界指数を零点列で書く | 和の平方の評価（$(u+v)\cdot(u+v)$ は $2u^2+2v^2$ に等しいか未満） | todo | $2u^2+2v^2-(u+v)^2=(u-v)^2$ が平方であることから。両辺への同一元の加算は独立主張にせず、行末に「$R$ の四則と狭義順序の定義」と書く |
| 臨界指数を零点列で書く | 臨界点への有理近似（任意の $\delta\in\mathbb Q_{>0}$ にある $q\in\mathbb Q_{>0}$ で $(x_c-q)^2<_R\delta$） | todo | $\sqrt2$ の有理近似列。着手時に論法（Newton か区間分割か）を 1 つに固定する |
| 臨界指数を零点列で書く | 先頭距離の詰め寄りから述語 Pinch を導く（接続の完成） | todo | 上界の同値・和の平方の評価・有理近似を合成し、`def_zero_pinching_predicate` の $\mathbb Q$ 上の量化へ落とす |
| 臨界指数を零点列で書く | 有限サイズスケーリングの読み（ℝ 脱出） | todo | 距離列の増大率と指数 $\nu$ の読み取り。実対数・極限を使うのでここだけ脱出を宣言する。厳密に言える範囲は討議ノート「何が厳密で何が非厳密か」に従って絞る |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録
- 2026-08-18（tick 415）: 台帳の先頭行「順序の加法単調性」は、差 $(a+c)-(a+b)=c-b$ が変わらないという $R$ の四則と狭義順序の定義を展開するだけで、runbook が「何も言っていない主張」の例として明記する「両辺に同じものを足す」に一致するため、独立ブロック・SageMath・Lean を作らず todo から除いた。後続「和の平方の評価」の式変形内で行末根拠として使う。sorry 検査 1433 件・check 506 ブロック・verify-check-linkage 287 件・PDF 274 ページ通過。
- 2026-08-18（tick 414）: 台帳の先頭行「先頭距離の列と詰め寄りの述語の接続（可算な言明）」を論法単位の 5 行（上界の同値／順序の加法単調性／和の平方の評価／臨界点への有理近似／接続の完成）へ割り、その最初「先頭距離が上界未満であることと上界未満の零点の存在は同値」を実行した。割った理由: 接続には順序の不等式評価と $\sqrt2$ の有理近似がまだ本文に無く、1 tick で閉じないため。`claim_leading_distance_lt_iff_close_zero` を先頭距離の正値性の直後に置いた。SageMath 8 組、Lean 具体版・必要十分版・導出版。sorry 検査 1433 件・check 506 ブロック・verify-check-linkage 287 件・PDF 274 ページ通過。
- 2026-08-18（tick 413）: 台帳の先頭行「先頭距離の正値性」を実行し、`claim_leading_distance_positive` を先頭距離の定義の直後に置いた。Fisher 零点が臨界点でないことから非零性を出し、二平方和の平方表示と狭義順序の定義から $0<_Rd_1(L)$ を得た。SageMath 16 零点・2 先頭距離、Lean 具体版・必要十分版・導出版。sorry 検査 1430 件・check 505 ブロック・verify-check-linkage 286 件・PDF 273 ページ通過。
- 2026-08-18（tick 412）: 台帳の先頭行「先頭距離 $d_1(L)$ の定義と正値性」を論法単位の 2 行（定義の well-defined 性／正値性）へ割り、その最初「先頭距離 $d_1(L)$ の定義」を実行した。最終章の見出し「臨界指数を零点列で書く」を立て、`def_leading_distance` をその先頭に置いた（有限性 `claim_fisher_zero_set_finite_card_bound` が熱力学極限章にあるため、前方参照を作らない位置）。定義ブロックなので Lean 具体版のみ（`CriticalExponent/LeadingDistance.lean`）。sorry 検査 1427 件・check 504 ブロック・verify-check-linkage 285 件・PDF 273 ページ通過。
- 2026-08-18（tick 411）: 台帳の先頭行「零点と臨界点の距離の二乗の零性は一致と同値」を実行し、`claim_critical_distance_squared_zero_iff_equal` を臨界点への距離の定義の直後に置いた。有理点版と同じ背理法を $x_c\in R$ へ適用。SageMath 18 組、Lean 具体版・既存必要十分版・導出版。sorry 検査 1424 件・check 502 ブロック・verify-check-linkage 285 件・PDF 272 ページ通過。
## 式変形の書き方の統一（並列の作業ストリーム。毎 tick 1 件）

規則は両プロジェクトの README にある「式変形は一続きにする。根拠は行末に $(\because\ \dots)$ で書く」。
**毎 tick 1 件だけ**書き換え、検証を通し、ここへ記録する。中身は変えない（書き方だけ）。

- 2026-08-18（tick 415）: 姉妹側「$V_1$ の固有空間への制限」（`004_transfer_matrix.ts`）の Step 4 冒頭で、一等号に束ねていた $G,G^{(\pm)}$ の定義の代入／スカラー倍の分配／共通の有限和の相殺を、一続き三段・各行の根拠つきへ揃えた（内容・参照は不変）。姉妹側 check 300 ブロック・PDF 326 ページ通過。

- 2026-08-18（tick 414）: 姉妹側「$\varepsilon$ の固有空間」（`004_transfer_matrix.ts`）で、$\varepsilon^2=I_{\mathrm{Mat}(2^M,\mathbb C)}$ の二等号を 1 つの根拠で束ねていた表示を、$\varepsilon$ の定義の代入／クロネッカー積の積の規則／$\sigma^x\sigma^x=I$ の各因子への適用／単位元の規則、の一続き四段・各行の根拠つきへ揃えた（内容・参照は不変）。姉妹側 check・PDF 326 ページ通過。

- 2026-08-18（tick 413）: 姉妹側「$\mathbf{end}$ は単位的 $\mathbb C$-代数の同型」（`004_transfer_matrix.ts`）の Step 4 結論で、散文に圧縮されていた $\mathbf{end}(I)=\mathrm{id}_{\mathcal F}$ を、単位行列の行列単位展開／$\mathbf{end}$ の線型性／$\mathbf{end}(E_{I,I})=\Theta_{I,I}$／基底上で示した恒等写像との一致、の一続き四段・各行の根拠つきへ揃えた（内容・参照は不変）。姉妹側 check・PDF 326 ページ通過。

- 2026-08-18（tick 412）: 姉妹側「$\mathbf{end}$ は単位的 $\mathbb C$-代数の同型」（`004_transfer_matrix.ts`）の Step 5 末尾で、散文中に圧縮されていた二等号の鎖 $(\mathbf{end}(E_{I,J}))(f_K)=\Theta_{I,J}(f_K)=\delta_{J,K}f_I$ を、一続き二段・各行の根拠つき（$\mathbf{end}$ の定義／$\Theta_{I,J}$ の定義）へ揃えた（内容・参照は不変）。姉妹側 check・PDF 326 ページ通過。

- 2026-08-18（tick 411）: 姉妹側「$\mathbf{end}$ は単位的 $\mathbb C$-代数の同型」（`004_transfer_matrix.ts`）の Step 1 で、線型独立性の確認が散文内の三等号 $0=\sum c_{I,J}\delta_{J,K}f_I=\sum c_{I,K}f_I$ に圧縮されていた箇所を、零写像の値・$\Theta_{I,J}$ の定義・Kronecker のデルタによる有限和の縮約の一続き三段へ揃えた（内容・参照は不変）。姉妹側 check・PDF 326 ページ通過。


### 本プロジェクト（`exact-solution-of-2d-ising-model-lambda`）

| 証明 | 状態 |
|---|---|
| 分配多項式の係数は多重度である | 済（2026-08-08） |
| 多重度の総和は配位の総数に等しい | 済（2026-08-08） |
| すべての配位を等しく数える点での自由エントロピー | 済（2026-08-08） |

（済んだ分の一覧は [auto-loop-archive.md](auto-loop-archive.md)。）

## レビュー記録
- 2026-08-18（tick 415）: tick 414 の「先頭距離が上界未満であることと上界未満の零点の存在は同値」の本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、一致した。SageMath 8 組も再実行して通過し、修正なし。この主張は先頭距離の最小性を個々の零点の存在量化へ接続し、後続の詰め寄りの接続が直接引くため「何も言っていない主張」ではない。本文末尾「この先に書くこと」とセクション表の食い違いなし。
- 2026-08-18（tick 414）: tick 413 の「先頭距離の正値性」の本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、一致した。修正なし。この主張は先頭距離の非零性と正値性を確定し、今 tick の上界の同値と後続の接続が直接引くため「何も言っていない主張」ではない。本文末尾「この先に書くこと」とセクション表の食い違いなし。
- 2026-08-18（tick 413）: tick 412 の「先頭距離の定義」の本文と Lean 具体版を突き合わせ、空でない有限集合 $D_L$ の最小元を一意に定める内容が一致した。修正なし。この定義は値の住処と well-defined 性を確定し、今 tick の正値性と後続の距離列が直接引くため「何も言っていない主張」ではない。本文末尾「この先に書くこと」とセクション表の食い違いなし。
- 2026-08-18（tick 412）: tick 411 の「零点と臨界点の距離の二乗の零性は一致と同値」の本文・SageMath・Lean 具体版・既存必要十分核・導出版を突き合わせ、一致した。修正なし。この主張は先頭距離の正値性（次 tick）が非零性の根拠として直接引くため「何も言っていない主張」ではない。本文末尾「この先に書くこと」とセクション表の食い違いなし。
- 2026-08-18（tick 411）: tick 410 の「臨界点は Fisher 零点でない」の本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、一致した。修正なし。この主張は有限格子での臨界値の非零性を述べ、今 tick の同値と次 tick の先頭距離の正値性が直接引くため「何も言っていない主張」ではない。本文末尾「この先に書くこと」とセクション表の食い違いなし。
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
