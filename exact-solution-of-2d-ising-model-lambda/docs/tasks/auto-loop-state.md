# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 起動: launchd `com.masaori.ising-lambda-auto-loop`（毎時 5 分。見送られたときの再試行が 35 分。上限 45 分）
- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-08-15 の tick 300 は、「対数順序群の順序」を「定義と線形順序性」と「加法単調性」へ割り、
  先頭を本文・SageMath・Lean（具体版・必要十分版・導出版）まで完成させた。** $\lambda\le_\Lambda\mu$ を
  $\operatorname{rat}_\Lambda(\lambda)\le\operatorname{rat}_\Lambda(\mu)$（有理数の比較）で定め、反射・推移・
  全順序性は $\mathbb Q$ の同名の性質へ落とし、反対称律だけ対数で $\Lambda$ の等号へ戻した。判定は有理数の比較なので
  決定可能。レビューでは前 tick の全射性の四層を突き合わせて修正無し。式変形統一では姉妹側「$A(\theta)=B_1(\theta)B_2B_1(\theta)$」の
  (1,2) 成分で、三つに切れていた鎖を補助等式を先に置いて一続きにした。次は「対数順序群の順序の加法単調性」。

- **2026-08-15 の tick 299 は、「正の有理数の対数は全射である」を本文・SageMath・Lean（具体版・
  必要十分版・導出版）まで完成させた。** 有限台指数ベクトルから正の有理数を有限積で作り、
  その対数が元の指数ベクトルへ戻ることを示した。単射性と合わせて対数は全単射となり、逆写像にも
  名前が付いた。レビューでは前 tick の単射性の四層を突き合わせて修正無し。式変形統一では姉妹側
  「共役作用の直積作用」が既に規則どおりであることを確認した。次は「対数順序群の順序」。

- **2026-08-15 の tick 298 は、「有理係数の対数順序群の順序の定義と線形順序性」を、対数写像
  $\log:\mathbb{Q}_{>0}\to\Lambda$ の単射性・全射性、$\Lambda$ の順序、$\Lambda_{\mathbb{Q}}$ の順序の
  定義と共通分母からの独立性、その線形順序性と加法単調性の五つへ割り、先頭の「正の有理数の対数は
  単射である」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで完成させた。** $\log q=\log q'$
  を各素数で読んで $v_p(ab')=v_p(a'b)$ を出し、有限積表示から $ab'=a'b$、有理数の約分で $q=q'$。
  レビューでは前 tick の分母消去の末尾（整数倍と $\iota$ の交換）が散文だけで検証対応が無かったので、
  五段の式変形と Lean・SageMath を足して先に push した。式変形統一では姉妹側「$T_{V_1}$ の
  $\check Z,\check Y$ への作用」で定義の代入と $\exp(X)^{-1}=\exp(-X)$ が一行だったのを二行へ分けた。
  次は「正の有理数の対数は全射である」。

- **2026-08-15 の tick 297 は、「有理係数の対数順序群の順序」を二つの論法へ割り、先頭の
  「有限系の密度の分母消去」を本文・SageMath・Lean（具体版・必要十分版・導出版）まで完成させた。**
  $L^{-2}\iota(\lambda)$ と $M^{-2}\iota(\mu)$ へ共通の正整数 $L^2M^2$ を掛けると、各々
  $M^2\iota(\lambda)$ と $L^2\iota(\mu)$ になり、順序を定める前に比較対象を $\Lambda$ の整数倍へ
  戻せることを確定した。レビューでは前 tick の有理係数群の本文・SageMath・Lean 三系統と姉妹側の
  式変形差分が一致しており、修正は無い。式変形統一では姉妹側「$T_g$ の複素線型性」が既に
  一続きの三段の式変形と行末根拠を持つことを確認し、書き換え不要とした。次は
  「有理係数の対数順序群の順序の定義と線形順序性」。

- **2026-08-15 の tick 296 は、「$\Lambda\otimes\mathbb{Q}$ の具体的構成」を本文・SageMath・Lean（具体版・
  必要十分版・導出版）まで完成させてセクションを閉じた。** 有理係数の対数順序群 $\Lambda_{\mathbb{Q}}$ を
  素数から $\mathbb{Q}$ への有限台の写像全体として（テンソル積の一般論も表示の同値類も使わず）定め、素数ごとの
  加法・有理数倍・写像 $\iota_{\Lambda\to\Lambda_{\mathbb{Q}}}$ を置き、$\iota$ が加法を保ち単射であることを
  示した。密度 $\tfrac{1}{L^2}\cdot\iota(\Phi_L(q))$ の住処が確定し、ここまで実数体は現れない。レビューでは
  前 tick は台帳の割り直しと姉妹側の根拠補強だけで数学内容の追加が無く、姉妹側の差分（実在ラベル参照・行列加法の
  可換則）を確認して修正無し。式変形統一では姉妹側「$T_{V_1},T_{V_2}$ の $\check Z,\check Y$ への作用」の
  $T_{V_2}$ 二本の鎖で、前因子 $(2s_2)^{M/2}$ の代入・スカラーの移動・相殺が一行に圧縮されていたのを三行へ分けた。
  次は「$\Lambda\otimes\mathbb{Q}$ の順序」。

