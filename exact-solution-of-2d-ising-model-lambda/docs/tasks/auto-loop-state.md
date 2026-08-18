# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地
- **2026-08-18 の tick 419 は、台帳の先頭行「臨界点の正値性」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_critical_point_positive`: 第 5 条件の $s=w^2$ と二平方和の平方表示 $s+1=w^2+1^2=v^2$ を用い、二平方和の零性から $v\ne0$、$(s-1)(s+1)=s^2-1=1$ から $x_c=s-1=(v^{-1})^2$ を得て $0<_Rx_c$ とした。SageMath `check/critical-point-positive/`（`AA` 厳密）、Lean 具体版・必要十分版（体の四則、平方和の平方表示と零性だけ）・導出版。sorry 検査 1457 件・check 509 ブロック・verify-check-linkage 290 件・build:pdf 275 ページ通過。
- **2026-08-18 の tick 418 は、台帳の計画（$[0,1]$ の等分と正の有理端点）が現状の固定では証明不能である（$0<_Rx_c$ が $s$ と $(R,\omega)$ の独立な選択に依存する）ことを見つけ、最小修復として `def_real_closed_subfield` の組の固定に第 5 条件「$s$ が $R$ の平方」を加えた。**
  第 1〜4 条件だけでは $s$ と $-s$ のどちらが $R$ の平方かが組の選び方で変わり、$0<_Rx_c$ も「正の有理数 $q$ で $(x_c-q)^2<_R\delta$」も選択依存の主張になって述べられない（$s\mapsto-s$ で $x_c$ は共役根 $-1-s$ に移る）。既存の主張はすべて第 1〜4 条件しか使わないので影響しない。存在は Artin–Schreier（$s$ を正とする順序体 $\mathbb{Q}(s)$ の実閉包）で従来と同格の既知事実として引く。Lean は基底構造を変えず拡張構造 `RealClosedSubfieldSqrtTwoData` を追加、SageMath は `check/real-closed-subfield/` に第 5 条件（証人 $w=2^{1/4}$）の節を追加して再実行・通過。「臨界点を挟む有理等分区間」は、臨界点の正値性・上界を先に置く 3 行へ割り直した。式変形統一は姉妹側「Pauli 行列の生成」の二つの鎖の先頭行へ根拠を足し、姉妹側 check 300 ブロック・PDF 327 ページ通過。sorry 検査 1439 件・check 508 ブロック・verify-check-linkage 289 件・build:pdf 275 ページ通過。
- **2026-08-18 の tick 417 は、「臨界点への有理近似」を有限等分の三論法へ割り、その最初「正の有理数より平方が小さい有理網幅」を四層で閉じた（住処 Q、脱出なし）。**
  `claim_positive_rational_mesh_width`: 任意の $\delta\in\mathbb Q_{>0}$ に対し、$1\le N$ かつ $h_N:=1/N>0$、$h_N^2<\delta$ を満たす $N\in\mathbb N$ が存在する。$\varepsilon:=\min\{\delta,1\}$ と置き、$\mathbb Q$ の Archimedes 性から $1/(n+1)<\varepsilon$ を取って、$h_N^2<h_N<\varepsilon\le\delta$ とした。この存在は体の四則だけでは出ないため「何も言っていない主張」ではない。SageMath `check/positive-rational-mesh-width/`（正の有理数 6 個、`QQ` 厳密）。Lean 具体版・必要十分版（Archimedes 的な線型順序体まで）・導出版。sorry 検査 1439 件・check 508 ブロック・verify-check-linkage 289 件・build:pdf 275 ページ。式変形統一は姉妹側「$V_1$ の固有空間への制限」の Step 5 の帰納法の出発点を一続き四段へ開き、姉妹側 check 300 ブロック・PDF 327 ページ通過。
- **2026-08-18 の tick 416 は、台帳の先頭行「和の平方の評価」を四層で閉じた（住処 Qbar、脱出なし）。**
  `claim_square_of_sum_le_twice_sum_of_squares`: 任意の $u,v\in R$ について $(u+v)\cdot(u+v)\le_R2\cdot(u\cdot u)+2\cdot(v\cdot v)$。差 $D=(2u^2+2v^2)-(u+v)^2$ を三段の式変形（展開・同類項・因数分解）で $(u-v)\cdot(u-v)$ へ変形し、$u=v$ なら差が零元で `def_real_algebraic_nonstrict_order` の等号の枝、$u\ne v$ なら $w:=u-v\ne0$ が平方の証人で狭義順序の枝。前 tick の確定どおり加法単調性の独立主張は作っていない。SageMath `check/square-of-sum-le-twice-squares/`（`AA` の標本 7 個の全 49 組で式変形の各段と両枝を厳密確認）。Lean 具体版 `CriticalExponent/SquareOfSumLeTwiceSquares.lean`、必要十分版 `NecSuf/CriticalExponent/SquareOfSumLeTwiceSquares.lean`（`squareOfSum_le_twiceSumOfSquares_necSuf`。CommRing だけを仮定し、体・三分法・実閉性を落とす）、導出版。sorry 検査 1436 件・check 507 ブロック・verify-check-linkage 288 件・build:pdf 274 ページ、および姉妹側 check 300 ブロック・PDF 326 ページ通過。
- **2026-08-18 の tick 415 は、台帳の先頭行「順序の加法単調性」を独立した主張にしないと確定し、todo から除いた。**
  $b<_Rc$ から $a+b<_Ra+c$ を得る段は、差 $(a+c)-(a+b)=c-b$ が変わらないという $R$ の四則と `def_real_algebraic_strict_order` の定義を展開するだけであり、runbook が削除対象として明記する「両辺に同じものを足す」ブロックそのものである。本文・SageMath・Lean は追加せず、後続「和の平方の評価」の該当行末へ「$R$ の四則と狭義順序の定義」と書く。式変形統一は姉妹側「$V_1$ の固有空間への制限」の Step 4 冒頭で、$G-G^{(\pm)}$ の一等号に束ねていた定義の代入・分配・共通項の相殺を一続き三段へ開いた。sorry 検査 1433 件・check 506 ブロック・verify-check-linkage 287 件・build:pdf 274 ページ、および姉妹側 check 300 ブロック・PDF 326 ページ通過。
- 全章（何も言っていない主張の一掃）: 1 セクション
- 零点の詰め寄り・固有値の代数性（本文の lean: から引かれていない Lean の配線）: 1 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 臨界指数を零点列で書く | 臨界点は一より小さい | todo | $x_c<_R1$。$1-x_c=2-s=s\cdot s-s=s\cdot(s-1)=s\cdot x_c$ が正の積（$s=w\cdot w$、$x_c=(1/v)^2$ から $(w/v)\cdot(w/v)$、$w/v\ne0$） |
| 臨界指数を零点列で書く | 臨界点を挟む有理等分区間 | todo | $N\ge1$ に対し $k/N\le_Rx_c<_R(k+1)/N$ なる $k\in\mathbb{N}$、$k+1\le N$ の存在。集合 $\{k\le N:\ \iota(k/N)\le_Rx_c\}$ の最大元。$0$ の所属は正値性、$N$ の非所属は上界と推移律・三分法 |
| 臨界指数を零点列で書く | 挟み込み区間から臨界点への有理近似を取る | todo | 正の有理端点を $q$ とし、区間幅の平方が $\delta$ 未満であることから $(x_c-q)^2<_R\delta$ を出す |
| 臨界指数を零点列で書く | 先頭距離の詰め寄りから述語 Pinch を導く（接続の完成） | todo | 上界の同値・和の平方の評価・有理近似を合成し、`def_zero_pinching_predicate` の $\mathbb Q$ 上の量化へ落とす |
| 臨界指数を零点列で書く | 有限サイズスケーリングの読み（ℝ 脱出） | todo | 距離列の増大率と指数 $\nu$ の読み取り。実対数・極限を使うのでここだけ脱出を宣言する。厳密に言える範囲は討議ノート「何が厳密で何が非厳密か」に従って絞る |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録
- 2026-08-18（tick 419）: 台帳の先頭行「臨界点の正値性」を実行し、`claim_critical_point_positive` を有理網幅の直後に置いた。第 5 条件、二平方和の平方表示と零性、$R$ の四則から $x_c=(v^{-1})^2$ を得た。SageMath `AA` 厳密検査、Lean 具体版・必要十分版・導出版。sorry 検査 1457 件・check 509 ブロック・verify-check-linkage 290 件・PDF 275 ページ通過。
- 2026-08-18（tick 418）: セクション「臨界点を挟む有理等分区間」に着手したところ、$[0,1]$ の等分と正の有理端点という計画そのものが、$0<_Rx_c$ の選択依存性（$s\mapsto-s$ の取り替えで $x_c$ が共役根 $-1-s$ に移る一方、$(R,\omega)$ の固定は「どれを固定したかに依存する主張は述べない」を要求する）により証明不能と分かった。最小修復として `def_real_closed_subfield` に第 5 条件「零元でない $w\in R$ で $s=w\cdot w$」を追加（本文・Lean 拡張構造 `RealClosedSubfieldSqrtTwoData`・SageMath 第 5 条件節）。セクションを「臨界点の正値性」「臨界点は一より小さい」「臨界点を挟む有理等分区間」の 3 行へ割り直した。sorry 検査 1439 件・check 508 ブロック・verify-check-linkage 289 件・PDF 275 ページ通過。
- 2026-08-18（tick 417）: 「臨界点への有理近似」を、有限等分の網幅／臨界点を挟む隣接区間／近似点の抽出の三論法へ割り、その最初「正の有理数より平方が小さい有理網幅」を実行した。`claim_positive_rational_mesh_width` を和の平方の評価の直後に置き、$\mathbb Q$ の Archimedes 性から $h_N^2<\delta$ を示した。SageMath 6 個、Lean 具体版・必要十分版（Archimedes 的な線型順序体）・導出版。sorry 検査 1439 件・check 508 ブロック・verify-check-linkage 289 件・PDF 275 ページ通過。
- 2026-08-18（tick 416）: 台帳の先頭行「和の平方の評価」を実行し、`claim_square_of_sum_le_twice_sum_of_squares` を上界の同値の直後に置いた。差 $(2u^2+2v^2)-(u+v)^2$ を三段の式変形で $(u-v)\cdot(u-v)$ へ変形し、$u=v$／$u\ne v$ の場合分けで広義順序の二枝へ落とした。SageMath 49 組、Lean 具体版・必要十分版（CommRing のみ）・導出版。sorry 検査 1436 件・check 507 ブロック・verify-check-linkage 288 件・PDF 274 ページ通過。
- 2026-08-18（tick 415）: 台帳の先頭行「順序の加法単調性」は、差 $(a+c)-(a+b)=c-b$ が変わらないという $R$ の四則と狭義順序の定義を展開するだけで、runbook が「何も言っていない主張」の例として明記する「両辺に同じものを足す」に一致するため、独立ブロック・SageMath・Lean を作らず todo から除いた。後続「和の平方の評価」の式変形内で行末根拠として使う。sorry 検査 1433 件・check 506 ブロック・verify-check-linkage 287 件・PDF 274 ページ通過。
## 式変形の書き方の統一（並列の作業ストリーム。毎 tick 1 件）

規則は両プロジェクトの README にある「式変形は一続きにする。根拠は行末に $(\because\ \dots)$ で書く」。
**毎 tick 1 件だけ**書き換え、検証を通し、ここへ記録する。中身は変えない（書き方だけ）。

- 2026-08-18（tick 418）: 姉妹側「Pauli 行列の生成」（`004_transfer_matrix.ts` の $\sigma_k^a\sigma_k^b$・$\sigma_k^a\sigma_l^b$ の二つの鎖。同一証明ブロック）で、根拠の無かった先頭行（定義の代入）へ行末の $(\because\ \dots)$ を足した（内容・参照は不変）。姉妹側 check 300 ブロック・PDF 327 ページ通過。

- 2026-08-18（tick 417）: 姉妹側「$V_1$ の固有空間への制限」（`004_transfer_matrix.ts`）の Step 5 で、帰納法の出発点「$n=0$ は両辺 $f$」を、写像の零乗／恒等写像の定義／恒等写像の定義／写像の零乗、の一続き四段・各行根拠つきへ開いた（内容・参照は不変）。姉妹側 check 300 ブロック・PDF 327 ページ通過。

- 2026-08-18（tick 416）: 姉妹側「$V_1$ の固有空間への制限」（`004_transfer_matrix.ts`）の Step 4 後半で、一等号に束ねていた $\mathbf{end}$ の線型性・$G-G^{(\pm)}$ の表示の代入・積の保存（$\widehat{\varepsilon W}=\hat\varepsilon\circ\hat W$）・$f$ への評価を、一続きの鎖（全体で八段）・各行の根拠つきへ開いた（内容・参照は不変）。姉妹側 check 300 ブロック・PDF 326 ページ通過。

- 2026-08-18（tick 415）: 姉妹側「$V_1$ の固有空間への制限」（`004_transfer_matrix.ts`）の Step 4 冒頭で、一等号に束ねていた $G,G^{(\pm)}$ の定義の代入／スカラー倍の分配／共通の有限和の相殺を、一続き三段・各行の根拠つきへ揃えた（内容・参照は不変）。姉妹側 check 300 ブロック・PDF 326 ページ通過。

- 2026-08-18（tick 414）: 姉妹側「$\varepsilon$ の固有空間」（`004_transfer_matrix.ts`）で、$\varepsilon^2=I_{\mathrm{Mat}(2^M,\mathbb C)}$ の二等号を 1 つの根拠で束ねていた表示を、$\varepsilon$ の定義の代入／クロネッカー積の積の規則／$\sigma^x\sigma^x=I$ の各因子への適用／単位元の規則、の一続き四段・各行の根拠つきへ揃えた（内容・参照は不変）。姉妹側 check・PDF 326 ページ通過。

- 2026-08-18（tick 413）: 姉妹側「$\mathbf{end}$ は単位的 $\mathbb C$-代数の同型」（`004_transfer_matrix.ts`）の Step 4 結論で、散文に圧縮されていた $\mathbf{end}(I)=\mathrm{id}_{\mathcal F}$ を、単位行列の行列単位展開／$\mathbf{end}$ の線型性／$\mathbf{end}(E_{I,I})=\Theta_{I,I}$／基底上で示した恒等写像との一致、の一続き四段・各行の根拠つきへ揃えた（内容・参照は不変）。姉妹側 check・PDF 326 ページ通過。



### 本プロジェクト（`exact-solution-of-2d-ising-model-lambda`）

| 証明 | 状態 |
|---|---|
| 分配多項式の係数は多重度である | 済（2026-08-08） |
| 多重度の総和は配位の総数に等しい | 済（2026-08-08） |
| すべての配位を等しく数える点での自由エントロピー | 済（2026-08-08） |

（済んだ分の一覧は [auto-loop-archive.md](auto-loop-archive.md)。）

## レビュー記録
- 2026-08-18（tick 419）: tick 418 の「実閉部分体の固定に第 5 条件を追加」を本文・SageMath・Lean 拡張構造で突き合わせ、一致した。SageMath も再実行して通過。この条件は固定した $s$ と順序の向きを整合させ、今 tick の正値性と次 tick の上界が直接引くため「何も言っていない主張」ではない。修正なし。本文末尾「この先に書くこと」とセクション表の食い違いなし。
- 2026-08-18（tick 418）: tick 417 の「正の有理数より平方が小さい有理網幅」の本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、一致した。SageMath 6 個も再実行して通過し、修正なし。この主張は $\mathbb{Q}$ の Archimedes 性を使う存在言明であり「何も言っていない主張」ではない。本文末尾「この先に書くこと」とセクション表の食い違いなし。
- 2026-08-18（tick 417）: tick 416 の「和の平方は平方和の二倍以下である」の本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、三段の恒等式と $u=v$／$u\ne v$ の二枝が一致した。SageMath 49 組も再実行して通過し、修正なし。この主張は後続が距離の差を二項へ分けたあと直接引く平方評価であり、体の四則だけを独立させた「何も言っていない主張」ではない。姉妹側 Step 4 後半も内容・参照が不変の八段になっていた。本文末尾「この先に書くこと」とセクション表の食い違いなし。
- 2026-08-18（tick 416）: tick 415 の二つの出力（「順序の加法単調性」を todo から除く判断と、姉妹側 Step 4 冒頭の書き換え）を突き合わせた。除去の判断は runbook が削除対象として明記する「両辺に同じものを足す」に一致し、本文・SageMath・Lean に対応物が無いことも確認した。姉妹側の書き換えは内容・参照が不変で一続き三段・各行根拠つきになっている。修正なし。本文末尾「この先に書くこと」とセクション表の食い違いなし。
- 2026-08-18（tick 415）: tick 414 の「先頭距離が上界未満であることと上界未満の零点の存在は同値」の本文・SageMath・Lean 具体版・必要十分版・導出版を突き合わせ、一致した。SageMath 8 組も再実行して通過し、修正なし。この主張は先頭距離の最小性を個々の零点の存在量化へ接続し、後続の詰め寄りの接続が直接引くため「何も言っていない主張」ではない。本文末尾「この先に書くこと」とセクション表の食い違いなし。
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
