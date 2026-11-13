# 自動ループ 状態台帳

[auto-loop-runbook.md](auto-loop-runbook.md) が毎 tick 読み書きする。**この台帳が進捗の正本**である。

- 1 tick = 既存出力のレビューと修正 → セクションを 1 つだけ前進 → 検証 → push → 停止

## 現在地

- **2026-11-13（並列の連続実行）、完全列挙の隣接交換は符号を反転すること（`claim_matching_word_sign_swap`）の Lean 具体版から必要十分版への委譲を外した。** 具体版 `matchingWordSign_swap`・`matchingWord_swap_eq_map`（`AlgebraicEigenvalue/PerfectMatchingSign.lean`）は互換を必要十分版の `transpositionPerm` で、符号の乗法性と互換の符号を必要十分版の `sign_comp`・`sign_transposition` で済ませていた。互換を具体版の `KacWard.finiteTranspositionPerm`（本文の $t_{a,b}$）へ替え、本文の六等号の三行目と四行目を具体版 `finiteOrderedSign_comp`・`KacWard.finiteTransposition_sign` で示す形へ直し、例外の台帳の二行を消した（51 件から 49 件）。並列の表の行の残りは 17 件で、次は `claim_invariant_subset_reversal_sign` である。
- **2026-11-13（並列の連続実行）、符号は合成について乗法的であること（`claim_permutation_sign_mul`）の、線型順序を持つ任意の有限集合の上の Lean 具体版 `finiteOrderedSign_comp` を置いた。** 本文は $\mathcal J$ 一般で述べるのに、具体版 `permSign_comp` は行配位に限っていた。新しい具体版（`AlgebraicEigenvalue/PermutationSignFiniteOrderedSet.lean`）は $\Psi$ が $P_L$ へ入ること、$\Psi'$ が逆写像であること、$|C|=\mathrm{inv}(\varphi)$、各対で $A,B,C$ に属する個数が偶数、三つの符号の積が $1$ の六行、乗法性の五行を本文と同じ順で示し、必要十分版の定理を呼ばない。並列の表の次は `claim_matching_word_sign_swap` の委譲外しである。
- **2026-11-13（主経路の連続実行）、持ち上げた単純閉歩道の出発位置と内側セル集合の境界頂点の全単射を Lean 具体版・必要十分版で示した。** 出発点の単射、境界頂点への所属、全境界頂点の被覆を合わせた。次は各出発位置での回転数と境界頂点の局所回転数の一致である。
- **2026-11-13（並列の連続実行）、有限線型順序集合の相異なる二点の互換の符号は $-1$ であること（`claim_transposition_sign_on_finite_ordered_set`）の Lean 具体版を初めて置いた。** この主張の `lean:` は必要十分版 `NecSuf.KacWard.sign_transposition` だけで、具体版が無かった。`claim_matching_word_sign_swap` の具体版 `matchingWordSign_swap` が委譲を外すにはこの具体版と、一般の有限線型順序集合の上の符号の乗法性の具体版（本文 `claim_permutation_sign_mul` は $\mathcal J$ 一般で述べるが、具体版 `permSign_comp` は行配位に限る）の二つが要るので、並列の表の行を割り直した。並列の表の次は「一般の有限線型順序集合の上の符号の乗法性の具体版」である。
- **2026-11-13（並列の連続実行）、完全マッチングの符号は対の列挙順序に依存しないこと（`claim_perfect_matching_sign_enumeration_independent`）の Lean 具体版から必要十分版への委譲を外した。** 具体版 `perfectMatchingSign_eq_one_or_neg_one` は必要十分版の `sign_eq_one_or_neg_one` を呼んでいたので、本文に足した四行 $\operatorname{sgn}(\mathcal D)=\varepsilon(W(\mathcal L_0))=\operatorname{sgn}(\pi)=(-1)^{\operatorname{inv}(\pi)}\in\{-1,1\}$ と同じ順の calc と整数 $(-1)^k$ の偶奇で示す形へ直し、例外の台帳の行を消した。並列の表の次は `claim_matching_word_sign_swap`（例外の台帳の `matchingWordSign_swap`・`matchingWord_swap_eq_map`）である。





