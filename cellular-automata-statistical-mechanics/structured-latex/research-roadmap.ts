/**
 * 研究全体の段取りの正本。
 *
 * **これは数学の本文ではない。** 定義・主張・証明は `content/` が正本であり、
 * 二章（数学的道具立て／2 値セルオートマトンのセマンティクスを持つもの）の分類・依存順・
 * 節設計はそちらの検査に従う。このファイルが持つのは、**どの舞台・どの規則クラスまでを
 * 研究の射程に置き、いまどこに居て、各段階を何をもって完了と見なすか**だけである。
 *
 * 段取りを本文の章として書かないのは、章立ての検査が「節は主定理を持つ主張の依存的まとまり」
 * であることを要求しており、段取りはその形を取らないからである。段取りを章へ入れると、
 * その要求を緩めるか、段取りを主張に見せかけるかのどちらかになる。どちらも検査を空にする。
 * そこで段取りは本文の前に置く独立の記述とし、出版物（PDF / HTML）へは
 * `tools/render-roadmap.ts` が描画し、内容の妥当性は `tools/verify-roadmap.ts` が検査する。
 *
 * 用語は `docs/2値セルオートマトンの定義と呼び名.md` の呼び名の規約に従う。
 * 修飾語を付けない「2 値セルオートマトン」は舞台にも状態集合にも構造を仮定しない。
 * **状態数の一般化（多値・可換環値など）は現行の正本の外なので、段取りにも入れない。**
 */

/** 段階の到達状況。数値や記号ではなく、日本語の三値で持つ。 */
export type StageStatus = "到達済み" | "進行中" | "未着手";

/**
 * 完了の根拠。`label` は `content/` に実在するブロックのラベル、`path` はプロジェクト
 * ルートからの相対パス。どちらも `tools/verify-roadmap.ts` が実在を検査する
 * （実在しない根拠を書いた段取りは、記録だけが残って検査を空にする）。
 */
export type Evidence =
  | { readonly kind: "label"; readonly label: string; readonly why: string }
  | { readonly kind: "path"; readonly path: string; readonly why: string };

export type RoadmapStage = {
  /** 内容の分かる名前。連番・記号は使わない。 */
  readonly id: string;
  readonly title: string;
  /** この段階が扱う舞台・規則クラスの範囲。 */
  readonly scope: string;
  /** 扱う量がどこに住むか、どこで実数体・複素数体へ脱出しうるか。 */
  readonly habitat: string;
  /** 先に済んでいる必要がある段階の id。有向非巡回でなければ検査が落ちる。 */
  readonly dependsOn: readonly string[];
  readonly status: StageStatus;
  /** いまの現在地。ちょうど一つの段階だけが true を取る。 */
  readonly current: boolean;
  /** 何が確認できたら完了と見なすか。機械検査または全数計算で判定できる形で書く。 */
  readonly completion: readonly string[];
  /** 現在の状況を支える一次情報。未着手の段階では空でよい。 */
  readonly evidence: readonly Evidence[];
};

export const roadmapTitle = "研究の段取り";

export const roadmapPreamble = [
  "この研究の射程は、2 値セルオートマトンという舞台の上で「連続物理が実数の対象へ帰している内容を、" +
    "どこまで可算構造が担えるか」を確定することである。射程は舞台の広さと規則クラスの二軸で決まる。" +
    "以下の段階はその二軸を分割したものであり、各段階の依存・現在地・完了条件をここに固定する。",
  "初等セルオートマトン（有限巡回舞台上の一様な半径 1 の 2 値セルオートマトン、規則は 256 通り）は、" +
    "この段取りの入口であって射程ではない。一般の舞台で述べた主張を、全数計算できる最小の場合へ" +
    "落として校正するために置く。逆に、初等セルオートマトンで閉じる話をもって一般の主張の代わりにしない。",
  "状態集合は 2 元集合に固定する。多値・環値への一般化は現行の定義の正本の外にあるため、" +
    "この段取りには入れない。",
] as const;

