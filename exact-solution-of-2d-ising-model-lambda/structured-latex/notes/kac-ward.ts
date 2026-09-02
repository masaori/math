/**
 * 章「トーラス上の Kac--Ward 行列式」に紐づく検算・観察ノート。
 * 検算は証明ではなく、一般化できない有限標本を本文へ混ぜない。
 */

import { defineNotes, displayMath, math, paragraph } from "../schema.ts";

export default defineNotes([
  {
    id: "note_kac_ward_definition_determinants_even_subgraph_square_observation",
    targets: ["def_kac_ward_determinants"],
    title: { text: "行列式は符号付き偶部分グラフ多項式の平方（観察と経路の確定）" },
    body: [
      paragraph([
        "検証水準の計算として、一辺 ", math(String.raw`L=2,3`),
        " の周期正方格子で四つの Kac--Ward 行列式 ",
        math(String.raw`\det\bigl(I-x\,M^{a,b}\bigr)`),
        " を円分体 ", math(String.raw`\mathbb Q(\zeta_8)`),
        " 係数の多項式として厳密に計算し、全頂点の次数が偶数である台の辺の部分集合",
        "（偶部分グラフ）", math(String.raw`A`), " の切断線偶奇 ",
        math(String.raw`(h(A),v(A))`), " に符号 ",
        math(String.raw`(-1)^{c\,h+d\,v+e\,hv}`), "（", math(String.raw`c,d,e\in\{0,1\}`),
        " の全 8 候補）を付けた多項式の平方と比較した",
        "（sagemath/check/torus-kac-ward-even-subgraph-square）。",
      ]),
      paragraph([
        "結果、四つのスピン構造すべてで等式",
      ]),
      displayMath(String.raw`\det\bigl(I-x\,M^{a,b}\bigr)
=\Bigl(\sum_{A}(-1)^{(1+a)h(A)+(1+b)v(A)+h(A)v(A)}\,x^{|A|}\Bigr)^{2}`),
      paragraph([
        "が成り立った。スピン構造 ", math(String.raw`(0,1)`), " と ",
        math(String.raw`(1,0)`), " では二つの符号候補の平方が一致するが、これは正方トーラスの",
        "軸対称によりホモロジー類 ", math(String.raw`(1,0)`), " と ",
        math(String.raw`(0,1)`),
        " の類別和が多項式として一致するためで、等式の一意性とは矛盾しない。",
      ]),
      paragraph([
        "この観察により、一般の ", math(String.raw`L`), " で証明すべき候補は",
        "「行列式＝符号付き偶部分グラフ多項式の平方」という行列式レベルの恒等式である。",
        "ただし多項式全体の一致だけから、置換展開の個々の両向き項が相殺するか、平方の交差項へ",
        "どのように対応するかは決まらない。この項ごとの対応は一般の恒等式の証明で別に示す必要がある。",
        "反復分解（接触対数の整礎帰納）は、この恒等式の証明の中で各閉路の回転位相符号を",
        "確定するために使う。これは有限標本（", math(String.raw`L=2,3`),
        "）の観察であり、一般の ", math(String.raw`L`), " についてはまだ何も証明していない。",
      ]),
    ],
  },
  {
    id: "note_kac_ward_definition_cyclic_total_turning_vertex_simple_observation",
    targets: ["def_cyclic_total_turning"],
    title: { text: "頂点単純閉路の循環総回転数（証明前の有限標本観察）" },
    body: [
      paragraph([
        "検証水準の計算として、一辺 ", math(String.raw`L=2,3,4`),
        " の周期正方格子で、通過の頂点が相異なる（接触対数零の）閉じた非後退辺列を",
        "全列挙し（基点と向きを区別した数え上げで全 ", math(String.raw`373{,}716`),
        " 本）、循環総回転数 ", math(String.raw`t_{\circ}(\gamma)`),
        " と切断線偶奇 ", math(String.raw`(h(\gamma)\bmod2,\ v(\gamma)\bmod2)`),
        " を突き合わせた（sagemath/check/vertex-simple-cycle-turning）。",
      ]),
      paragraph([
        "結果、次の離散 Whitney の言明が例外なく成り立った。切断線偶奇が ",
        math(String.raw`(0,0)`), " の頂点単純閉路（", math(String.raw`73{,}616`),
        " 本）は ", math(String.raw`t_{\circ}(\gamma)\in\{+4,-4\}`),
        "。切断線偶奇が ", math(String.raw`(0,0)`), " 以外の頂点単純閉路（",
        math(String.raw`300{,}100`), " 本）は ", math(String.raw`t_{\circ}(\gamma)=0`),
        "。この観察は本文の「頂点単純閉路の循環総回転数は切断線偶奇で決まる」で",
        "一般の一辺長について証明済みである。",
      ]),
      paragraph([
        "整数巻き付きベクトルが零の場合は、本文の平面持ち上げと有限セルの二重計数により一般の ",
        math(String.raw`L`), " で ", math(String.raw`t_{\circ}(\gamma)\in\{+4,-4\}`),
        " が証明された。したがって、この場合の回転位相は ",
        math(String.raw`\zeta_8^{\,t_{\circ}(\gamma)}=-1`),
        " である。零でない原始的巻き付きの場合の ",
        math(String.raw`t_{\circ}(\gamma)=0`), " と回転位相 ",
        math(String.raw`+1`),
        " も周期単純路の一側閉包と三周期比較により証明済みである。有限標本（",
        math(String.raw`L=2,3,4`), "）の観察は証明された二場合の両方を検査している。",
      ]),
    ],
  },
  {
    id: "note_kac_ward_claim_parallel_separated_staircases_direct_closure_counterexample",
    targets: ["claim_parallel_separated_staircases_disjoint"],
    title: { text: "二本の反復横断階段を対応点へ結ぶ直接閉包は単純にならない" },
    body: [
      paragraph([
        "周期持ち上げの一周期分と、その横断平行移動を、両端から出した同じ反復横断階段で結ぶ候補は、",
        "既存の分離補題だけでは単純閉路にならない。反例は一辺 ", math(String.raw`L=2`),
        " のトーラス上の頂点列 ",
        math(String.raw`((0,0),(0,1),(1,1),(1,0),(0,0))`),
        " である。この閉路の平面持ち上げの一周期分は",
      ]),
      displayMath(String.raw`(0,0),(0,1),(1,1),(1,0),(2,0)`),
      paragraph([
        "となり、巻き付き数は ", math(String.raw`(w_{\mathrm h},w_{\mathrm v})=(0,1)`),
        "、正の横断階段は左向きである。横断幅を超える二回の平行移動で直接閉包すると、",
        "合成列には、左側の接続階段と平行移動後の持ち上げの交点 ", math(String.raw`(0,-1)`),
        " が二度現れる。したがって「二つの周期持ち上げが互いに交わらないこと」と",
        "「二本の階段が互いに交わらないこと」だけでは、階段と反対側の持ち上げとの交差を排除できない。",
      ]),
      paragraph([
        "この候補は採用しない。閉包を完成させるには、反対側の持ち上げも終点以外で避ける接続路を別に構成し、",
        "その後に四つの部分の交差を組ごとに検査する必要がある。反例は整数格子の有限列だけで完結し、",
        "実数体も複素数体も用いない。",
      ]),
    ],
  },
  {
    id: "note_kac_ward_claim_periodic_lift_closure_turning_difference_cancellation",
    targets: ["def_periodic_lift_closure_cycle", "def_cyclic_total_turning"],
    title: { text: "周期数を増やした閉包の回転数差では持ち上げの回転数を取り出せない" },
    body: [
      paragraph([
        "周期数 ", math(String.raw`c`), " の閉包と周期数 ", math(String.raw`c+1`),
        " の閉包の循環総回転数を比較する候補は採用しない。接続階段の向きの有限語を ",
        math(String.raw`A`), "、周期持ち上げ一周期分の向きの巡回語を ", math(String.raw`P`),
        " とし、向きを全て反転して順序を逆にした語をそれぞれ ",
        math(String.raw`\overline A,\overline P`), " と書く。閉包の向きの巡回語は、",
      ]),
      displayMath(String.raw`A\,P^{c}\,\overline A\,\overline P^{c}`),
      paragraph([
        "の形である。周期数を一つ増やすと、順向きの周期語 ", math(String.raw`P`),
        " と逆向きの周期語 ", math(String.raw`\overline P`),
        " が一つずつ同時に挿入される。巡回語の回転数和を ", math(String.raw`T`),
        " と書くと、巡回の開始位置をずらしても有限和は変わらず、逆向きでは各回転の符号が反転するので",
      ]),
      displayMath(String.raw`T(P)+T(\overline P)=T(P)-T(P)=0`),
      paragraph([
        "となる。したがって閉包の循環総回転数の差は、元の ", math(String.raw`T(P)`),
        " の値にかかわらず零であり、この差から ", math(String.raw`T(P)=0`),
        " を導くことはできない。SageMath の有限全列挙でも、一辺 ", math(String.raw`L=1,2,3`),
        " の全対象について周期数 ", math(String.raw`c=1,2,3`),
        " の閉包の循環総回転数が一致し、追加された順向き・逆向きの一周期の和が零になることを整数だけで確認した",
        "（sagemath/check/periodic-lift-closure-cycle）。次は、逆向きの周期持ち上げを同時に追加しない一側閉包を構成し、",
        "周期数の差に一周期分だけが残る形へ変える必要がある。",
      ]),
    ],
  },
  {
    id: "note_kac_ward_claim_doubled_edge_fiber_phase_reduction_unlocked_residual_noncancellation",
    targets: ["claim_doubled_edge_fiber_phase_reduction", "def_unswitchable_standard_pair_subset"],
    title: { text: "切り替え可能接触を持つ残余は符号反転対合で相殺できない" },
    body: [
      paragraph([
        "標準対が切り替え不能な残余 ", math(String.raw`\mathcal R_L`),
        " のうち、別の切り替え可能な接触対を持つ部分について、平滑化と両立する接触対の選択規則を",
        "作って符号反転対合で相殺する候補は採用しない。理由は二つある。第一に、切り替え可能な接触対の",
        "辞書式最小を選ぶ規則は平滑化と両立しない。一辺 ", math(String.raw`L=2`),
        " のこの部分 ", math(String.raw`17{,}925`), " 個を厳密に列挙したところ、辞書式最小の",
        "切り替え可能対での平滑化が標準対を切り替え可能へ変えて残余から出すものが ",
        math(String.raw`4{,}638`), " 個、平滑化後に辞書式最小の切り替え可能対が変わるものが ",
        math(String.raw`7{,}935`), " 個あった。",
      ]),
      paragraph([
        "第二に、選択規則の作り方に依らず、相殺そのものが不可能である。ファイバーを保ち",
        "位相寄与の符号を反転する不動点の無い対合がこの部分の上に存在すれば、その位相寄与の総和は",
        "各ファイバー×スピン構造で零になるはずである。ところが一辺 ", math(String.raw`L=2`),
        " の厳密和は、この部分が空でない ", math(String.raw`1{,}288`), " 組中 ",
        math(String.raw`380`), " 組で非零であり、残余 ", math(String.raw`\mathcal R_L`),
        " 全体の総和も ", math(String.raw`1{,}028`), " 組で非零である",
        "（sagemath/check/unlocked-residual-phase-noncancellation）。したがって残余は相殺の対象ではなく、",
        "回転差が正負四の二集合と合わせて、符号付き偶部分グラフ多項式の平方の項と数え上げで",
        "対応づけるべき寄与として扱う。この検算は有限集合の比較と円分体 ",
        math(String.raw`\mathbb Q(\zeta_8)`), " の厳密和だけで完結し、実数体は用いない。",
      ]),
    ],
  },
  {
    id: "note_kac_ward_def_fiber_phase_weight_signed_selection_sum_fiberwise_equality",
    targets: ["def_fiber_phase_weight", "def_signed_selection_sum"],
    title: { text: "一辺二では置換ファイバー位相和と偶部分グラフ選択和が添字ごとに一致する" },
    body: [
      paragraph([
        "一般の平方恒等式で目標にすべき対応を確定するため、一辺 ", math(String.raw`L=2`),
        " の全非後退置換を反転対の辺集合 ", math(String.raw`D`), " と単純通過の辺集合 ",
        math(String.raw`E`), " で層別し、置換側の位相和 ",
        math(String.raw`\mathcal K^{a,b}_L(D,E)`), " と偶部分グラフ対側の符号付き選択和 ",
        math(String.raw`\mathcal U^{a,b}_L(D,E)`), " を定義から直接比較した。全 ",
        math(String.raw`609`), " ファイバーと四つのスピン構造、合計 ",
        math(String.raw`2{,}436`), " 件で",
      ]),
      displayMath(String.raw`\mathcal K^{a,b}_L(D,E)=\mathcal U^{a,b}_L(D,E)`),
      paragraph([
        "が成立した（sagemath/check/kac-ward-fiber-signed-selection-equality）。したがって、",
        "多項式全体の係数をまとめて比較するだけでなく、接触の無い置換、回転差が正負四の置換、",
        "残余を合わせた位相和を、同じ ", math(String.raw`(D,E)`),
        " の選択集合と数え上げで対応づければ平方恒等式へ合成できる。これは一般の ",
        math(String.raw`L`), " に対する証明ではなく、次に構成すべきファイバーごとの全単射または",
        "符号付き数え上げの目標を固定する厳密観察である。計算は有限集合、整数、円分体 ",
        math(String.raw`\mathbb Q(\zeta_8)`), " だけで閉じ、実数体は用いない。",
      ]),
    ],
  },
  {
    id: "note_kac_ward_claim_contact_smoothing_same_pair_involution_lexicographic_choice_counterexample",
    targets: ["claim_contact_smoothing_same_pair_involution"],
    title: { text: "辞書式最小の切り替え可能接触対は平滑化で保たれない" },
    body: [
      paragraph([
        "切り替え可能な接触対全体を向き付き辺の固定した辞書式順序で並べ、最小の対を選ぶ規則は、",
        "符号反転対合の標準対として採用しない。同じ対での平滑化は対合であるが、平滑化によって",
        "その対と一辺だけを共有する別の接触対の切り替え可能性が変わり得るため、最小の対そのものは保存されない。",
      ]),
      paragraph([
        "一辺 ", math(String.raw`L=2`), " の全非後退置換 ", math(String.raw`30{,}784`),
        " 個を厳密に列挙したところ、切り替え可能な接触対を持つ置換は ", math(String.raw`29{,}905`),
        " 個あり、そのうち ", math(String.raw`7{,}935`),
        " 個で、辞書式最小対による平滑化の前後に選ばれる対が異なった",
        "（sagemath/check/lexicographic-switchable-contact-choice-counterexample）。",
        "したがって、次に定める標準対は単なる最小化ではなく、平滑化の前後で同じ局所データを選ぶ規則でなければならない。",
        "この検算は有限集合の比較だけで完結し、実数体も複素数体も用いない。",
      ]),
    ],
  },
]);