行列式の乗法性とスカラー倍を支える道具の五節、完全マッチングと対合の対応・符号の独立性・Pfaffian の平方展開・不動点項の消去・不変部分集合上の反転・反転と反復の対応・軌道の台と長さの保存・台の不変性・始点変更による台の一致・奇数軌道の最小元による選択不変性・選んだ軌道の反転による対合・その非自明性・反転の符号保存・反対称成分の積の符号反転・奇数軌道を持つ置換の符号付き和の相殺・交互の二色付けからの完全マッチングの構成の十六節、端末行列の行列式一致への根拠の接続、および対角相似とスカラー倍による行列式の保存が完了（内訳は MEMORY と保管庫）。有限写像の反復の加法則、有限置換の反復の単射性と正の最小周期と最小周期未満の反復回数の一意性、軌道の巡回表示と長さの一致、偶数軌道の最小元を起点とする二色付け、ゲージ重みの非零性も四層で完了。

ブロックを保つ置換の符号の積と、境界鎖の頂点別釣り合いから二辺への向き付き係数の条件付き伝播は四層で完了した。

終点と方向による向き付き辺の全単射、単位格子歩の射影辺の端点等式、頂点単純な閉単位格子路の射影の非後退性は四層で完了した。トーラスの巻き付き二次符号も Lean 具体版で定義した。