export const roadmapStages = [
  {
    id: "general_stage_and_nonuniform_rules",
    title: "一般の舞台と非一様な局所規則",
    scope:
      "構造を仮定しない舞台（セルの集合と近傍割り当て）の上で、頂点ごとに異なる有限真理値表を許した " +
      "2 値セルオートマトンを扱う。近傍割り当ての合成代数、本質的依存、大域写像の局所表現、" +
      "有限舞台での可逆性と共役分類がここに属する。グラフ上・ポート付きグラフ上の 2 値セルオートマトンは、" +
      "近傍割り当てをグラフの閉近傍から作った特別な場合として、この段階に含まれる。",
    habitat: "有限舞台に限る限りすべて有限集合の上の数え上げであり、実数体も複素数体も現れない。",
    dependsOn: [],
    status: "到達済み",
    current: false,
    completion: [
      "近傍割り当ての合成・順序・束演算と、その到達関係が有限決定可能な形で本文に揃っていること。",
      "本質的依存が有限検査に落ち、局所表現可能性の必要十分条件が本文にあること。",
      "有限舞台上の大域写像の列挙と可逆部分の分類が本文にあり、共役分類の完全不変量が与えられていること。",
      "以上の全ブロックが二章のいずれかへ分類され、章内が参照依存のトポロジカル順に並んでいること。",
    ],
    evidence: [
      {
        kind: "label",
        label: "claim_flip_test_equivalence",
        why: "本質的依存が一点反転検査と同値であり、有限真理値表から決定できる。",
      },
      {
        kind: "label",
        label: "claim_support_subset_implies_representable",
        why: "大域写像が局所規則で表せる必要十分条件が依存台の包含として与えられている。",
      },
      {
        kind: "label",
        label: "claim_stage_global_maps_count",
        why: "有限舞台上の大域写像全体の元数が局所規則の個数の積として数え上げられている。",
      },
      {
        kind: "label",
        label: "claim_self_neighborhood_reversible_maps_classified_by_flip_sets",
        why: "自己近傍舞台の可逆大域写像が反転集合で完全に分類されている。",
      },
      {
        kind: "label",
        label: "claim_recursive_preimage_tree_code_complete_invariant",
        why: "有限自己写像の共役が再帰的前像木符号で完全に分類されている。",
      },
      {
        kind: "label",
        label: "claim_reflexive_transitive_closure_finite_decidable",
        why: "近傍割り当ての到達関係が反射推移閉包として与えられ、有限決定可能である。",
      },
      {
        kind: "label",
        label: "claim_neighborhood_assignment_pointwise_union_intersection_lattice",
        why: "各点合併と各点交叉が束をなすことが本文にあり、合成の順序・束演算が揃っている。",
      },
      {
        kind: "label",
        label: "claim_composition_not_left_distributive_over_pointwise_intersection",
        why: "合成が交叉へ分配しない反例があり、束演算と合成の関係の限界が確定している。",
      },
      {
        kind: "path",
        path: "docs/2値セルオートマトンの定義と呼び名.md",
        why: "舞台・局所規則・一様性・グラフ上・ポート付きグラフ上の定義と呼び名の正本。",
      },
    ],
  },
  {
    id: "elementary_ca_finite_calibration",
    title: "初等セルオートマトンによる有限校正",
    scope:
      "有限巡回舞台上の一様な半径 1 の 2 値セルオートマトン 256 通りを全数列挙し、一般の舞台で述べた" +
      "不変量（本質的依存台、可逆性、大域写像の巡回型、共役の完全不変量）を小さな舞台の大きさで" +
      "全数計算して本文の主張と突き合わせる。ここで見つかる不一致は本文の誤りであり、校正の失敗として扱う。",
    habitat: "規則も配位空間も有限集合であり、数え上げは自然数の中で閉じる。",
    dependsOn: ["general_stage_and_nonuniform_rules"],
    status: "到達済み",
    current: false,
    completion: [
      "256 通りの規則と、明記した複数の舞台の大きさについて、本質的依存台・可逆性・可逆写像の巡回型・" +
        "非可逆写像を含む共役の完全不変量の全数計算が SageMath の検算として存在すること。" +
        "完全不変量は本文の再帰的前像木符号に対応させ、巡回型だけの計算で代用しないこと。",
      "各検算が本文のブロックのラベルへ紐づき、検算と本文の対応の検査を通ること。",
      "全数計算の範囲と、そこから一般の場合を結論できないことが検算の概要に明記されていること。",
      "可逆性の結果を規則と舞台の大きさの組に対して記録し、検査した大きさの全てで成り立つことと、" +
        "任意の大きさまたは無限舞台で成り立つことを区別すること。一様規則の巡回型の集合を、" +
        "同じ近傍を持つ非一様な局所規則族全体の巡回型の集合と同一視しないこと。",
    ],
    evidence: [
      {
        kind: "path",
        path: "sagemath/check/recursive-preimage-tree-code/overview.md",
        why: "既存の検算が大きさ 1..3 の全初等規則について非周期前像木を含む符号を計算し、大きさ 1・2 の全規則対で共役判定と独立な全単射走査を照合している。新設の可逆部分の校正と合わせて範囲を覆う。",
      },
      {
        kind: "path",
        path: "sagemath/check/elementary-ca-finite-calibration/overview.md",
        why: "本質的依存台と大きさ 3..8 の可逆性・巡回型を全数計算済み。規則 27 のサイズ依存、一様性と近傍制限の区別、検算範囲の限界が明記されている。",
      },
      {
        kind: "label",
        label: "claim_recursive_preimage_tree_code_complete_invariant",
        why: "非可逆写像も含む校正で突き合わせる相手は再帰的前像木符号であり、可逆部分の巡回型だけでは範囲を覆わない。",
      },
      {
        kind: "label",
        label: "claim_locality_restricts_cycle_type",
        why: "自己近傍の舞台での巡回型制限を示す既存主張。一様な巡回舞台の検算が直接この反例を検査するとはせず、一様性と近傍制限の違いを比較する相手とする。",
      },
      {
        kind: "label",
        label: "claim_support_finite_decidability",
        why: "本質的依存台が有限検査で決まるため、256 通りの規則について全数計算できる。",
      },
      {
        kind: "label",
        label: "claim_stage_realized_cycle_types_decidable",
        why: "舞台ごとに実現される巡回型が決定可能であり、有限巡回舞台の小さな大きさで全数計算できる。",
      },
    ],
  },
  {
    id: "finite_stage_lambda_thermodynamics",
    title: "有限舞台の対数順序群値の熱力学の構成",
    scope:
      "有限舞台の上だけで、大域写像の反復の周期点の数え上げから熱力学の量を構成する。" +
      "配位の個数を自然数として数え、その対数を対数順序群の元として取り、逆温度に当たる量を" +
      "両端が正の整数刻み一の差として同じ群の中で作り、非単位刻みの除算は全素数係数の整除条件に限る。無限の舞台も熱力学極限も使わない範囲に限る。",
    habitat:
      "数え上げは自然数、正の個数の対数と定義域内の隣接差は対数順序群の元であり、実数体も複素数体も現れない。" +
      "極限を取らない限りこの段階は可算側で閉じる。",
    dependsOn: ["general_stage_and_nonuniform_rules", "elementary_ca_finite_calibration"],
    status: "到達済み",
    current: false,
    completion: [
      "有限舞台の数え上げから、状態数・エントロピー・逆温度・自由エントロピーに当たる量が、" +
        "自然数と対数順序群の中だけで本文に定義されていること。",
      "構成の各段が実数体・複素数体を一度も経由していないことが、住処の宣言と実数複素数の裏取り検査で確認できること。",
      "構成した量が初等セルオートマトンの全数計算で素因数分解による厳密計算として検算され、浮動小数点を使っていないこと。",
    ],
    evidence: [
      {
        kind: "label",
        label: "def_binary_ca_fiber_logarithmic_entropy",
        why: "正の繊維状態数の対数、両端が正の隣接差、正の総数の自由エントロピーを本文に構成し、Lean具体版・必要十分版と導出を揃えた。",
      },
      {
        kind: "label",
        label: "claim_prime_vector_integer_division",
        why: "非単位刻みで群内除算ができる条件は全素数係数の整除であり、無条件の差分商は構成していない。二セルの反例も四層で保持する。",
      },
      {
        kind: "path",
        path: "sagemath/check/elementary-ca-logarithmic-calibration/overview.md",
        why: "三〜六セルの全256規則、明示した五つの整数値写像、反復1〜2×配位数で状態数・対数・隣接差・整数除算を厳密校正した。保存条件と正値域で選別し、一般の保存写像や無限舞台へ拡張していない。",
      },
      {
        kind: "label",
        label: "claim_fixed_point_count_decomposition",
        why: "有限舞台の反復の不動点の個数が最小周期ごとの数え上げへ分解され、熱力学の量の材料が自然数として既に本文にある。",
      },
      {
        kind: "label",
        label: "claim_fixed_point_count_finite_decidability",
        why: "その数え上げが有限決定可能であり、対数を取る前の量が決定可能な自然数として確定している。",
      },
      {
        kind: "path",
        path: "docs/survey/連続物理の可算な担い手.md",
        why: "この段階の成果を書き出す先である、連続物理の概念ごとの可算な担い手の台帳。",
      },
    ],
  },
  {
    id: "one_dimensional_arbitrary_radius",
    title: "一次元・任意半径の一様規則",
    scope:
      "有限巡回舞台と一次元の局所的極限の上で、半径を任意に取った一様な 2 値セルオートマトンを扱う。" +
      "規則の総数は半径について二重指数で増えるため、全数列挙から標本と構造的分類へ移る境目がここに来る。",
    habitat:
      "有限舞台では有限。局所的極限を取っても舞台は可算のままで、非可算になるのは全配位を一度に取ったときである。",
    dependsOn: ["elementary_ca_finite_calibration"],
    status: "進行中",
    current: true,
    completion: [
      "半径を与えるごとに規則空間の大きさと、全数列挙が可能な範囲が本文に明示されていること。",
      "半径 1 の場合が初等セルオートマトンの校正結果と一致することが検算で確認できること。",
      "全数列挙が不可能な半径について、どの不変量が構造的に決定できるかが主張として書かれていること。",
    ],
    evidence: [
      {
        kind: "label",
        label: "claim_cyclic_rule_global_equality",
        why: "周期舞台で実現可能な入力だけへの制限が大域写像を完全に識別する。現在は記述層であり四層完了ではない。",
      },
      {
        kind: "path",
        path: "docs/tasks/auto-loop-state.md",
        why: "有限舞台の量と初等規則の校正を終え、次の対象を任意半径の局所表と周期境界の重複へ定めた。実現可能入力と制限の等号判定、異なる大域写像と実現繊維の元数、半径一への比較を記述し、SageMathの有限範囲の各段検算とLean具体版を完了した。Lean必要十分版では入力実現と局所・全セルの等号判定から有限性・二値性を除き、一般の有限入出力集合で両立入力数・表数・異なる大域写像数・実現繊維数を分離した。二元状態の全対応式を必要十分版の特殊化として導出済みである。",
      },
      {
        kind: "path",
        path: "sagemath/check/cyclic-rule-restriction/overview.md",
        why: "周期境界で重なるオフセット、両立入力、表制限と大域写像の等号、個数公式、半径一比較を、明示した有限範囲で段ごとに厳密検算した。",
      },
      {
        kind: "path",
        path: "sagemath/check/elementary-ca-logarithmic-calibration/overview.md",
        why: "半径一・三〜六セルの校正を比較の基準として使う。オフセットが同じセルへ戻る小さい周期舞台はこの校正の範囲外であり、次の定義で分離する。",
      },
    ],
  },
  {
    id: "lattice_and_countable_group_stages",
    title: "格子と可算群の舞台",
    scope:
      "群上の 2 値セルオートマトンを扱う。有限商の舞台（有限巡回群、その直積）から局所的極限へ移り、" +
      "平行移動が与える構造（近傍の標準的な番号付け、平行移動不変性）が何を買っているかを分離する。",
    habitat: "有限商では有限。局所的極限の舞台は可算。全配位の逆極限を取った時点で非可算へ移る。",
    dependsOn: ["one_dimensional_arbitrary_radius", "general_stage_and_nonuniform_rules"],
    status: "未着手",
    current: false,
    completion: [
      "有限商の舞台の族と、その上での不変量の列が本文で定義されていること。",
      "局所的極限の定式化が本文の主張と接続され、可算のまま言えることと全配位を要することが分離されていること。",
      "群構造を落として一般の舞台へ戻したときに何が失われるかが、反例つきで本文にあること。",
    ],
    evidence: [
      {
        kind: "path",
        path: "docs/局所的極限の定式化.md",
        why: "有限の舞台の族から可算な舞台を作る極限の定式化。",
      },
      {
        kind: "path",
        path: "docs/舞台のカタログ_有限構造とその極限.md",
        why: "舞台を有限から集め、極限の向きで整理した一覧。",
      },
    ],
  },
  {
    id: "rule_class_separation",
    title: "規則クラスの分別",
    scope:
      "総和型、二元体上で線形なもの、可逆なもの、二次のもの、ブロック型、確率的なものといった" +
      "規則クラスごとに、決定可能な述語と出てくる代数構造を分ける。確率的な規則だけは局所規則が" +
      "状態上の分布を返すため、重みが有理数の範囲に住むことを明示して扱う。",
    habitat:
      "決定性の規則クラスは有限集合と自然数で閉じる。確率的な規則は重みが有理数に住み、" +
      "有理数のまま閉じる範囲と、極限で実数へ出る箇所を分けて記す。",
    dependsOn: ["general_stage_and_nonuniform_rules", "elementary_ca_finite_calibration"],
    status: "未着手",
    current: false,
    completion: [
      "各規則クラスの定義が呼び名の規約に沿って本文にあり、クラス所属が有限検査で判定できること。" +
        "その有限検査の入力と量化範囲を明示すること。" +
        "特に固定した有限舞台での可逆性、任意の大きさでの可逆性、無限舞台での可逆性を別の述語として扱い、" +
        "有限範囲の全数結果を後二者の決定手続きとしないこと。任意の大きさ・無限舞台について有限検査を" +
        "主張する場合は、その同値性の証明を必要とし、成立しない範囲も境界の確定へ残すこと。",
      "クラスごとに、そのクラスでだけ成り立つ主張と、一般の舞台では成り立たない反例が対で本文にあること。",
      "確率的な規則について、有理数で閉じる主張と実数へ脱出する主張が住処の宣言で区別されていること。",
    ],
    evidence: [],
  },
  {
    id: "statistical_mechanics_correspondence",
    title: "統計力学との照合",
    scope:
      "有限舞台の転送行列、その跡としての分配関数、その対数としての自由エネルギーを、" +
      "2 値セルオートマトンの数え上げとして構成する。有限舞台だけで閉じる構成は前段" +
      "「有限舞台の対数順序群値の熱力学の構成」が済ませており、この段階が加えるのは、" +
      "無限の舞台と熱力学極限を要する側（Gibbs 測度、相転移）との照合である。統計力学側の概念" +
      "（分配関数、自由エネルギー、Gibbs 測度、相転移）ごとに、可算側の担い手と、" +
      "担えない残りを台帳へ書き出す。",
    habitat:
      "転送行列は成分が 0 と 1 の有限行列、分配関数は自然数、自由エネルギーは対数順序群の元である。" +
      "熱力学極限だけが実数へ出る操作であり、その一点へ脱出を隔離する。",
    dependsOn: [
      "finite_stage_lambda_thermodynamics",
      "lattice_and_countable_group_stages",
      "rule_class_separation",
    ],
    status: "未着手",
    current: false,
    completion: [
      "有限舞台での転送行列・分配関数・自由エネルギーが本文で定義され、住処が可算側で宣言されていること。",
      "統計力学側の各概念について、可算な担い手と担えない残りが台帳の形で揃っていること。",
      "各構成が SageMath の厳密計算で検算され、浮動小数点を使っていないこと。",
    ],
    evidence: [
      {
        kind: "path",
        path: "docs/Gibbs測度と相転移の定義.md",
        why: "照合の相手側となる Gibbs 測度と相転移の定義。",
      },
      {
        kind: "path",
        path: "docs/survey/連続物理の可算な担い手.md",
        why: "連続物理の概念ごとに可算な担い手と残りを記録する台帳。",
      },
    ],
  },
  {
    id: "countable_real_boundary",
    title: "可算側と実数側の境界の確定",
    scope:
      "非可算が入る点を一つずつ同定する。無限舞台の全配位を一度に取ること、熱力学極限、" +
      "位相的エントロピーのように無限舞台を要する量がここに属する。" +
      "実数側にしか無い内容を正直に書き出すことがこの段階の成果である。",
    habitat:
      "この段階は非可算側を対象とするため、各主張がどこで実数体または複素数体へ脱出したかを必ず宣言する。",
    dependsOn: ["statistical_mechanics_correspondence"],
    status: "未着手",
    current: false,
    completion: [
      "有限舞台で定義できる量と、無限舞台を要する量の全件が仕分けられていること。",
      "実数へ脱出する各主張について、脱出の理由が住処の宣言として本文に書かれていること。",
      "実数側にしか無いと判断した内容について、可算側で述べ直せない理由が反例または不可能性の主張として残ること。",
    ],
    evidence: [],
  },
] as const satisfies readonly RoadmapStage[];
