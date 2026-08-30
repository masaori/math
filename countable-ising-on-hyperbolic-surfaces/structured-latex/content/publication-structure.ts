import { defineBlocks, paragraph } from "../schema.ts";

const goal = <const Id extends string>(id: Id, title: string, text: string, habitat: "finite" | "F2" | "Q" | "QPolynomial" | "Lambda" | "ZPolynomial" | "Qbar" = "finite") => ({
  id: `publication_goal_${id}` as const,
  kind: "remark" as const,
  title: { text: title },
  labels: [`remark_goal_${id}`] as const,
  habitat,
  statement: [paragraph<never>([text])],
});

const heading = <const Id extends string>(id: Id, level: 1 | 2, text: string) => ({
  id: `publication_heading_${id}` as const,
  kind: "heading" as const,
  level,
  title: { text },
  labels: [`heading_${id}`] as const,
});

export default defineBlocks([
  heading("mathematical_tools", 1, "数学的道具立て"),
  heading("finite_data_group_foundations", 2, "有限データ・有限置換群・剰余類"),
  goal("finite_data_group_foundations", "この節の入出力と主定義", "入力は空集合と集合演算である。出力は自然数、集合の大きさを固定する宇宙、有限部分集合、順序対と直積、二元体、自然数上の遺伝的有限データ、有限群と有限置換群の記法、有限群作用、推移性、および左剰余類集合である。主定義はこれらを使用前に一意に導入し、後続の有限商・セル分割・二元体上の線形代数が使う基礎型を確定する。"),
  heading("finite_graph_even_subgraphs", 2, "有限グラフと偶部分グラフ"),
  goal("finite_graph_even_subgraphs", "この節の入出力と主張", "入力は有限の頂点集合・辺集合と各辺の二端点である。出力は辺部分集合の境界偶奇、偶辺部分集合、および偶部分グラフ多項式である。この節はこれらの有限組合せデータを定義し、双曲曲面・格子・スピンを仮定しない。"),
  heading("two_stage_group_quotient_input", 2, "二段有限群商の代数的入力"),
  goal("two_stage_group_quotient_input", "この節の入出力と主張", "入力は空でない有限集合上の有限置換群と、その置換群に含まれる入れ子の正規部分群である。出力は二段の有限商群と段間全射群準同型である。この節は後のセル写像に必要な代数的入力だけを定義し、曲面性や被覆性を主張しない。"),
  heading("finite_cell_complex_data", 2, "有限セル複体の組合せデータ"),
  goal("finite_cell_complex_data", "この節の入出力と主定理", "入力は有限の頂点・辺・面と incidence データである。出力は向き付け閉曲面セル分割の有限判定、正則型、Euler 標数、および incidence 等式である。主定理は正則セル分割の Euler 標数を有限個の incidence 数だけで表す等式である。ここでは双曲型やスピンを仮定しない。"),
  heading("f2_chain_homology", 2, "F_2 セル鎖と第一ホモロジー"),
  goal("f2_chain_homology", "この節の入出力と主定理", "入力は有限セル複体の境界 incidence である。出力は一次・二次境界写像、一次サイクル空間、面境界空間、および第一ホモロジー群である。主定理は二つの境界写像の合成が零であることであり、これが第一ホモロジー群の定義を正当化する。", "F2"),
  heading("homology_class_even_subgraph_polynomials", 2, "ホモロジー類別の偶部分グラフ多項式"),
  goal("homology_class_even_subgraph_polynomials", "この節の入出力と主定理", "入力は有限グラフの偶辺部分集合と、そのグラフを一次骨格に持つ有限セル複体の第一ホモロジー群である。出力は偶辺部分集合のホモロジー類と、類ごとの偶部分グラフ多項式である。主定理は類別多項式の総和が元の偶部分グラフ多項式に一致することである。", "QPolynomial"),
  heading("finite_fourier_analysis", 2, "有限文字と Fourier 反転"),
  goal("finite_fourier_analysis", "この節の入出力と主定理", "入力は有限セル複体から得た有限第一ホモロジー群と、その F_2 値文字である。出力は整数符号文字、文字直交関係、および有限 Fourier 逆変換である。主定理は文字直交関係から導く逆変換であり、この節では双曲型・格子・スピンを仮定しない。", "QPolynomial"),
  heading("primal_dual_fourier", 2, "主セルと双対セルのホモロジー移送"),
  goal("primal_dual_fourier", "この節の入出力と主定理", "入力は向き付け閉曲面セル分割の主セルと双対セルの対応である。出力は主第一コホモロジーから双対第一ホモロジーへの誘導写像である。主定理は、この誘導写像が全単射であることである。主第一ホモロジーの文字空間との同定、および Ising 多項式の双対変換は主張しない。", "F2"),
  heading("prime_exponent_encoding", 2, "素指数による正有理数の符号化"),
  goal("prime_exponent_encoding", "この節の入出力と主張", "入力は正有理数である。出力は有限台の素指数データからなる素指数加法群値である。この節で確定するのは写像の定義と有限台による well-defined 性であり、準同型性や単射性は主張しない。", "Lambda"),

  heading("hyperbolic_ising_semantics", 1, "有限双曲曲面上のイジング模型のセマンティクスを持つもの"),
  heading("paper_scope_and_quotient_input", 2, "本論文の対象と有限置換商セル分割"),
  goal("paper_scope_and_quotient_input", "この節の入出力と主定義", "入力は有限置換商と辺剰余類代表元である。出力は型付きの剰余類セル分割候補、位相的実現データ、正則双曲計量実現、および本論文で有限双曲曲面と呼ぶ対象集合である。主定義は有限構成条件と計量的実現条件を別層に保ち、一般の入力に対する存在は主張しない。", "Q"),
  heading("hyperbolic_regular_types", 2, "双曲正則型と Euler 標数"),
  goal("hyperbolic_regular_types", "この節の入出力と主定理", "入力は向き付け閉曲面の正則セル分割型である。出力は双曲正則型の有限不等式判定と次数下界である。主定理は双曲正則型であることと負の Euler 標数を持つことの同値である。曲率 -1 計量の存在や構成は主張しない。", "Q"),
  heading("product_difference_classification", 2, "積差ごとの双曲正則型分類"),
  goal("product_difference_classification", "この節の入出力と主張", "入力は積差を五から百三十二までの一つに固定した有限整数方程式である。出力はその積差を持つ双曲正則型の有限列挙である。各定理は固定した積差についての必要十分分類であり、百三十二を超える積差の一般分類は主張しない。", "finite"),
  heading("finite_quotient_hyperbolic_lattice", 2, "有限置換商からの双曲格子生成"),
  goal("finite_quotient_hyperbolic_lattice", "この節の入出力と主定理", "入力は八点上の固定した Q_{3,7} 置換商と辞書式最小辺代表元である。出力はその入力から得る有限セルデータの組合せ的検査証明書である。主定理はこの固定例に限り、一般の有限置換商に対する閉曲面性や曲率 -1 計量の存在を主張しない。", "Q"),
  heading("ising_partition_polynomial", 2, "有限グラフ Ising 分配多項式"),
  goal("ising_partition_polynomial", "この節の入出力と主定理", "入力は有限双曲セル分割の一次骨格と二値スピンである。出力は破れ辺数の多重度と Ising 分配多項式である。主張の到達点は、固定した有限商格子の分配多項式を整係数多項式として得ることである。偶部分グラフ多項式との恒等式は主張しない。", "ZPolynomial"),
  heading("fixed_lattice_arithmetic", 2, "固定格子の算術的不変量と Fisher 零点"),
  goal("fixed_lattice_arithmetic", "この節の入出力と主定理", "入力は固定した有限商格子の Ising 分配多項式である。出力は係数付値、既約分解、Fisher 零点、分解体、Galois 群、および有理根分離証明書である。主定理は分解体 Galois 群の全対称群同定と、それから従う厳密次数・非可解性・根式非可解性である。", "Qbar"),
  heading("quotient_tower_comparison", 2, "有限商の塔に沿う比較"),
  goal("quotient_tower_comparison", "この節の入出力と主定理", "入力は役割生成元と辺代表元が整合する二段の有限商、二次境界については面位置写像の各ファイバーが F_2 上で奇数であるという条件、および各段のセル・ホモロジー・Ising 多項式である。出力は押し出し、文字の引き戻し、有限 Fourier 変換の整合性、係数付値差、Fisher 零点形式的因子である。主定理は有限 Fourier 変換と押し出し・引き戻しの整合性であり、算術側の到達点は二段 Fisher 零点形式的因子の段別差表示である。局所全単射性、被覆次数、閉曲面性の保存は主張しない。この節は有限集合、F_2、整数、有理数、素指数加法群、代数的数の範囲で閉じる。", "Qbar"),
]);