**残っているもの**（連続実行「可算二次元イジング: 証明の積み上げ」＝主経路が、この順に進める。tick は先頭の 1 件だけを実行する。runbook「二本の積み上げ」）。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| Onsager 閉形式への接続 | 各出発位置の回転数と境界頂点の局所回転数を同定する | 記述・SageMath 済。Lean は局所対応が未着手 | 出発位置と境界頂点の全単射は Lean 二版で済んだ。非後退辺対の回転数を方向対の重みに移す補題は Lean 具体版で済んだ。次は歩道の左右による方向表を使い、各頂点の項を対応させる。 |
| Onsager 閉形式への接続 | 出発辺の回転数和と境界頂点の局所回転数和を同定する | 記述・SageMath 済。Lean は未着手 | 全単射と各点の回転数一致によって有限和を再添字付けする。 |
| Onsager 閉形式への接続 | 一側閉包の射影回転数が正負四であることを実際の閉歩道へ代入する | 記述・SageMath 済。Lean の接続は未着手 | 射影持ち上げ点の相異性、巻き付き零、内側セル集合の計数を正負四の定理へ接続する。具体版 `oneSidedClosureProjection_cyclicTurning` は結論を仮定 `hwhitney` で受け取り、必要十分版を呼んでいる。完了には実際の閉歩道の前提だけから平面単純多角形の具体版を適用する。 |
| Onsager 閉形式への接続 | 周期単純路の循環総回転数は零 | 記述・SageMath 済。Lean 二版は未着手 | 三周期比較から得た周期方向の和の零を、有限辺列の循環総回転数の定義に一致させる。 |
| Onsager 閉形式への接続 | 頂点単純閉路の循環総回転数は切断線偶奇で決まる | 記述・SageMath 済。Lean 二版は未着手 | 零巻き付きと非零巻き付きの結果を切断線偶奇へ接続する。切断線偶奇が零の場合は、上の行「切断線偶奇が零の頂点単純閉路の巻き付きは零である」を引く（原始性を経由しない）。 |
| Onsager 閉形式への接続 | 頂点単純閉路の位相因子はトーラスの巻き付き二次符号に等しい | 記述・SageMath 済。Lean 二版は未着手 | `claim_vertex_simple_orbit_quadratic_sign`。離散 Whitney 系の章へ移され、主張は閉じた非後退辺列と接触対数零の言葉で書かれている（2026-10-31 の研究管理が確認）。平方恒等式の章の接触点分割の帰納法が直接引くので、閉包の中の Whitney 系の行を引いて Lean 二版を書く。 |
| Onsager 閉形式への接続 | 平方恒等式の節 6〜9 の Lean 二版 | 未着手 | 2026-11-11: 正負四の欠け（一側閉包の具体版の仮定 `hwhitney`）に依存しない前半は「並列の積み上げが受け持つもの」の表へ移した。この行に残るのは、`claim_edge_distinct_walk_quadratic_sign`（辺の重複がない閉歩道の位相は二次符号と横断数で決まる）から先の、正負四に依存する主張である。並列の表の前半が未完のうちは、この行を飛ばして次の実行可能な行へ進む。 巻き付き二次符号の加法則・偶辺鎖の標準形・交差形式・辺を共有しない二本の閉歩道の混合横断・平滑化一回と横断消去の帰納法・接触点分割の局所位相と帰納法、および先に記述・SageMath まで進めた四行（閉歩道の位相と二次符号の一般形、マッチングの符号と基準マッチングの比較、局所対合の符号付き和、平方恒等式の合成）の Lean 具体版・必要十分版を書く。具体版は実際の閉歩道・標識付きマッチングについて述べ、直前までの離散 Whitney 系の Lean 配線を引く。一つの論法ごとに行を割ってから着手する（2026-10-28 の研究管理）。 帰納法の Lean は、章「閉歩道の位相と Pfaffian による有限トーラス公式」のブロックを対象にし、離散 Whitney 系の章にある同内容の未参照の主張は形式化しない（2026-10-31 の研究管理。切り分けの行で扱う）。 |
| Onsager 閉形式への接続 | 四つの定数項一の多項式平方根による有限トーラス公式の Lean 二版 | 記述・SageMath 済。Lean 二版は未着手 | 実際の四つの行列式について、存在・一意性と正符号の和を本文と同じ順で形式化する。 |
| Onsager 閉形式への接続 | 熱力学極限の段の Lean 二版（平方恒等式に依存するもの） | 未着手 | 上の明示積から Onsager 閉形式との同定までの十行の主張の Lean 具体版・必要十分版。具体版は本文の対象（実際の $Q^{a,b}_L$、実閉部分体 $R$、実現写像）について述べ、必要十分版の定理を呼ばない。一つの論法ごとに行を割ってから着手する（2026-10-29 の研究管理）。 対象の主張（記述・SageMath 済み。2026-10-30 の研究管理が個別の行を畳んでここへ集めた）: 「有理点での四つの符号付き偶部分グラフ多項式の符号」、「自己双対点より低温側での分配多項式の両側評価」、「自己双対点より高温側での分配多項式の両側評価」、「分配多項式の両側評価を対数順序群の鎖へ移す」、「実閉部分体の各元の有理上下界」、「実閉部分体の Archimedes 性と任意精度の有理挟み込み」、「実閉部分体の元の有理下切断の実数上限」、「下切断の上限による実現写像は有理数上で包含写像に一致する」、「下切断の上限による実現写像は加法を保つ」、「下切断の上限による実現写像は乗法を保つ」、「下切断の上限による実現写像は狭義順序を保ち単射である」、「複素実現の定義と加法保存」、「複素実現の乗法・単位元保存」、「複素実現の単射性」、「複素実現した横・縦モードの複素根集合への包含」、「各モード集合と複素根集合の全単射」、「横・縦モードの直積全単射と有限和の再添字付け」、「分散因子の有限積の実対数をモード和へ移す」、「複素根の角表示と分散因子の実現値の対応（指数評価への脱出）」、「正の分散因子から角の対数関数の連続性を得る（実対数への脱出）」、「半格子ずれた四つの Riemann 和の極限は同じ積分（連続極限への脱出）」、「下組の実現像の上限は実現した列の実数極限に等しい（実数体への脱出: 連続極限）」、「周期境界の密度と分散因子の積分の同定」、「分散因子の積分を Onsager の双曲線関数の形へ書き直す」、「分散因子の最小値を自己双対点と同定する」。閉包の中で `lean:` が無いのは、有限 Fourier 分解の章の 11 件（逆元不変性・軌道の大きさ・軌道ごとの明示積・1 の冪根の共役・有理点での正値性・自己双対性と符号・有理点での四つの符号・両側評価三件）、零点の詰め寄りの章の 3 件（有理上下界・Archimedes 性・有理挟み込み）、実数体への脱出の章の 22 件である。 2026-11-04 の研究管理: 平方恒等式に依存しない 22 件は並列の表の行「平方恒等式に依存しない実数体への脱出と有限 Fourier 分解の Lean 二版」へ移した。この行に残るのは、軌道ごとの明示積・自己双対性の二件・有理点での四つの符号・両側評価三件・分散因子の有限積の実対数・四つの Riemann 和・周期境界の密度と積分の同定・Onsager の双曲線関数の形の 12 件である。 |
| Lean の四層 | 具体版の必要十分版への委譲を外す | 未着手 | 2026-11-11: 到達点への最長の鎖に載らないので、熱力学極限の行の後ろへ移した。上の行が並列の表の完了待ちで進めないときは、この行を進める。 2026-11-12: 正負四・回転位相に関わらない 19 件（行列式・マッチング 7 件、接触点分割・平滑化・横断数 12 件）は並列の表の行「正負四・回転位相に関わらない具体版の委譲を外す」へ移した。この行に残るのは、一側閉包・周期持ち上げ・階段・回転位相の具体版である。 例外の台帳 `lean/concrete-necsuf-delegations.txt` の 2026-11-07 の見出しの下の残り 54 件（当初 59 件）。開いた名前空間から修飾なしで必要十分版の定理を呼んでいたもので、検査を直して見つけた（2026-11-07 の研究管理）。上の一側閉包の行が扱う対象（内側セル集合・補集合の辺連結性、穴の無いセル集合の Euler 数、対角の二セルの除外）はその行の中で外す。残りを、到達点に近い依存の順に一件ずつ外し、外したら例外の台帳の行を消す。外し方は runbook「具体版の委譲の見逃しを台帳へ載せる」。 |
| 臨界指数を零点列で書く | 臨界指数の具体版の委譲を外す | 未着手 | `lean/concrete-necsuf-delegations.txt` の `criticalPoint_exists_positiveRational_squareDiff_lt` と `leadingDistance_pinching_implies_predicate`。登録先の本文ブロック（臨界点の有理近似、先頭距離の詰め寄りから述語へ）は四つの到達点からの閉包の外なので、閉包の中の Lean の行より後に置く（2026-11-02 の研究管理）。この行は例外台帳が空になるまで消さない。 |
| 有限系の側の章 | 行き止まりの主張の切り分け | 未着手 | 2026-10-31 の研究管理の実測では、どのブロックからも引かれず主定理の印も無い主張は全体で 48 件（近似の走査）。Kac--Ward 系の章のものは上の切り分けの行で扱う。この行の対象は残りの約 22 件で、道具の章 3、自由エントロピー 1、転送行列 5（`theorem_partition_polynomial_is_trace` を含む。主定理の印の検出漏れの可能性があるので読んで確かめる）、シフト対称性 1、固有値の代数性 5、Fisher 零点と双対性 4、熱力学極限 1、Fisher 零点の個数と密度 1、臨界指数 1。引用漏れか不要かを 1 件ずつ読んで判断する。判定は `ref()` と `\blkref{}` の両方を数えること（数え違いの実績あり）。 |
| 全章 | 道具の節を割って道具の章へ移す | 未着手 | 章の外に残る二次体と正錐・実閉部分体・有理係数の対数順序群などについて、格子・配位を参照しないブロックを依存から特定する。節の中に本論が混ざる場合はブロック単位で分割する。 「巡回移動は隣接二項の整数和を保つ」は 2026-10-21 に道具の章の節「整数の有限列と等差項についての補題」へ移した。 多項式環・定数多項式の写像・多項式行列・行列式・互換の符号の五ブロックも移動済みなので、この行の対象から除く。残る候補は実際の依存を調べてから分割する。 |
| 臨界指数を零点列で書く | 先頭距離の列の可算な命題 | 保留 | $L=2,\dots,8$ の七点では定義多項式の次数も実対数へ脱出した読みも一般則・収束先を一意に定めない。命題候補が立つまで本文へ項目を追加しない。 |