（これより古い 253 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

## セクション台帳

**済んだ範囲**（章ごとの件数。個々の内訳は [auto-loop-archive.md](auto-loop-archive.md) と
MEMORY.md にある。番号で呼ばないので、ここでは章と件数だけを持つ）。

- 固有値の代数性: 128 セクション
- Fisher 零点: 44 セクション
- 分配多項式: 4 セクション
- 転送行列: 4 セクション
- 有限系の自由エントロピー: 8 セクション
- 形式検証の土台: 1 セクション
- 零点の詰め寄り: 5 セクション
- 熱力学極限: 28 セクション

**残っているもの**（この順に進める。tick は先頭の 1 件だけを実行する）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| 有限系の自由エントロピー | 対数順序群の順序の加法単調性 | todo | $\lambda\le_\Lambda\mu\Rightarrow\lambda+\nu\le_\Lambda\mu+\nu$。まず $\operatorname{rat}_\Lambda(\lambda+\nu)=\operatorname{rat}_\Lambda(\lambda)\operatorname{rat}_\Lambda(\nu)$ を対数の加法性と単射性から出し、正の有理数を掛ける単調性へ落とす |
| 熱力学極限 | 有理係数の対数順序群の順序の定義と共通分母からの独立性 | todo | 有限台の有理係数へ共通分母 $N\ge1$ を掛けて $N\cdot\lambda=\iota(\lambda_N)$、$\lambda_N\in\Lambda$ とし、$\lambda\le\mu:\iff\lambda_N\le\mu_N$。別の共通分母 $N'$ を取っても同じ判定になること（$N'\lambda_N=N\lambda_{N'}$ と $\Lambda$ の順序の正整数倍不変性）を示す |
| 熱力学極限 | 有理係数の対数順序群の順序の線形順序性と加法単調性 | todo | 三分律・推移律・加法単調性を、共通分母を揃えて $\Lambda$ の順序へ落として示す。決定可能性も述べる |
| 熱力学極限 | 有限系の実自由エントロピーを畳む | todo | $\varphi_L$（ℝ 値）と $\Phi_L$（$\Lambda$ 値）の二重持ちを解消し、有限系の主張・接合不等式・上下界を $\Phi_L$ 側へ寄せる |
| 熱力学極限 | 極限の存在を $\Lambda\otimes\mathbb{Q}$ の Cauchy 性として述べる | todo | 完備性（上限の存在）を使わずに、可算側の主張として収束の速さつきで述べる。各段の比較は有理数の比較なので決定可能 |
| 熱力学極限 | 切断による ℝ への一度きりの脱出 | todo | 「この有理数の列が定める切断として実数が存在する」だけを引く。章頭の「実数体への脱出の宣言」をここへ移し、完備性の宣言は不要になれば畳む |
| 熱力学極限 | 旧実数値経路を撤去する | todo | 可算側の密度・Cauchy 性・切断からの実数化が揃ったあと、$\varphi_L$ と実数値の上下限・上限／下限による極限経路、および対応する SageMath・Lean を削除し、参照と台帳を新経路へ揃える |
| 熱力学極限 | 開境界正方形と部分正方形の値の比較（$1\le t$ の場合） | todo | $1\le a<L$、$c=L-a$ に対し、接合不等式の $1\le t$ 側と値の下界 $1$・配位数による上界 $2^{ab}t^{2ab}$ で挟む。予定: $Z_{a,a}\le Z_{L,L}\le2^{L^2-a^2}t^{a+L+2(L^2-a^2)}Z_{a,a}$（$0<t\le1$ 側は済。Lean は `split_twice_bounds_necSuf` と同型の必要十分版で書ける見込み） |
| 熱力学極限 | 部分正方形との比較の対数化 | todo | $\psi^{\mathrm{op}}_L(t)$ を $\iota(a^2/L^2)\psi^{\mathrm{op}}_a(t)$ と $\log_{\mathbb R}t$・$\log_{\mathbb R}2$ の有理数倍で二場合に挟む |
| 熱力学極限 | 開境界密度の極限（$0<t\le1$ の場合） | todo | 任意近接の $a$ を固定し、$ka\le L<(k+1)a$ で $\psi^{\mathrm{op}}_L$ を $\psi^{\mathrm{op}}_{ka}$ で挟んで、下限 $v$ への $\varepsilon$–$N$ の言明を閉じる |
| 熱力学極限 | 開境界密度の極限（$1\le t$ の場合） | todo | 同じ論法で上限 $u$ への収束を閉じる |
| 熱力学極限 | 周期境界自由エネルギー密度への移送 | todo | 周期境界と開境界の境界評価から導く |
| 熱力学極限 | 零点密度 | todo | |
| 臨界指数を零点列で書く | 先頭零点の列と有限サイズスケーリング | todo | |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

## 前進の記録

- 2026-08-15（tick 300）: **割り直し**: 「対数順序群の順序」は、全単射 $\operatorname{rat}_\Lambda$ で
  $\mathbb Q$ の順序を引き戻す論法と、$\operatorname{rat}_\Lambda$ が積を保つことから加法単調性を出す論法が
  独立なので二つへ分けた。先頭の `def_log_order_group_order`・`claim_log_order_group_linear_order` を章
  「有限系の自由エントロピー」の全射性の直後に置き四層で閉じた。`def_log_order_group` の「順序はまだ定めない」の
  段落を新定義への参照へ直した。SageMath `log-order-group-linear-order` は 125 ベクトルの全対・全三つ組を `QQ` で
  厳密に。Lean 具体版 `FreeEntropy/LogOrderGroupOrder.lean`（`logOrderLE`、決定可能性、`logOrderLE_refl/trans/
  antisymm/total`）、必要十分版 `pullback_linear_order_necSuf`（線形順序への写像と左逆写像だけ）、導出版。
  sorry 検査 1090 件。式変形統一では姉妹側 `evensectorT_009_claim_factorization_A_theta` の Step 4（$P_{12}$）で、
  括弧内の補助等式を鎖の前へ出し、日本語で三つに切れていた鎖を一続きにし、補助等式の代入と $2ab=s_1$ を別行へ分けた。

- 2026-08-15（tick 299）: `def_rational_of_log` で有限台積
  $\operatorname{rat}_{\Lambda}(\lambda)=\prod_{p\in\operatorname{supp}(\lambda)}p^{\lambda(p)}$ を定め、
  `claim_rational_log_surjective` を四層で閉じた。SageMath は素数四つと係数五つの全 625 ベクトルを
  `ZZ`/`QQ` で厳密に検査した。Lean 具体版は素数・整数冪・有限積を本文と同じ順で辿り、必要十分版は
  正の生成元と対数の単位元・積・逆元・生成元規則だけを残した。式変形統一では姉妹側
  `evensectorT_008_claim_product_action` が既に一行一操作・行末根拠の形なので変更不要とした。

- 2026-08-15（tick 298）: **割り直し**: 「有理係数の対数順序群の順序の定義と線形順序性」は、本文に
  $\Lambda$ の順序がまだ無く（対数順序群の定義は「順序は必要な箇所で定める」と明記）、$\log$ の全単射性も
  未記述だったので、$\log$ の単射性／全射性／$\Lambda$ の順序／$\Lambda_{\mathbb{Q}}$ の順序の定義と共通分母
  独立性／線形順序性と加法単調性の五つへ割った（各々一つの論法）。先頭 `claim_rational_log_injective` を
  章「有限系の自由エントロピー」の「対数の冪の法則」の直後に置き四層で閉じた。SageMath
  `rational-log-injective` は 6561 件を `ZZ`/`QQ` で厳密に。Lean 具体版
  `FreeEntropy/RationalLogInjective.lean`（`primeExponent_cross_eq`・`nat_eq_of_primeExponent_eq`・
  `logRat_injective_of_pos`）、必要十分版 `cross_mul_eq_of_pointwise_sub_eq_necSuf`（可換群値の
  加法的写像の族が数を分離することだけ。素数・素因数分解・$\mathbb{Z}$ 値は不要）、導出版。sorry 検査 1078 件。
  式変形統一では姉妹側 `evensectorT_005_claim_T_actions` の $T_{V_1}$ 二本の鎖で定義の代入と
  $\exp(X)^{-1}=\exp(-X)$ を二行へ分けた。

- 2026-08-15（tick 297）: **割り直し**: 「$\Lambda\otimes\mathbb{Q}$ の順序」は、有限系密度の分母を
  払う係数計算と、一般の有限台有理係数について共通分母から順序を定義して線形順序性を示す論法が
  独立しているため二つへ分けた。先頭の `claim_scaled_free_entropy_denominator_clearing` を四層で閉じた。
  SageMath は 384 件を `QQ` で厳密に検査。Lean 具体版
  `scaledFreeEntropy_clear_denominator`、体上の加群だけを残した必要十分版
  `two_scaled_denominators_cancel_necSuf`、導出版を追加した。式変形統一では姉妹側
  `evensectorT_006_claim_linearity_of_T` が既に規則どおりであることを確認した。

- 2026-08-15（tick 296）: `def_rational_log_order_group`（$\Lambda_{\mathbb{Q}}$、素数ごとの加法・有理数倍、
  $\iota_{\Lambda\to\Lambda_{\mathbb{Q}}}$、等号の決定可能性、密度の住処）と
  `claim_rational_log_order_group_embedding`（$\iota$ は加法を保ち単射）を記述した。台帳の備考にあった
  「有限表示と表示同値関係」ではなく、$\Lambda$ の定義と同じ形（値域を $\mathbb{Q}$ にした有限台写像）を採った
  （同値類が要らず、等号が素数ごとの有理数の比較で直ちに決まるため）。SageMath
  `rational-log-order-group-embedding` は 131 件を `ZZ`/`QQ` で厳密に。Lean 具体版
  `ThermodynamicLimit/RationalLogOrderGroup.lean`（`RationalLogOrderGroup`、`toRational`、`scaledFreeEntropy`、
  `toRational_add`、`toRational_injective`）、必要十分版 `pointwise_lift_add_and_injective_necSuf`
  （添字型上の有限台写像に値ごとの写像を持ち上げるとき、加法保存には $f$ の加法保存だけ、単射には $f$ の単射だけ）、
  導出版。sorry 検査 1068 件。本文末尾「この先に書くこと」に実数脱出後ろ倒しの残り項目を足した。
  式変形統一では姉妹側 `014_even_sector_T_action` の「$T_{V_1},T_{V_2}$ の作用」で $T_{V_2}$ の二本の鎖の
  前因子の処理を三行へ分けた。

（これより古い 265 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

## 式変形の書き方の統一（並列の作業ストリーム。毎 tick 1 件）

規則は両プロジェクトの README にある「式変形は一続きにする。根拠は行末に $(\because\ \dots)$ で書く」。
**毎 tick 1 件だけ**書き換え、検証を通し、ここへ記録する。中身は変えない（書き方だけ）。

### 本プロジェクト（`exact-solution-of-2d-ising-model-lambda`）

| 証明 | 状態 |
|---|---|
| 分配多項式の係数は多重度である | 済（2026-08-08） |
| 多重度の総和は配位の総数に等しい | 済（2026-08-08） |
| すべての配位を等しく数える点での自由エントロピー | 済（2026-08-08） |

（済んだ分の一覧は [auto-loop-archive.md](auto-loop-archive.md)。）

## レビュー記録

- 2026-08-15（tick 300）: 前 tick の「正の有理数の対数は全射である」の本文・SageMath・Lean 具体版・
  必要十分版・導出版を突き合わせた。素数自身の対数、整数冪（正・負）、有限台の帰納が同じ順で対応し、
  対象ラベル・入口 import・sorry 検査登録も揃っているため修正は無い。

- 2026-08-15（tick 299）: 前 tick の「正の有理数の対数は単射である」の本文・SageMath・Lean 具体版・
  必要十分版・導出版を突き合わせた。素数ごとの指数の移項、交差積の指数一致、有限積表示、
  有理数の約分が同じ順で対応し、対象ラベル・入口 import・sorry 検査登録も揃っているため修正は無い。

- 2026-08-15（tick 298）: 前 tick の「有限系の密度の分母は整数倍で払える」で、末尾の
  $M^2\cdot\iota(\lambda)=\iota(M^2\lambda)$ を「加法保存と反復加法」という散文で済ませていて、
  SageMath にも Lean にも対応が無かった。各素数での値の等号として五段の式変形へ書き直し
  （有理数倍の定義→$\iota$ の定義→分母 1 の積→$\Lambda$ の整数倍の定義→$\iota$ の定義）、
  Lean `toRational_intSmul` と SageMath の交換の検査（768 件）を足した。

- 2026-08-15（tick 297）: 前 tick の有理係数の対数順序群について、本文の有限台写像・加法・有理数倍・
  埋め込み、SageMath の各行、Lean の具体版・必要十分版・導出版、入口 import と sorry 検査登録を
  突き合わせた。姉妹側の前因子の代入・移動・相殺も一行一操作になっており、修正は無い。

- 2026-08-15（tick 296）: 前 tick は台帳の割り直しと姉妹側「テイラー係数の抽出」の根拠補強だけで、本プロジェクトの
  数学内容の追加は無い。姉妹側の差分（係数変換の実在ラベル参照 4 箇所と行列加法の可換則 2 箇所）を読み、
  参照先ラベルが実在し中身が変わっていないことを確認した。修正は無い。

（これより古い 285 件は [auto-loop-archive.md](auto-loop-archive.md) へ移した。）

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

停止するには `launchctl bootout gui/$(id -u)/com.masaori.ising-lambda-auto-loop`。
再開するには `launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.masaori.ising-lambda-auto-loop.plist`。