**並列の積み上げが受け持つもの**（連続実行「可算二次元イジング: 証明の積み上げ（並列）」が上から順に進める。runbook「二本の積み上げ」）。
到達点に要る Lean の無い主張のうち、一側閉包の正負四の欠け（`hwhitney`）に依存しない 36 件を受け持つ（2026-11-11 に `count-goal-lean-remaining.ts` と同じ依存の辿り方で数えた）。
2026-11-12 の研究管理: 式変形の書き方の統一（runbook の手順 8）も並列が受け持つ。主経路は到達点への最長の鎖の上にあるので、鎖に載らない作業を外した。

| 章 | セクション | 状態 | 備考 |
|---|---|---|---|
| Lean の四層 | 正負四・回転位相に関わらない具体版の委譲を外す | 未着手 | 2026-11-12 の研究管理が主経路の行「具体版の必要十分版への委譲を外す」から移した。上の行を終えたら進める（上の行が主経路の完了待ちで進めないときも、この行へ進む）。対象は到達点の閉包の中で例外の台帳 `lean/concrete-necsuf-delegations.txt` に載る具体版のうち、一側閉包の正負四（`claim_one_sided_closure_projection_cyclic_turning`）にも回転位相・循環総回転数の主張にも依存せず、主経路が書き換える Lean ファイルに触れない 19 件である。行列式・マッチングの 7 件: `claim_perfect_matching_sign_enumeration_independent`・`claim_matching_word_sign_swap`・`claim_invariant_subset_reversal_sign`・`claim_polynomial_determinant_mul`・`claim_polynomial_determinant_noninjective_cancellation`・`claim_polynomial_product_of_sums`・`def_integer_matrix_determinant`。接触点分割・平滑化・横断数の 12 件: `claim_vertex_port_bijection`・`claim_edge_simple_contact_split`・`claim_smoothing_splits_closed_walk`・`claim_contact_split_turning_update`・`claim_reconnection_turning_difference`・`claim_contact_split_seam_parity`・`claim_contact_split_pair_descent`・`claim_smoothing_crossing_number_update`・`claim_smoothing_straight_visit_count_update`・`claim_vertex_crossing_number_factorization`・`claim_smoothing_vertex_crossing_number_update`・`claim_crossing_number_vertex_decomposition`。外し方は runbook「具体版の委譲の見逃しを台帳へ載せる」。一件ずつ外し、外したら例外の台帳の行を消す。 2026-11-12（並列）: 上の行「平方恒等式に依存しない実数体への脱出と有限 Fourier 分解の Lean 二版」は 22 件とも済んだので表から外し、この行が先頭になった。 2026-11-13（並列）: `claim_perfect_matching_sign_enumeration_independent` を済ませた（残り 18 件）。 2026-11-13（並列）: 次の `claim_matching_word_sign_swap` は、互換の符号の具体版（済）と上の行の乗法性の具体版を引いて、`matchingWordSign_swap`・`matchingWord_swap_eq_map` を本文の六等号と同じ順で書き直す（互換は具体版の `finiteTranspositionPerm` へ替える）。上の行が済むまで、この行の残りの 17 件から実行可能なものへ進んでよい。 2026-11-13（並列）: 乗法性の具体版 `finiteOrderedSign_comp`（`AlgebraicEigenvalue/PermutationSignFiniteOrderedSet.lean`）を済ませたので、`claim_matching_word_sign_swap` に進める。 2026-11-13（並列）: `claim_matching_word_sign_swap` を済ませた（残り 17 件）。 |

**セクションを割り直したら、この表を書き換える。** 番号は振らない（内容の分かる名前で書く）。
割り直した理由は「前進の記録」へ 1 行で残す。

固定原始特徴の多項式探索とそれに続く有限データへの当てはめは 2026-09-20 に終了し、2026-10-03 の研究管理が平方恒等式の経路を Pfaffian 経路へ切り替えた（「現在地」の先頭と runbook「Kac--Ward 平方恒等式の経路」）。有限データへの当てはめは再開しない。

## レビュー記録

- 2026-11-13: 「符号は合成について乗法的である」の本文は線型順序を持つ任意の有限集合 $\mathcal J$ の上で述べるのに、SageMath の検算（`check.sage`）は $\mathcal J$ を行配位に取った場合だけで、Lean 具体版も行配位に限っていた。本文は不変。$\mathcal J=\{0,\dots,n-1\}$ に全ての線型順序（$n\le4$）と三つの順序（$n=5$）を載せ、証明の各段（$\Psi$ の全単射性、$|A|,|B|,|C|$、各対の偶数性、三つの符号の積、乗法性）を確かめる `check_general_finite_ordered_set.sage` を足した（57,249 組、三分律を崩した関係で乗法性が崩れる否定の対照を含む）。
- 2026-11-13: 「完全マッチングの符号は対の列挙順序に依存しない」の主張文は $\operatorname{sgn}(\mathcal D)\in\{-1,1\}$ を述べるのに、証明は列挙の取り替えと空集合の場合だけを示し、値が $\{-1,1\}$ に属することを示していなかった（定義ブロックが $\in\{-1,1\}$ と書くだけ）。$\pi:=\pi_{W(\mathcal L_0)}$ を置き、`def_perfect_matching_sign`・`def_matching_word_sign`・`def_permutation_sign` を引く三等号と、整数 $(-1)^k$ の偶奇による所属の一行を証明に足した（主張は不変）。SageMath に四行の検算 `check_sign_values.sage` を足した（520 等式、否定の対照を含む）。
- 2026-11-12: 「分散因子の最小値は自己双対点で零になる」の本文の証明が、$0<r<1$ を実現写像の四つの主張の列挙で、$2r(1-r^2)>0$ を根拠なしに、$B_\xi-(1-2r-r^2)^2$ を「$\mathbb R$ の分配則」の一行で、$(1-2r-r^2)^2=0\iff1-2\xi-\xi^2=0$ を「単射性と四則保存」の一行で、$-1-s<_R0$ を「$0<_Rx_c$ と $-2<_R0$」（推移律と加法の両立を引かずに）で、$1+x_c\ne0$ を「$s=1+x_c>_R0$」で済ませ、主張文に無い $s$ を置かずに使っていた。$s$ を `def_critical_point` から置き、五つの事実（$\rho(0)=0<\rho(\xi)$ と $\rho(\xi)<\rho(1)=1$、$c=2r((1-r)(1+r))>0$、$\rho(p)$ の七行、$s\ne0$ と $-1-s<_R-2<_R0$ を差の平方で示して推移律、$\xi\ne-1-s$ を $0<_R0$ からの $v\cdot v=0$ で）、差の六行、$B_\xi(0,0)$ の四行、零条件の七行の同値、$1+x_c=s\ne0$ の三行へ直した（主張は不変）。SageMath を各行の検算へ書き直した（4,364 件、否定の対照を含む）。
- 2026-11-12: 「複素根の角表示は分散因子の実現値を余弦で表す」の本文の証明が、この主張に要らない「角の組は全モードの組を重複なく走る」を置き、$\rho_{R\to\mathbb R}(\varpi+\varpi^{-1})=\rho_{\overline{\mathbb Q}\to\mathbb C}(\varpi+\varpi^{-1})$ を $\varpi+\varpi^{-1}\in R$ と実数・複素数の写像を示さずに書き、主張文が別の主張の証明の中で置いた記号 $e_{L,a,k}$ を使い、負号の保存を本文に節の無い事実として引いていた。共役の主張から $\varpi+\varpi^{-1}=2\alpha+0\cdot\omega$ の三行、$\varpi\ne0$ の三行、$\rho_{\overline{\mathbb Q}\to\mathbb C}(\varpi^{-1})$ の八行、実部 $\operatorname{Re}$ を置いて $\rho_{R\to\mathbb R}(2\alpha)=2\cos\theta_1$ を出す九行、$\rho(m-w)=\rho(m-w)+\rho(w)-\rho(w)=\dots$ の十行へ直し、主張文の右辺を $r:=\iota_{\mathbb Q\to\mathbb R}(q)$ で書いた（主張は不変。下流の `claim_dispersion_angle_log_continuous` の $B_q$ と同じ形）。SageMath を各行の検算へ書き直した（42,435 件、否定の対照を含む）。
- 2026-11-12: 「下組の実現像の上限は列の実数極限に等しい」の本文の証明が、結論に使わない「$\rho$ は狭義順序を保つ」の七行の鎖を先に置き、$0<_{\Lambda_{\mathbb Q}}\varepsilon$ を $s=m/n$ と共通分母の証人で日本語で示し、$c=\log_{\mathbb R}2>0$ を根拠なしに置き、Archimedes 性の段を「有理数の稠密性を二度用い…を選べばよい」と日本語で済ませ、上限の存在を「実数の完備性」に頼っていた。三つの事実（実現値の狭義比較を全順序性と単調性で順序へ戻す、$\rho(0)=0$ の四行、$c>0$ の八行）を先に置き、上からの四行、下からの三つの鎖（$b<\rho(\mu)$ の四行、$\rho(\mu+\varepsilon)<I$ の六行、$\rho(\varepsilon)>0=\rho(0)$ の四行）、$I$ が最小上界であることで上限を示す形へ直した。主張文と脱出理由から完備性を外した（主張は不変）。SageMath を各行の検算へ書き直した（5,402 件、区間演算、否定の対照を含む）。

## 式変形の書き方の統一

- 2026-11-13（並列の連続実行の書式統一）: 「正の有理点での分配多項式の値の上からの評価」（`claim_partition_value_upper_bound_at_positive_rational`）の $Z_L(q)$ の式鎖で、五行の行末根拠の中の句点を読点へ直した（この主張の行末根拠の句点は全て片付いた）。
- 2026-11-13（並列の連続実行の書式統一）: 「有理係数の対数順序群の順序は線型順序である」（`claim_rational_log_order_group_linear_order`）の反対称律の $\lambda=\mu$ の式鎖で、二行の行末根拠の中の句点を読点へ直した（この主張の行末根拠の句点は全て片付いた）。
- 2026-11-13（並列の連続実行の書式統一）: 「一次因子の有限積の係数の上界」（`claim_qbar_poly_linear_factor_product_coeff_bound`）の帰納段の $\mathrm{ac}_k(F_{m+1})$ の式鎖で、行末根拠の中の句点を読点へ直した（この主張の行末根拠の句点は全て片付いた）。
- 2026-11-13（並列の連続実行の書式統一）: 「共通分母の正整数倍は共通分母である」（`claim_common_denominator_multiple`）の $(kN)\cdot\lambda$ の式鎖で、行末根拠の中の句点を読点へ直した（この主張の行末根拠の句点は全て片付いた）。
- 2026-11-12（並列の連続実行の書式統一）: 「共通分母を通した順序の判定は共通分母の取り方によらない」（`claim_common_denominator_order_independent`）の $\iota(N'\lambda_N)$ の式鎖で、二行の行末根拠の中の句点を読点へ直した（この主張の行末根拠の句点は全て片付いた）。

## 前進の記録

- 2026-11-13: 並列の表の先頭の行の二件目 `claim_matching_word_sign_swap` を済ませた。具体版 `matchingWordSign_swap` は本文の六等号と同じ順の calc のまま、三行目（乗法性）を `finiteOrderedSign_comp`、四行目（互換の符号）を `KacWard.finiteTransposition_sign` で示す。`matchingWord_swap_eq_map` は互換を `KacWard.finiteTranspositionPerm` にし、$U,V$ の元の固定と $a,b$ の交換を具体版の `finiteTransposition_apply_*` で示す。同じファイルの `matchingWordSign_map` も `finiteOrderedSign_comp` へ替え、`PerfectMatchingSign.lean` から必要十分版の定理の参照と `NecSuf.KacWard.PermutationSignOrbitProduct` の import を外した（推移的にそれを受けていた必要十分版の二ファイル `NecSuf/AlgebraicEigenvalue/MatchingPairWordSignMap.lean`・`NecSuf/KacWard/ReferenceMatchingConstantTerm.lean` には直接の import を足した。符号・転倒数・順序対の集合は本文の定義を書いた `sign`・`inversionCount`・`orderedPairs` をそのまま使う）。本文・SageMath は不変。この行の残りは 17 件。
- 2026-11-13: 並列の表の先頭の行「一般の有限線型順序集合の上の符号の乗法性の具体版」を済ませた。具体版 `finiteOrderedSign_comp` は本文の定義を書いた `sign`・`inversionCount`・`orderedPairs`（`(· < ·)` について）だけを使い、順序については三分律の帰結（`ne_of_lt`・`lt_asymm`・`lt_or_gt_of_ne`）だけを使う（推移律は使わない、本文の末尾の段落）。導出版は `PermutationSignFiniteOrderedSetFromNecSuf.lean`。行配位の `permSign_comp` は行配位の順序 `rowConfigLess` について述べる具体版として残した（行配位の辞書式順序は Lean の `LinearOrder` のインスタンスでなく、行列式の章の具体版がそれを引いているため）。本文の `lean:` に足した。
- 2026-11-13: 主経路の先頭の局所同定を、非後退辺対の回転数を方向対の重みに移す論法と、歩道の左右による境界頂点の局所対応に割った。前者を Lean 具体版 `stepTurning_eq_directionPairTurning` で示した。後者は次の tick に残す。
- 2026-11-13: 主経路の先頭を全単射・各点の回転数一致・有限和の再添字付けへ割り直した。全単射は既存の出発点の単射、境界への所属、全境界頂点の被覆から Lean 具体版 `vertexSimpleWalk_departure_equiv_boundaryVertices` と必要十分版 `boundary_vertices_equiv_positions` で示した。各点の一致と有限和は次の行に残す。
- 2026-11-13: 並列の表の先頭の行「正負四・回転位相に関わらない具体版の委譲を外す」の二件目 `claim_matching_word_sign_swap` に入ったところ、具体版 `matchingWordSign_swap` が呼ぶ必要十分版の定理（互換の符号 `sign_transposition`、符号の乗法性 `sign_comp`、互換の作用 `transpositionPerm_apply_*`）のうち、互換の符号と乗法性には一般の有限線型順序集合で述べた具体版が無かった。中身で割り、(1) 互換の符号の具体版、(2) 符号の乗法性の具体版、(3) 語の交換の委譲を外す、の三つにした。(1) を済ませた: 具体版（`KacWard/TranspositionSignFiniteOrderedSet.lean`）は本文の $t_{a,b}$ の場合分けの定義、二回合成で戻ること、名前の交換で同じ写像になること、$I=A\cup B\cup C$ の両包含（`⊆` は本文の五つの場合分け）、$\mathrm{inv}(t_{a,b})=|M|+|M|+1=2|M|+1$、符号の四行を本文と同じ順で示し、必要十分版の定理を呼ばない（本文の定義を書いた `sign`・`inversionCount`・`orderedPairs` だけを使う）。導出版は `TranspositionSignFiniteOrderedSetFromNecSuf.lean`。本文・SageMath は不変。(2)(3) は並列の表の行に置いた。
