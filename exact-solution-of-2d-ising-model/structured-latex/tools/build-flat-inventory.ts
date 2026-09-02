import { createHash } from "node:crypto";
import { mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { loadContentFiles } from "./content-modules.ts";
import {
  assertReviewedContentFingerprint,
  centralizerIsScalarExpectedSha256,
} from "./reviewed-content-fingerprint.ts";

const projectDir = join(dirname(fileURLToPath(import.meta.url)), "..", "..");
const outputPath = join(projectDir, "docs", "organization", "flat-inventory.json");
const finalChapters = ["数学的道具立て", "2次元イジングモデル"] as const;
type FinalChapter = typeof finalChapters[number];
const mathematicalToolFiles = new Set([
  "000_calculation_formulae_00_09.ts", "000_calculation_formulae_10_19.ts",
  "000_calculation_formulae_20_29.ts", "000_calculation_formulae_30_44.ts",
  "000_calculation_formulae_45_46.ts", "002_linear_space_general.ts",
  "003_exp_linear_map.ts", "005_exp_conjugation_proof.ts",
]);
const mathematicalToolEntryIdsOutsideToolFiles = new Set([
  "eigenvalues_of_V_001_definition_trace",
  "eigenvalues_of_V_002_claim_trace_properties",
  "eigenvalues_of_V_003_claim_trace_of_idempotent",
  "eigenvalues_of_V_011_definition_hermitian_positive_definite",
  "eigenvalues_of_V_012_claim_star_is_norm_preserving",
  "eigenvalues_of_V_013_claim_exp_hermitian_positive_definite",
  "bridge_003_claim_exp_of_diagonal",
  "maxeig_005_claim_psd_cauchy_schwarz",
  "freeenergy_004_theorem_riemann_sum_to_integral",
  "critical_001_claim_cosh_addition_and_half_angle",
  "critical_008_claim_elementary_sine_bounds",
  "critical_009_claim_closed_form_log_integral",
  "critical_010_claim_sine_integral_two_sided",
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site",
  "TV1_hatZ_hatY_004_claim_sinh_cosh_taylor",
  "TV1_hatZ_hatY_009_definition_invertible_elements",
  "TV1_hatZ_hatY_011_definition_T_g",
  "TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar",
  "TV1_hatZ_hatY_011a_claim_injectivity_of_T",
  "TV1_hatZ_hatY_definition_pauli_group",
  "transfer_matrix_005_definition_end_isomorphism",
  "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
  "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
  "transfer_matrix_claim_end_acts_on_kronecker_products",
  "TV1_hatZ_hatY_010_definition_clifford_group",
]);
const matrixExponentialConjugationSectionEntryIds = [
  "exp_conjugation_proof_010_theorem_matrix_exp_conjugation",
  "exp_conjugation_proof_008_theorem_exp_ad_series",
] as const;
const matrixExponentialConjugationExpectedInternalDependencies = new Map<string, string[]>([
  ["exp_conjugation_proof_010_theorem_matrix_exp_conjugation", []],
  ["exp_conjugation_proof_008_theorem_exp_ad_series", [
    "exp_conjugation_proof_010_theorem_matrix_exp_conjugation",
  ]],
]);
const matrixExponentialConjugationExpectedContentSha256 = new Map<string, string>([
  ["exp_conjugation_proof_010_theorem_matrix_exp_conjugation", "64229f938d8d19d12dd93c396ec488b8f44803a7f0f9d00b6c4b3ce8a115a867"],
  ["exp_conjugation_proof_008_theorem_exp_ad_series", "c9e30902311cd76998b6716da76e040f081a0b4dcad42a5f1ad6d99331ab999b"],
]);
const matrixExponentialConjugationExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_conjugation_proof_004_theorem_ad_binomial",
  "exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix",
  "exp_linear_map_000a_claim_real_exp_series_converges",
  "exp_linear_map_000b_claim_matrix_exp_series_converges",
  "exp_linear_map_001_theorem_exp_series_pointwise_converges",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
  "exp_linear_map_004_theorem_exp_zero_is_identity",
  "linear_space_general_002b_definition_matrix_norm",
  "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
  "linear_space_general_003_claim_matrix_norm_submultiplicativity",
  "linear_space_general_003d_claim_matrix_completeness",
].sort();
const matrixLinearMapCorrespondenceSectionEntryIds = [
  "transfer_matrix_005_definition_end_isomorphism",
  "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
  "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
  "transfer_matrix_claim_end_acts_on_kronecker_products",
] as const;
const matrixLinearMapCorrespondenceExpectedInternalDependencies = new Map<string, string[]>([
  ["transfer_matrix_005_definition_end_isomorphism", []],
  ["transfer_matrix_005b_claim_end_is_algebra_isomorphism", [
    "transfer_matrix_005_definition_end_isomorphism",
  ]],
  ["transfer_matrix_005c_claim_end_preserves_matrix_exponential", [
    "transfer_matrix_005_definition_end_isomorphism",
    "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
  ]],
  ["transfer_matrix_claim_end_acts_on_kronecker_products", [
    "transfer_matrix_005_definition_end_isomorphism",
  ]],
]);
const matrixLinearMapCorrespondenceExpectedContentSha256 = new Map<string, string>([
  ["transfer_matrix_005_definition_end_isomorphism", "651f3dbd8a1ace2d2c641c9424fb4148011370c9100f9887ab06b9696e18d52a"],
  ["transfer_matrix_005b_claim_end_is_algebra_isomorphism", "1a9ecef9cd59f12d82071b4c248e4319f7c9be8e3f42cf1bc9289737d9e5d033"],
  ["transfer_matrix_005c_claim_end_preserves_matrix_exponential", "6b163e3b366800fd0dcda4eec827fa428e8721922ff5b3e064127c321b4d62c0"],
  ["transfer_matrix_claim_end_acts_on_kronecker_products", "1a2d1ad2a81a5e00bb14c44c0527fe6bd668077325112d62a4a0e4278960c019"],
]);
const matrixLinearMapCorrespondenceExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_linear_map_001_theorem_exp_series_pointwise_converges",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "linear_space_general_000_definition_kronecker_product",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000c_claim_kronecker_multilinear",
  "linear_space_general_001_theorem_tensor_product_basis",
].sort();
const matrixLinearMapCorrespondenceExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["linear_space_general_000_definition_kronecker_product", "d67144d5a2fc061d370a8a29846c5cdb963a1b6ce42b0f6b08daee519364bc40"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "d56b2a60243b4307c691d3f908be75e465b5319aa6209405017082a2055eb9c3"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "e644e2525aecd17cc1b8c439db76c6c4b94348dd1fe9c63405c5c8b6077f068d"],
  ["linear_space_general_001_theorem_tensor_product_basis", "b1d6fa5e021b9be178b745de740fe02f935e6e352a7fb758d4994f2eeb43cbc2"],
  ["exp_linear_map_001_theorem_exp_series_pointwise_converges", "af6e085d614179050c2b2cfc62548b146f41083dbe158453221af092d9796239"],
  ["exp_linear_map_002_definition_exp_of_endomorphism", "6d1e05adbfc624b89b429dda12fd2afb5818d6a62fa9f18d3801a2bca1506098"],
]);
const invertibleMatrixConjugationSectionEntryIds = [
  "TV1_hatZ_hatY_009_definition_invertible_elements",
  "TV1_hatZ_hatY_011_definition_T_g",
  "TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar",
  "TV1_hatZ_hatY_011a_claim_injectivity_of_T",
] as const;
const invertibleMatrixConjugationExpectedInternalDependencies = new Map<string, string[]>([
  ["TV1_hatZ_hatY_009_definition_invertible_elements", []],
  ["TV1_hatZ_hatY_011_definition_T_g", [
    "TV1_hatZ_hatY_009_definition_invertible_elements",
  ]],
  ["TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar", [
    "TV1_hatZ_hatY_009_definition_invertible_elements",
  ]],
  ["TV1_hatZ_hatY_011a_claim_injectivity_of_T", [
    "TV1_hatZ_hatY_009_definition_invertible_elements",
    "TV1_hatZ_hatY_011_definition_T_g",
    "TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar",
  ]],
]);
const invertibleMatrixConjugationExpectedContentSha256 = new Map<string, string>([
  ["TV1_hatZ_hatY_009_definition_invertible_elements", "31432b10d571100575fc2bddf157032908bf0996d21d3f77860b0dc613fd7533"],
  ["TV1_hatZ_hatY_011_definition_T_g", "5f2b17e53697b3403829f55a1b07c6c85da5db2f0683d5e0d821ac74ac5baeb4"],
  ["TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar", "36a619c070399daf4e9acddd4cc7c0b7c1b285ba09e5abd36ecc9f4d23bcafaa"],
  ["TV1_hatZ_hatY_011a_claim_injectivity_of_T", "a0b055ecb95c4f3911dae071db35335e8b9bfe2e730b34bb520330174ff9d29b"],
]);
const invertibleMatrixConjugationExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000c_claim_kronecker_multilinear",
  "linear_space_general_001_theorem_tensor_product_basis",
  "linear_space_general_002_claim_scalar_identity_commutes",
  "linear_space_general_004_lemma_centralizer_is_scalar",
].sort();
const invertibleMatrixConjugationExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "d56b2a60243b4307c691d3f908be75e465b5319aa6209405017082a2055eb9c3"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "e644e2525aecd17cc1b8c439db76c6c4b94348dd1fe9c63405c5c8b6077f068d"],
  ["linear_space_general_001_theorem_tensor_product_basis", "b1d6fa5e021b9be178b745de740fe02f935e6e352a7fb758d4994f2eeb43cbc2"],
  ["linear_space_general_002_claim_scalar_identity_commutes", "f8f5ddafc9ff868ec1ace87dae5f992b09aacc9063d84f3f432c8b3273ba873e"],
  ["linear_space_general_004_lemma_centralizer_is_scalar", centralizerIsScalarExpectedSha256],
]);
const pauliAndCliffordMatrixGroupsSectionEntryIds = [
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "TV1_hatZ_hatY_definition_pauli_group",
  "TV1_hatZ_hatY_010_definition_clifford_group",
] as const;
const pauliAndCliffordMatrixGroupsExpectedInternalDependencies = new Map<string, string[]>([
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", []],
  ["TV1_hatZ_hatY_definition_pauli_group", [
    "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  ]],
  ["TV1_hatZ_hatY_010_definition_clifford_group", [
    "TV1_hatZ_hatY_definition_pauli_group",
  ]],
]);
const pauliAndCliffordMatrixGroupsExpectedContentSha256 = new Map<string, string>([
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "f36fc233fa67016fa14bad33b5625da3eac50932ae426af52afb18674f9ff0dc"],
  ["TV1_hatZ_hatY_definition_pauli_group", "251f5e6d1a38e2b6eaf8eae4413d9b498ca0857207dc8918481a680a38064c7b"],
  ["TV1_hatZ_hatY_010_definition_clifford_group", "1196412a13aedcd3b42b2e18886fabb2e4cbe482e6bc9a8beb78c0bfa5d18c92"],
]);
const pauliAndCliffordMatrixGroupsExpectedExternalInputEntryIds = [
  "TV1_hatZ_hatY_009_definition_invertible_elements",
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000c_claim_kronecker_multilinear",
].sort();
const pauliAndCliffordMatrixGroupsExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["calc_formulae_003_matrix_decomposition", "a97a47798c1376adfb7b1536fdbb7d39f2a0953080fdf0177149de1f7ba89200"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "d56b2a60243b4307c691d3f908be75e465b5319aa6209405017082a2055eb9c3"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "e644e2525aecd17cc1b8c439db76c6c4b94348dd1fe9c63405c5c8b6077f068d"],
  ["TV1_hatZ_hatY_009_definition_invertible_elements", "31432b10d571100575fc2bddf157032908bf0996d21d3f77860b0dc613fd7533"],
]);
const singleFactorAnticommutationSectionEntryIds = [
  "Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site",
] as const;
const singleFactorAnticommutationExpectedInternalDependencies = new Map<string, string[]>([
  ["Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site", []],
]);
const singleFactorAnticommutationExpectedContentSha256 = new Map<string, string>([
  ["Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site", "95d5468bee33981a077bfcd1c67e1bfc7eb0f5e11007fcb3602ef07137ba9343"],
]);
const singleFactorAnticommutationExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000c_claim_kronecker_multilinear",
].sort();
const singleFactorAnticommutationExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "d56b2a60243b4307c691d3f908be75e465b5319aa6209405017082a2055eb9c3"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "e644e2525aecd17cc1b8c439db76c6c4b94348dd1fe9c63405c5c8b6077f068d"],
]);
const isingModelDefinitionSectionEntryIds = [
  "partition_function_2d_ising_001_definition_lattice_size",
  "partition_function_2d_ising_002_definition_partition_function",
  "partition_function_2d_ising_003_definition_transfer_matrix",
] as const;
const isingModelDefinitionExpectedInternalDependencies = new Map<string, string[]>([
  ["partition_function_2d_ising_001_definition_lattice_size", []],
  ["partition_function_2d_ising_002_definition_partition_function", [
    "partition_function_2d_ising_001_definition_lattice_size",
  ]],
  ["partition_function_2d_ising_003_definition_transfer_matrix", [
    "partition_function_2d_ising_002_definition_partition_function",
  ]],
]);
const isingModelDefinitionExpectedContentSha256 = new Map<string, string>([
  ["partition_function_2d_ising_001_definition_lattice_size", "14296f06180cee80476d2042b80f8f3a4b68121b3e8e19b8adf0b2eb6193189a"],
  ["partition_function_2d_ising_002_definition_partition_function", "74bec1b8de279c13b6254833510bea1c16ba66f36a13323c7c2e75cbc97cfbcb"],
  ["partition_function_2d_ising_003_definition_transfer_matrix", "48b09c189776f6550beac7306cbb8ee033259dfc84221059a44ed3c5672f607d"],
]);
const isingModelDefinitionExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
].sort();
const isingModelDefinitionExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
]);
const spinConfigurationBasisSectionEntryIds = [
  "bridge_001_definition_config_basis",
] as const;
const spinConfigurationBasisExpectedInternalDependencies = new Map<string, string[]>([
  ["bridge_001_definition_config_basis", []],
]);
const spinConfigurationBasisExpectedContentSha256 = new Map<string, string>([
  ["bridge_001_definition_config_basis", "c29559e9454e9cb5483e5bd1a1f852995a0904aab977f59d0e209bdbcd28297d"],
]);
const spinConfigurationBasisExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "partition_function_2d_ising_003_definition_transfer_matrix",
  "transfer_matrix_005_definition_end_isomorphism",
].sort();
const spinConfigurationBasisExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["transfer_matrix_005_definition_end_isomorphism", "651f3dbd8a1ace2d2c641c9424fb4148011370c9100f9887ab06b9696e18d52a"],
  ["partition_function_2d_ising_003_definition_transfer_matrix", "48b09c189776f6550beac7306cbb8ee033259dfc84221059a44ed3c5672f607d"],
]);
const openChainSpinSumsSectionEntryIds = [
  "closing_005_definition_open_chain_spin_energy",
  "closing_005_claim_open_chain_endpoint_product_sum",
  "closing_005_claim_open_chain_partition_sum",
  "closing_005_claim_open_chain_spin_sums_positive",
] as const;
const openChainSpinSumsExpectedInternalDependencies = new Map<string, string[]>([
  ["closing_005_definition_open_chain_spin_energy", []],
  ["closing_005_claim_open_chain_endpoint_product_sum", ["closing_005_definition_open_chain_spin_energy"]],
  ["closing_005_claim_open_chain_partition_sum", ["closing_005_definition_open_chain_spin_energy"]],
  ["closing_005_claim_open_chain_spin_sums_positive", [
    "closing_005_claim_open_chain_endpoint_product_sum",
    "closing_005_claim_open_chain_partition_sum",
    "closing_005_definition_open_chain_spin_energy",
  ]],
]);
const openChainSpinSumsExpectedContentSha256 = new Map<string, string>([
  ["closing_005_definition_open_chain_spin_energy", "2062fa60483069fd13042b3bf943fdfaf32a14ae598f523f41b8b97380cc8f8d"],
  ["closing_005_claim_open_chain_endpoint_product_sum", "002ddb1410f5983a61e4df1c0cf886c47a43ca9825c9dc2563aa9bda84029d89"],
  ["closing_005_claim_open_chain_partition_sum", "97a1758b41d17a52343ba1188eecf112d46ba48112797988021d8d20669a19fc"],
  ["closing_005_claim_open_chain_spin_sums_positive", "c7a0451efa605dd17821efc7a433df7f151dee481ae5c7bb88f3003e2356da9b"],
]);
const openChainSpinSumsExpectedExternalInputEntryIds = [
  "calc_formulae_000b_claim_cosh_sinh_basic_properties",
  "calc_formulae_definition_cosh_sinh",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
  "partition_function_2d_ising_003_definition_transfer_matrix",
].sort();
const openChainSpinSumsExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", "2527bb859515783eeeb40add04aa0f13c62f4d9994e2a3437db5fd501ef40aed"],
  ["calc_formulae_definition_cosh_sinh", "e884934c5a35ebb1daa4e665eb779f623f99cffba33fe779cf01ee52518a6d3a"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "de25a7cfd8a1fd81d0d86ca48b4d3a85550853b4857925dd6768c842c31cdeb0"],
  ["partition_function_2d_ising_003_definition_transfer_matrix", "48b09c189776f6550beac7306cbb8ee033259dfc84221059a44ed3c5672f607d"],
]);
const partitionFunctionTraceSectionEntryIds = [
  "partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix",
] as const;
const partitionFunctionTraceExpectedInternalDependencies = new Map<string, string[]>([
  ["partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix", []],
]);
const partitionFunctionTraceExpectedContentSha256 = new Map<string, string>([
  ["partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix", "4d75ed97d4d191d456d08d8792a12a63620fdb14d91e33a3edbd65399b96eddc"],
]);
const partitionFunctionTraceExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
  "eigenvalues_of_V_001_definition_trace",
  "partition_function_2d_ising_002_definition_partition_function",
  "partition_function_2d_ising_003_definition_transfer_matrix",
].sort();
const partitionFunctionTraceExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "de25a7cfd8a1fd81d0d86ca48b4d3a85550853b4857925dd6768c842c31cdeb0"],
  ["eigenvalues_of_V_001_definition_trace", "35ae403d96746496fb0fdaa59d0122e38c3fc5129338230666507cb62c07a73d"],
  ["partition_function_2d_ising_002_definition_partition_function", "74bec1b8de279c13b6254833510bea1c16ba66f36a13323c7c2e75cbc97cfbcb"],
  ["partition_function_2d_ising_003_definition_transfer_matrix", "48b09c189776f6550beac7306cbb8ee033259dfc84221059a44ed3c5672f607d"],
]);
const v1PauliRepresentationSectionEntryIds = [
  "transfer_matrix_001_definition_symbols",
  "bridge_002_claim_sigma_z_diagonal_action",
  "bridge_004_claim_V1_component_equals_pauli",
] as const;
const v1PauliRepresentationExpectedInternalDependencies = new Map<string, string[]>([
  ["transfer_matrix_001_definition_symbols", []],
  ["bridge_002_claim_sigma_z_diagonal_action", [
    "transfer_matrix_001_definition_symbols",
  ]],
  ["bridge_004_claim_V1_component_equals_pauli", [
    "bridge_002_claim_sigma_z_diagonal_action",
    "transfer_matrix_001_definition_symbols",
  ]],
]);
const v1PauliRepresentationExpectedDirectDependencies = new Map<string, string[]>([
  ["transfer_matrix_001_definition_symbols", [
    "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
    "calc_formulae_000b_claim_cosh_sinh_basic_properties",
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_definition_cosh_sinh",
    "calculation_formulae_definition_set_and_algebra_notation",
    "exp_linear_map_002_definition_exp_of_endomorphism",
    "linear_space_general_000_definition_kronecker_product",
  ]],
  ["bridge_002_claim_sigma_z_diagonal_action", [
    "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
    "bridge_001_definition_config_basis",
    "calc_formulae_006_definition_of_cc",
    "linear_space_general_000b_claim_kronecker_product_rule",
    "linear_space_general_000c_claim_kronecker_multilinear",
    "transfer_matrix_001_definition_symbols",
    "transfer_matrix_005_definition_end_isomorphism",
  ]],
  ["bridge_004_claim_V1_component_equals_pauli", [
    "bridge_001_definition_config_basis",
    "bridge_002_claim_sigma_z_diagonal_action",
    "bridge_003_claim_exp_of_diagonal",
    "calculation_formulae_definition_set_and_algebra_notation",
    "partition_function_2d_ising_003_definition_transfer_matrix",
    "transfer_matrix_001_definition_symbols",
  ]],
]);
const v1PauliRepresentationExpectedContentSha256 = new Map<string, string>([
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
  ["bridge_002_claim_sigma_z_diagonal_action", "13002ebb9535f89209c2ebfa23358a0f95c1c1b2e7bcb24a08c2b00b87a10232"],
  ["bridge_004_claim_V1_component_equals_pauli", "542e930937951f970b4795cbc171117a849f0b5b3e6eae1da351f9970c0c8c0b"],
]);
const v1PauliRepresentationExpectedExternalInputEntryIds = [
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "bridge_001_definition_config_basis",
  "bridge_003_claim_exp_of_diagonal",
  "calc_formulae_000b_claim_cosh_sinh_basic_properties",
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_definition_cosh_sinh",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "linear_space_general_000_definition_kronecker_product",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000c_claim_kronecker_multilinear",
  "partition_function_2d_ising_003_definition_transfer_matrix",
  "transfer_matrix_005_definition_end_isomorphism",
].sort();
const v1PauliRepresentationExpectedExternalInputContentSha256 = new Map<string, string>([
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "f36fc233fa67016fa14bad33b5625da3eac50932ae426af52afb18674f9ff0dc"],
  ["bridge_001_definition_config_basis", "c29559e9454e9cb5483e5bd1a1f852995a0904aab977f59d0e209bdbcd28297d"],
  ["bridge_003_claim_exp_of_diagonal", "5113d388b0ec40f7d2e0a87983fe995b358171afa75fda040decfd1c98460747"],
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", "2527bb859515783eeeb40add04aa0f13c62f4d9994e2a3437db5fd501ef40aed"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calc_formulae_definition_cosh_sinh", "e884934c5a35ebb1daa4e665eb779f623f99cffba33fe779cf01ee52518a6d3a"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["exp_linear_map_002_definition_exp_of_endomorphism", "6d1e05adbfc624b89b429dda12fd2afb5818d6a62fa9f18d3801a2bca1506098"],
  ["linear_space_general_000_definition_kronecker_product", "d67144d5a2fc061d370a8a29846c5cdb963a1b6ce42b0f6b08daee519364bc40"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "d56b2a60243b4307c691d3f908be75e465b5319aa6209405017082a2055eb9c3"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "e644e2525aecd17cc1b8c439db76c6c4b94348dd1fe9c63405c5c8b6077f068d"],
  ["partition_function_2d_ising_003_definition_transfer_matrix", "48b09c189776f6550beac7306cbb8ee033259dfc84221059a44ed3c5672f607d"],
  ["transfer_matrix_005_definition_end_isomorphism", "651f3dbd8a1ace2d2c641c9424fb4148011370c9100f9887ab06b9696e18d52a"],
]);
const nextIsingBoundaryComparisonEntryIds = [
  "bridge_004_claim_V1_component_equals_pauli",
  "bridge_005_claim_two_by_two_transfer_identity",
  "bridge_006_claim_V2_component_equals_pauli",
  "bridge_007_claim_partition_function_in_pauli_form",
] as const;
const nextIsingBoundaryComparisonExpectedChapterOrders = new Map<string, number>([
  ["bridge_004_claim_V1_component_equals_pauli", 12],
  ["bridge_005_claim_two_by_two_transfer_identity", 13],
  ["bridge_006_claim_V2_component_equals_pauli", 14],
  ["bridge_007_claim_partition_function_in_pauli_form", 15],
]);
const nextIsingBoundaryComparisonExpectedDependencies = new Map<string, string[]>([
  ["bridge_004_claim_V1_component_equals_pauli", [
    "bridge_001_definition_config_basis",
    "bridge_002_claim_sigma_z_diagonal_action",
    "bridge_003_claim_exp_of_diagonal",
    "calculation_formulae_definition_set_and_algebra_notation",
    "partition_function_2d_ising_003_definition_transfer_matrix",
    "transfer_matrix_001_definition_symbols",
  ]],
  ["bridge_005_claim_two_by_two_transfer_identity", [
    "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
    "calc_formulae_000b_claim_cosh_sinh_basic_properties",
    "calc_formulae_001_sqrt_nonnegative_real",
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation",
    "exp_linear_map_000a_claim_real_exp_series_converges",
    "exp_linear_map_001_theorem_exp_series_pointwise_converges",
    "exp_linear_map_002_definition_exp_of_endomorphism",
    "transfer_matrix_001_definition_symbols",
  ]],
  ["bridge_006_claim_V2_component_equals_pauli", [
    "bridge_001_definition_config_basis",
    "bridge_003_claim_exp_of_diagonal",
    "bridge_005_claim_two_by_two_transfer_identity",
    "calculation_formulae_definition_set_and_algebra_notation",
    "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
    "linear_space_general_000_definition_kronecker_product",
    "linear_space_general_000b_claim_kronecker_product_rule",
    "linear_space_general_000c_claim_kronecker_multilinear",
    "partition_function_2d_ising_003_definition_transfer_matrix",
    "transfer_matrix_001_definition_symbols",
  ]],
  ["bridge_007_claim_partition_function_in_pauli_form", [
    "bridge_001_definition_config_basis",
    "bridge_004_claim_V1_component_equals_pauli",
    "bridge_006_claim_V2_component_equals_pauli",
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation",
    "eigenvalues_of_V_002_claim_trace_properties",
    "partition_function_2d_ising_002_definition_partition_function",
    "partition_function_2d_ising_003_definition_transfer_matrix",
    "partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix",
    "transfer_matrix_001_definition_symbols",
  ]],
]);
const nextIsingBoundaryComparisonExpectedContentSha256 = new Map<string, string>([
  ["bridge_004_claim_V1_component_equals_pauli", "542e930937951f970b4795cbc171117a849f0b5b3e6eae1da351f9970c0c8c0b"],
  ["bridge_005_claim_two_by_two_transfer_identity", "7488a4fdc7984a8ad7c60219a39eca26d92d3230df4c5c43d320c7931df8d8ee"],
  ["bridge_006_claim_V2_component_equals_pauli", "02f2eb834d7e16abf67232ac9a868ee14eec22cf56c1a5a34294d71ec51f65c1"],
  ["bridge_007_claim_partition_function_in_pauli_form", "33cd6cefa483928ac5bb3e3c71983a82af17222c9030b9596522b8ef575e219a"],
]);
const nextIsingBoundaryComparisonExpectedInputContentSha256 = new Map<string, string>([
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "f36fc233fa67016fa14bad33b5625da3eac50932ae426af52afb18674f9ff0dc"],
  ["bridge_001_definition_config_basis", "c29559e9454e9cb5483e5bd1a1f852995a0904aab977f59d0e209bdbcd28297d"],
  ["bridge_002_claim_sigma_z_diagonal_action", "13002ebb9535f89209c2ebfa23358a0f95c1c1b2e7bcb24a08c2b00b87a10232"],
  ["bridge_003_claim_exp_of_diagonal", "5113d388b0ec40f7d2e0a87983fe995b358171afa75fda040decfd1c98460747"],
  ["bridge_004_claim_V1_component_equals_pauli", "542e930937951f970b4795cbc171117a849f0b5b3e6eae1da351f9970c0c8c0b"],
  ["bridge_005_claim_two_by_two_transfer_identity", "7488a4fdc7984a8ad7c60219a39eca26d92d3230df4c5c43d320c7931df8d8ee"],
  ["bridge_006_claim_V2_component_equals_pauli", "02f2eb834d7e16abf67232ac9a868ee14eec22cf56c1a5a34294d71ec51f65c1"],
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", "2527bb859515783eeeb40add04aa0f13c62f4d9994e2a3437db5fd501ef40aed"],
  ["calc_formulae_001_sqrt_nonnegative_real", "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["exp_linear_map_000a_claim_real_exp_series_converges", "1065e4f465b1b0b49eae7d16f9d734421f472beec053c3effaff63127eecf077"],
  ["exp_linear_map_001_theorem_exp_series_pointwise_converges", "af6e085d614179050c2b2cfc62548b146f41083dbe158453221af092d9796239"],
  ["exp_linear_map_002_definition_exp_of_endomorphism", "6d1e05adbfc624b89b429dda12fd2afb5818d6a62fa9f18d3801a2bca1506098"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "de25a7cfd8a1fd81d0d86ca48b4d3a85550853b4857925dd6768c842c31cdeb0"],
  ["eigenvalues_of_V_002_claim_trace_properties", "60f5d19acef69e141508635a57c36920bef3d1fdd9f2813bb30cb92ca808105a"],
  ["linear_space_general_000_definition_kronecker_product", "d67144d5a2fc061d370a8a29846c5cdb963a1b6ce42b0f6b08daee519364bc40"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "d56b2a60243b4307c691d3f908be75e465b5319aa6209405017082a2055eb9c3"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "e644e2525aecd17cc1b8c439db76c6c4b94348dd1fe9c63405c5c8b6077f068d"],
  ["partition_function_2d_ising_003_definition_transfer_matrix", "48b09c189776f6550beac7306cbb8ee033259dfc84221059a44ed3c5672f607d"],
  ["partition_function_2d_ising_002_definition_partition_function", "74bec1b8de279c13b6254833510bea1c16ba66f36a13323c7c2e75cbc97cfbcb"],
  ["partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix", "4d75ed97d4d191d456d08d8792a12a63620fdb14d91e33a3edbd65399b96eddc"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
]);
const v2PauliPartitionFunctionSectionEntryIds = [
  "bridge_005_claim_two_by_two_transfer_identity",
  "bridge_006_claim_V2_component_equals_pauli",
  "bridge_007_claim_partition_function_in_pauli_form",
] as const;
const v2PauliPartitionFunctionExpectedInternalDependencies = new Map<string, string[]>([
  ["bridge_005_claim_two_by_two_transfer_identity", []],
  ["bridge_006_claim_V2_component_equals_pauli", [
    "bridge_005_claim_two_by_two_transfer_identity",
  ]],
  ["bridge_007_claim_partition_function_in_pauli_form", [
    "bridge_006_claim_V2_component_equals_pauli",
  ]],
]);
const v2PauliPartitionFunctionExpectedExternalInputEntryIds = [
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "bridge_001_definition_config_basis",
  "bridge_003_claim_exp_of_diagonal",
  "bridge_004_claim_V1_component_equals_pauli",
  "calc_formulae_000b_claim_cosh_sinh_basic_properties",
  "calc_formulae_001_sqrt_nonnegative_real",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "eigenvalues_of_V_002_claim_trace_properties",
  "exp_linear_map_000a_claim_real_exp_series_converges",
  "exp_linear_map_001_theorem_exp_series_pointwise_converges",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
  "linear_space_general_000_definition_kronecker_product",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000c_claim_kronecker_multilinear",
  "partition_function_2d_ising_002_definition_partition_function",
  "partition_function_2d_ising_003_definition_transfer_matrix",
  "partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix",
  "transfer_matrix_001_definition_symbols",
].sort();
const epsilonProjectorDefinitionSectionEntryIds = [
  "bridge_008_definition_epsilon_projectors",
] as const;
const epsilonProjectorDefinitionExpectedInternalDependencies = new Map<string, string[]>([
  ["bridge_008_definition_epsilon_projectors", []],
]);
const epsilonProjectorDefinitionExpectedContentSha256 = new Map<string, string>([
  ["bridge_008_definition_epsilon_projectors", "be5003446b4cb92b2911fb88cee1a7cc85dd13f412c3207866e1f70d987c4890"],
]);
const epsilonProjectorDefinitionExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "transfer_matrix_001_definition_symbols",
].sort();
const epsilonProjectorDefinitionExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
]);
const kappaDefinitionSectionEntryIds = ["critical_002_definition_kappa"] as const;
const kappaDefinitionExpectedInternalDependencies = new Map<string, string[]>([
  ["critical_002_definition_kappa", []],
]);
const kappaDefinitionExpectedContentSha256 = new Map<string, string>([
  ["critical_002_definition_kappa", "acd5ce9a1658584ca9ece23706585a304c38ac9e05fdd1474805b4cd4dd2a556"],
]);
const kappaDefinitionExpectedExternalInputEntryIds = [
  "calculation_formulae_definition_set_and_algebra_notation",
  "transfer_matrix_001_definition_symbols",
].sort();
const kappaDefinitionExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
]);
const criticalSinhProductDefinitionSectionEntryIds = ["critical_002a_definition_critical_sinh_product_A"] as const;
const criticalSinhProductDefinitionExpectedInternalDependencies = new Map<string, string[]>([
  ["critical_002a_definition_critical_sinh_product_A", []],
]);
const criticalSinhProductDefinitionExpectedContentSha256 = new Map<string, string>([
  ["critical_002a_definition_critical_sinh_product_A", "99c5d647ef4a1d869147904be1ccbaf48495d1d22bdb0360bb3d58b4eb00f477"],
]);
const criticalSinhProductDefinitionExpectedExternalInputEntryIds = [
  "calc_formulae_000b_claim_cosh_sinh_basic_properties",
  "calculation_formulae_definition_set_and_algebra_notation",
  "transfer_matrix_001_definition_symbols",
].sort();
const criticalSinhProductDefinitionExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", "2527bb859515783eeeb40add04aa0f13c62f4d9994e2a3437db5fd501ef40aed"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
]);
const symmetrizedTransferMatrixSectionEntryIds = [
  "maxeig_001_definition_transfer_matrix_square_root",
  "maxeig_001a_definition_symmetrized_transfer_matrix",
  "maxeig_002_claim_Z_equals_trace_of_W",
] as const;
const symmetrizedTransferMatrixExpectedInternalDependencies = new Map<string, string[]>([
  ["maxeig_001_definition_transfer_matrix_square_root", []],
  ["maxeig_001a_definition_symmetrized_transfer_matrix", ["maxeig_001_definition_transfer_matrix_square_root"]],
  ["maxeig_002_claim_Z_equals_trace_of_W", [
    "maxeig_001_definition_transfer_matrix_square_root",
    "maxeig_001a_definition_symmetrized_transfer_matrix",
  ]],
]);
const symmetrizedTransferMatrixExpectedContentSha256 = new Map<string, string>([
  ["maxeig_001_definition_transfer_matrix_square_root", "6a3dc703d94db789ada47354ee26a8c4e0b16e88af6cabb8eba15113d892142a"],
  ["maxeig_001a_definition_symmetrized_transfer_matrix", "db5c801793afbde0e6ee4c573b08e9e49faa365969d799fbfe71275cc5ff447e"],
  ["maxeig_002_claim_Z_equals_trace_of_W", "621530954ade83c5daa2856a770903da334243dcacde110facf5cfdc5e542e65"],
]);
const symmetrizedTransferMatrixExpectedExternalInputEntryIds = [
  "bridge_007_claim_partition_function_in_pauli_form",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "eigenvalues_of_V_002_claim_trace_properties",
  "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
  "transfer_matrix_001_definition_symbols",
].sort();
const symmetrizedTransferMatrixExpectedExternalInputContentSha256 = new Map<string, string>([
  ["bridge_007_claim_partition_function_in_pauli_form", "33cd6cefa483928ac5bb3e3c71983a82af17222c9030b9596522b8ef575e219a"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["eigenvalues_of_V_002_claim_trace_properties", "60f5d19acef69e141508635a57c36920bef3d1fdd9f2813bb30cb92ca808105a"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "de25a7cfd8a1fd81d0d86ca48b4d3a85550853b4857925dd6768c842c31cdeb0"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
]);
const positiveSymmetrizedTransferMatrixEntriesSectionEntryIds = [
  "maxeig_004_claim_W_has_positive_entries",
] as const;
const positiveSymmetrizedTransferMatrixEntriesExpectedInternalDependencies = new Map<string, string[]>([
  ["maxeig_004_claim_W_has_positive_entries", []],
]);
const positiveSymmetrizedTransferMatrixEntriesExpectedContentSha256 = new Map<string, string>([
  ["maxeig_004_claim_W_has_positive_entries", "8805015267676caca2c8413fa9ed82050cb43311032c106d1295037289185a0e"],
]);
const positiveSymmetrizedTransferMatrixEntriesExpectedExternalInputEntryIds = [
  "bridge_001_definition_config_basis",
  "bridge_002_claim_sigma_z_diagonal_action",
  "bridge_003_claim_exp_of_diagonal",
  "bridge_006_claim_V2_component_equals_pauli",
  "calc_formulae_000b_claim_cosh_sinh_basic_properties",
  "maxeig_001_definition_transfer_matrix_square_root",
  "maxeig_001a_definition_symmetrized_transfer_matrix",
].sort();
const positiveSymmetrizedTransferMatrixEntriesExpectedExternalInputContentSha256 = new Map<string, string>([
  ["bridge_001_definition_config_basis", "c29559e9454e9cb5483e5bd1a1f852995a0904aab977f59d0e209bdbcd28297d"],
  ["bridge_002_claim_sigma_z_diagonal_action", "13002ebb9535f89209c2ebfa23358a0f95c1c1b2e7bcb24a08c2b00b87a10232"],
  ["bridge_003_claim_exp_of_diagonal", "5113d388b0ec40f7d2e0a87983fe995b358171afa75fda040decfd1c98460747"],
  ["bridge_006_claim_V2_component_equals_pauli", "02f2eb834d7e16abf67232ac9a868ee14eec22cf56c1a5a34294d71ec51f65c1"],
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", "2527bb859515783eeeb40add04aa0f13c62f4d9994e2a3437db5fd501ef40aed"],
  ["maxeig_001_definition_transfer_matrix_square_root", "6a3dc703d94db789ada47354ee26a8c4e0b16e88af6cabb8eba15113d892142a"],
  ["maxeig_001a_definition_symmetrized_transfer_matrix", "db5c801793afbde0e6ee4c573b08e9e49faa365969d799fbfe71275cc5ff447e"],
]);
const zYLinearIndependenceSectionEntryIds = [
  "transfer_matrix_002_claim_Z_Y_linearly_independent",
] as const;
const zYLinearIndependenceExpectedInternalDependencies = new Map<string, string[]>([
  ["transfer_matrix_002_claim_Z_Y_linearly_independent", []],
]);
const zYLinearIndependenceExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_001_theorem_tensor_product_basis",
  "transfer_matrix_001_definition_symbols",
].sort();
const zYLinearIndependenceExpectedContentSha256 = new Map<string, string>([
  ["transfer_matrix_002_claim_Z_Y_linearly_independent", "dc3f82ca88ba10cb9112634967abe52d16a45fa1227df98c40b0b32778e5fecb"],
]);
const zYLinearIndependenceExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "d56b2a60243b4307c691d3f908be75e465b5319aa6209405017082a2055eb9c3"],
  ["linear_space_general_001_theorem_tensor_product_basis", "b1d6fa5e021b9be178b745de740fe02f935e6e352a7fb758d4994f2eeb43cbc2"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
]);
const v1V2JordanWignerSectionEntryIds = [
  "transfer_matrix_003_claim_V1_in_Z_Y_epsilon",
  "transfer_matrix_003a_claim_V2_in_Z_Y",
] as const;
const v1V2JordanWignerExpectedInternalDependencies = new Map<string, string[]>([
  ["transfer_matrix_003_claim_V1_in_Z_Y_epsilon", []],
  ["transfer_matrix_003a_claim_V2_in_Z_Y", []],
]);
const v1V2JordanWignerExpectedExternalInputEntryIds = [
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000c_claim_kronecker_multilinear",
  "transfer_matrix_001_definition_symbols",
].sort();
const v1V2JordanWignerExpectedContentSha256 = new Map<string, string>([
  ["transfer_matrix_003_claim_V1_in_Z_Y_epsilon", "81e8943e63a08c66cf386327af850af907b332c366431782bff3f4b1dd7092f2"],
  ["transfer_matrix_003a_claim_V2_in_Z_Y", "fc763130d21136cb0d786867675f31b2cf54912611f737c05b342b7fb60532c2"],
]);
const v1V2JordanWignerExpectedExternalInputContentSha256 = new Map<string, string>([
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "f36fc233fa67016fa14bad33b5625da3eac50932ae426af52afb18674f9ff0dc"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "d56b2a60243b4307c691d3f908be75e465b5319aa6209405017082a2055eb9c3"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "e644e2525aecd17cc1b8c439db76c6c4b94348dd1fe9c63405c5c8b6077f068d"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
]);
const epsilonEigenspacesExpectedDirectDependencies = [
  "calc_formulae_006_definition_of_cc",
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_005_definition_end_isomorphism",
].sort();
const epsilonEigenspacesExpectedContentSha256 = "625aa21f69aa73fcf3e7f955ed87e59306a704737074a15c0acdd7b47fd758e7";
const epsilonEigenspacesAndComplementaryProjectorsSectionEntryIds = [
  "transfer_matrix_004_definition_eigenspaces_of_epsilon",
  "transfer_matrix_004b_claim_epsilon_square_and_eigenvalues",
  "bridge_009_claim_epsilon_projector_properties",
] as const;
const epsilonEigenspacesAndComplementaryProjectorsExpectedInternalDependencies = new Map<string, string[]>([
  ["transfer_matrix_004_definition_eigenspaces_of_epsilon", []],
  ["transfer_matrix_004b_claim_epsilon_square_and_eigenvalues", []],
  ["bridge_009_claim_epsilon_projector_properties", [
    "transfer_matrix_004_definition_eigenspaces_of_epsilon",
    "transfer_matrix_004b_claim_epsilon_square_and_eigenvalues",
  ]],
]);
const epsilonEigenspacesAndComplementaryProjectorsExpectedContentSha256 = new Map<string, string>([
  ["transfer_matrix_004_definition_eigenspaces_of_epsilon", "625aa21f69aa73fcf3e7f955ed87e59306a704737074a15c0acdd7b47fd758e7"],
  ["transfer_matrix_004b_claim_epsilon_square_and_eigenvalues", "70574d82e3eb8756d2c02681bad01f2c23a44a29bbdcbb7488ec62978dbc5e39"],
  ["bridge_009_claim_epsilon_projector_properties", "2f2e4f7f0c04a1e0ece43bba53e0d13ef242f7110768e9dd2315a28d6c33d32e"],
]);
const epsilonEigenspacesAndComplementaryProjectorsExpectedExternalInputEntryIds = [
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "bridge_008_definition_epsilon_projectors",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_005_definition_end_isomorphism",
  "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
].sort();
const epsilonEigenspacesAndComplementaryProjectorsExpectedExternalInputContentSha256 = new Map<string, string>([
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "f36fc233fa67016fa14bad33b5625da3eac50932ae426af52afb18674f9ff0dc"],
  ["bridge_008_definition_epsilon_projectors", "be5003446b4cb92b2911fb88cee1a7cc85dd13f412c3207866e1f70d987c4890"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "d56b2a60243b4307c691d3f908be75e465b5319aa6209405017082a2055eb9c3"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
  ["transfer_matrix_005_definition_end_isomorphism", "651f3dbd8a1ace2d2c641c9424fb4148011370c9100f9887ab06b9696e18d52a"],
  ["transfer_matrix_005b_claim_end_is_algebra_isomorphism", "1a9ecef9cd59f12d82071b4c248e4319f7c9be8e3f42cf1bc9289737d9e5d033"],
]);
const v1RestrictionToEigenspacesExpectedDirectDependencies = [
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_003_claim_V1_in_Z_Y_epsilon",
  "transfer_matrix_004_definition_eigenspaces_of_epsilon",
  "transfer_matrix_005_definition_end_isomorphism",
  "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
  "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
].sort();
const v1RestrictionToEigenspacesExpectedContentSha256 = "04537e46af040d8bc078042cdfe8f5e0592a48e3632c90e8a94ce038db90f8e6";
const v1RestrictionToEigenspacesSectionEntryIds = [
  "transfer_matrix_006_claim_V1_restriction_to_eigenspaces",
] as const;
const v1RestrictionToEigenspacesExpectedInternalDependencies = new Map<string, string[]>([
  ["transfer_matrix_006_claim_V1_restriction_to_eigenspaces", []],
]);
const v1RestrictionToEigenspacesSectionExpectedContentSha256 = new Map<string, string>([
  ["transfer_matrix_006_claim_V1_restriction_to_eigenspaces", v1RestrictionToEigenspacesExpectedContentSha256],
]);
const v1RestrictionToEigenspacesExpectedExternalInputContentSha256 = new Map<string, string>([
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "f36fc233fa67016fa14bad33b5625da3eac50932ae426af52afb18674f9ff0dc"],
  ["Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site", "95d5468bee33981a077bfcd1c67e1bfc7eb0f5e11007fcb3602ef07137ba9343"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["linear_space_general_002c_claim_matrix_norm_triangle_inequality", "66177abbef1f6ea86dba8b3e62b43da74b9e257d0909ed7eeee9d75aa4cac141"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
  ["transfer_matrix_003_claim_V1_in_Z_Y_epsilon", "81e8943e63a08c66cf386327af850af907b332c366431782bff3f4b1dd7092f2"],
  ["transfer_matrix_004_definition_eigenspaces_of_epsilon", "625aa21f69aa73fcf3e7f955ed87e59306a704737074a15c0acdd7b47fd758e7"],
  ["transfer_matrix_005_definition_end_isomorphism", "651f3dbd8a1ace2d2c641c9424fb4148011370c9100f9887ab06b9696e18d52a"],
  ["transfer_matrix_005b_claim_end_is_algebra_isomorphism", "1a9ecef9cd59f12d82071b4c248e4319f7c9be8e3f42cf1bc9289737d9e5d033"],
  ["transfer_matrix_005c_claim_end_preserves_matrix_exponential", "6b163e3b366800fd0dcda4eec827fa428e8721922ff5b3e064127c321b4d62c0"],
]);
const v1PlusMinusDefinitionExpectedDirectDependencies = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_005_definition_end_isomorphism",
].sort();
const v1PlusMinusDefinitionExpectedContentSha256 = "7a63f3a02db439552636cb7cd8ac32f348c82f85830614ed5fc94c80b3698264";
const v1PlusMinusAndCommutationSectionEntryIds = [
  "transfer_matrix_007_definition_V1_pm",
  "bridge_011_claim_sector_replacement",
  "bridge_definition_V1_pm_square_root",
  "bridge_claim_V1_pm_square_root_squares_to_V1_pm",
  "bridge_010_claim_epsilon_commutes",
  "bridge_claim_epsilon_projectors_commute_with_transfer_matrices",
  "bridge_011a_claim_sector_replacement_pow",
] as const;
const v1PlusMinusAndCommutationExpectedInternalDependencies = new Map<string, string[]>([
  ["transfer_matrix_007_definition_V1_pm", []],
  ["bridge_011_claim_sector_replacement", ["transfer_matrix_007_definition_V1_pm"]],
  ["bridge_definition_V1_pm_square_root", ["transfer_matrix_007_definition_V1_pm"]],
  ["bridge_claim_V1_pm_square_root_squares_to_V1_pm", [
    "bridge_definition_V1_pm_square_root",
    "transfer_matrix_007_definition_V1_pm",
  ]],
  ["bridge_010_claim_epsilon_commutes", [
    "bridge_claim_V1_pm_square_root_squares_to_V1_pm",
    "bridge_definition_V1_pm_square_root",
    "transfer_matrix_007_definition_V1_pm",
  ]],
  ["bridge_claim_epsilon_projectors_commute_with_transfer_matrices", [
    "bridge_010_claim_epsilon_commutes",
  ]],
  ["bridge_011a_claim_sector_replacement_pow", [
    "bridge_011_claim_sector_replacement",
    "bridge_claim_epsilon_projectors_commute_with_transfer_matrices",
  ]],
]);
const v1PlusMinusAndCommutationExpectedContentSha256 = new Map<string, string>([
  ["transfer_matrix_007_definition_V1_pm", v1PlusMinusDefinitionExpectedContentSha256],
  ["bridge_011_claim_sector_replacement", "22e55749ba4656531b76fa8dd94ffd561987a5537942905fe78f36b4046b2526"],
  ["bridge_definition_V1_pm_square_root", "853921ca298ee54b1cbc3b4113a9bb0824da3628442cc110f3a7eb70eba1e3f9"],
  ["bridge_claim_V1_pm_square_root_squares_to_V1_pm", "7fc048a304dd7c7657258b64b2aba856fb94cc7d224964cb358b5b576da54208"],
  ["bridge_010_claim_epsilon_commutes", "225512460e5993591f6025bf01e9757753f1b3fc7d65cb02bfd86ee5a82a1735"],
  ["bridge_claim_epsilon_projectors_commute_with_transfer_matrices", "3a54ef3eed72f2c5e6faa7829ee5f919ad976d117881ce7007b7e48cdd52785e"],
  ["bridge_011a_claim_sector_replacement_pow", "16465849b26c8c71caa298b300f2bf424283513092691f4c3abeafb79c134974"],
]);
const v1PlusMinusAndCommutationExpectedExternalInputEntryIds = [
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "bridge_008_definition_epsilon_projectors",
  "bridge_009_claim_epsilon_projector_properties",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_002_claim_scalar_identity_commutes",
  "linear_space_general_003b_claim_matrix_multiplication_continuity",
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_005_definition_end_isomorphism",
  "transfer_matrix_006_claim_V1_restriction_to_eigenspaces",
].sort();
const v1PlusMinusAndCommutationExpectedExternalInputContentSha256 = new Map<string, string>([
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "f36fc233fa67016fa14bad33b5625da3eac50932ae426af52afb18674f9ff0dc"],
  ["bridge_008_definition_epsilon_projectors", "be5003446b4cb92b2911fb88cee1a7cc85dd13f412c3207866e1f70d987c4890"],
  ["bridge_009_claim_epsilon_projector_properties", "2f2e4f7f0c04a1e0ece43bba53e0d13ef242f7110768e9dd2315a28d6c33d32e"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["exp_linear_map_002_definition_exp_of_endomorphism", "6d1e05adbfc624b89b429dda12fd2afb5818d6a62fa9f18d3801a2bca1506098"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "de25a7cfd8a1fd81d0d86ca48b4d3a85550853b4857925dd6768c842c31cdeb0"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "d56b2a60243b4307c691d3f908be75e465b5319aa6209405017082a2055eb9c3"],
  ["linear_space_general_002_claim_scalar_identity_commutes", "f8f5ddafc9ff868ec1ace87dae5f992b09aacc9063d84f3f432c8b3273ba873e"],
  ["linear_space_general_003b_claim_matrix_multiplication_continuity", "38ea4eead984a8a947b23553e9fec695419a772f872d64c4894ae08116ccbaf8"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
  ["transfer_matrix_005_definition_end_isomorphism", "651f3dbd8a1ace2d2c641c9424fb4148011370c9100f9887ab06b9696e18d52a"],
  ["transfer_matrix_006_claim_V1_restriction_to_eigenspaces", "04537e46af040d8bc078042cdfe8f5e0592a48e3632c90e8a94ce038db90f8e6"],
]);
const sectorReplacementExpectedDirectDependencies = [
  "bridge_009_claim_epsilon_projector_properties",
  "calc_formulae_006_definition_of_cc",
  "transfer_matrix_005_definition_end_isomorphism",
  "transfer_matrix_006_claim_V1_restriction_to_eigenspaces",
  "transfer_matrix_007_definition_V1_pm",
].sort();
const sectorReplacementExpectedContentSha256 = "22e55749ba4656531b76fa8dd94ffd561987a5537942905fe78f36b4046b2526";
const realSymmetricGeneratorsExpectedDirectDependencies = [
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "eigenvalues_of_V_011_definition_hermitian_positive_definite",
  "linear_space_general_000_definition_kronecker_product",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000d_claim_kronecker_transpose",
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_007_definition_V1_pm",
  "transfer_matrix_011_definition_H1_H2",
].sort();
const realSymmetricGeneratorsExpectedContentSha256 = "58f128326d7105d0494ee2849438389cb2a90991f8d960809e161001bd22e89d";
const realSymmetricGeneratorsAndSignFlipSectionEntryIds = [
  "eigenvalues_of_V_014_claim_iH_is_real_symmetric",
  "eigenvalues_of_V_016_claim_sign_flip_conjugation",
] as const;
const realSymmetricGeneratorsAndSignFlipExpectedInternalDependencies = new Map<string, string[]>([
  ["eigenvalues_of_V_014_claim_iH_is_real_symmetric", []],
  ["eigenvalues_of_V_016_claim_sign_flip_conjugation", [
    "eigenvalues_of_V_014_claim_iH_is_real_symmetric",
  ]],
]);
const realSymmetricGeneratorsAndSignFlipExpectedContentSha256 = new Map<string, string>([
  ["eigenvalues_of_V_014_claim_iH_is_real_symmetric", realSymmetricGeneratorsExpectedContentSha256],
  ["eigenvalues_of_V_016_claim_sign_flip_conjugation", "bf0cc5752d2a2ff61c7528355e825e7a2f1be3a0a7f5d21d43928553fc3bfe64"],
]);
const signFlipConjugationExpectedDirectDependencies = [
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "eigenvalues_of_V_014_claim_iH_is_real_symmetric",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_007_definition_V1_pm",
  "transfer_matrix_011_definition_H1_H2",
].sort();
const realSymmetricGeneratorsAndSignFlipExpectedExternalInputEntryIds = [
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "eigenvalues_of_V_011_definition_hermitian_positive_definite",
  "linear_space_general_000_definition_kronecker_product",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000d_claim_kronecker_transpose",
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_007_definition_V1_pm",
  "transfer_matrix_011_definition_H1_H2",
].sort();
const realSymmetricGeneratorsAndSignFlipExpectedExternalInputContentSha256 = new Map<string, string>([
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "f36fc233fa67016fa14bad33b5625da3eac50932ae426af52afb18674f9ff0dc"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["eigenvalues_of_V_011_definition_hermitian_positive_definite", "d0d5706bfc9866ba851d979c14387aa1c99cf67bdf434f453699a1fa91d4f22c"],
  ["linear_space_general_000_definition_kronecker_product", "d67144d5a2fc061d370a8a29846c5cdb963a1b6ce42b0f6b08daee519364bc40"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "d56b2a60243b4307c691d3f908be75e465b5319aa6209405017082a2055eb9c3"],
  ["linear_space_general_000d_claim_kronecker_transpose", "c0014341f8b8968f27acf4793018d15312e7313acad2dccadd439617703c4cd4"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
  ["transfer_matrix_007_definition_V1_pm", "7a63f3a02db439552636cb7cd8ac32f348c82f85830614ed5fc94c80b3698264"],
  ["transfer_matrix_011_definition_H1_H2", "19baa8255a664202439efe07a7c18f770902aa68a0d3ce553a650712c8a23413"],
]);
const evenSectorGeneratorSectionEntryIds = [
  "evensectorT_definition_H1_plus",
  "closing_definition_D0_open_chain_operator",
  "closing_definition_G_boundary_operator",
  "closing_004_claim_H1_plus_in_sigma_z_form",
  "closing_claim_D0_G_diagonal_action",
  "closing_claim_epsilon_D0_G_pairwise_commute",
  "closing_claim_epsilon_G_is_involution",
];
const evenSectorGeneratorExpectedInternalDependencies = new Map<string, string[]>([
  ["evensectorT_definition_H1_plus", []],
  ["closing_definition_D0_open_chain_operator", []],
  ["closing_definition_G_boundary_operator", []],
  ["closing_004_claim_H1_plus_in_sigma_z_form", [
    "closing_definition_D0_open_chain_operator",
    "closing_definition_G_boundary_operator",
    "evensectorT_definition_H1_plus",
  ]],
  ["closing_claim_D0_G_diagonal_action", [
    "closing_definition_D0_open_chain_operator",
    "closing_definition_G_boundary_operator",
  ]],
  ["closing_claim_epsilon_D0_G_pairwise_commute", [
    "closing_definition_D0_open_chain_operator",
    "closing_definition_G_boundary_operator",
  ]],
  ["closing_claim_epsilon_G_is_involution", [
    "closing_definition_G_boundary_operator",
    "closing_claim_epsilon_D0_G_pairwise_commute",
  ]],
]);
const evenSectorGeneratorExpectedContentSha256 = new Map<string, string>([
  ["evensectorT_definition_H1_plus", "fff8d040f78e719bed462ae839eed9542927f1ae1f0e76c854a28333215ef6be"],
  ["closing_definition_D0_open_chain_operator", "b8dfa77a5b2a5ba4e505e614623f3f6ae1dcf44c6e9838b3c4bbe2f130ad42a4"],
  ["closing_definition_G_boundary_operator", "4705a5620e827e2607b1331c0eb24030b96fc0fd668ce9a405fa55dbdd009d22"],
  ["closing_004_claim_H1_plus_in_sigma_z_form", "df178854a0b0ce220da19a1eb0311b2eb72ed64947d617ef661c418d262323f6"],
  ["closing_claim_D0_G_diagonal_action", "12905cb05af762c01ca2a4f2806fce4b410fbacf1ce911a9379ea0ced226980c"],
  ["closing_claim_epsilon_D0_G_pairwise_commute", "54783919677061229c561142a92459a128bc9cc6e25ba1db0a1e1adde2bed343"],
  ["closing_claim_epsilon_G_is_involution", "3abbe537ba7e33208c63d767d66918eb8dd03ec8acc5fda3aea31fa82078bb9a"],
]);
const evenSectorGeneratorExpectedDirectDependencies = new Map<string, string[]>([
  ["evensectorT_definition_H1_plus", [
    "transfer_matrix_011_definition_H1_H2",
  ]],
  ["closing_definition_D0_open_chain_operator", [
    "calculation_formulae_definition_set_and_algebra_notation",
    "transfer_matrix_001_definition_symbols",
  ]],
  ["closing_definition_G_boundary_operator", [
    "calculation_formulae_definition_set_and_algebra_notation",
    "transfer_matrix_001_definition_symbols",
  ]],
  ["closing_004_claim_H1_plus_in_sigma_z_form", [
    "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
    "calc_formulae_003_matrix_decomposition",
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation",
    "closing_definition_D0_open_chain_operator",
    "closing_definition_G_boundary_operator",
    "evensectorT_definition_H1_plus",
    "linear_space_general_000b_claim_kronecker_product_rule",
    "transfer_matrix_001_definition_symbols",
    "transfer_matrix_003_claim_V1_in_Z_Y_epsilon",
    "transfer_matrix_011_definition_H1_H2",
  ]],
  ["closing_claim_D0_G_diagonal_action", [
    "bridge_001_definition_config_basis",
    "bridge_002_claim_sigma_z_diagonal_action",
    "closing_definition_D0_open_chain_operator",
    "closing_definition_G_boundary_operator",
  ]],
  ["closing_claim_epsilon_D0_G_pairwise_commute", [
    "bridge_010_claim_epsilon_commutes",
    "closing_definition_D0_open_chain_operator",
    "closing_definition_G_boundary_operator",
    "linear_space_general_000b_claim_kronecker_product_rule",
  ]],
  ["closing_claim_epsilon_G_is_involution", [
    "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
    "bridge_009_claim_epsilon_projector_properties",
    "closing_claim_epsilon_D0_G_pairwise_commute",
    "closing_definition_G_boundary_operator",
    "linear_space_general_000b_claim_kronecker_product_rule",
  ]],
]);
const evenSectorGeneratorExpectedExternalInputEntryIds = [
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "bridge_001_definition_config_basis",
  "bridge_002_claim_sigma_z_diagonal_action",
  "bridge_009_claim_epsilon_projector_properties",
  "bridge_010_claim_epsilon_commutes",
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_003_claim_V1_in_Z_Y_epsilon",
  "transfer_matrix_011_definition_H1_H2",
].sort();
const evenSectorGeneratorExpectedExternalInputContentSha256 = new Map<string, string>([
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "f36fc233fa67016fa14bad33b5625da3eac50932ae426af52afb18674f9ff0dc"],
  ["bridge_001_definition_config_basis", "c29559e9454e9cb5483e5bd1a1f852995a0904aab977f59d0e209bdbcd28297d"],
  ["bridge_002_claim_sigma_z_diagonal_action", "13002ebb9535f89209c2ebfa23358a0f95c1c1b2e7bcb24a08c2b00b87a10232"],
  ["bridge_009_claim_epsilon_projector_properties", "2f2e4f7f0c04a1e0ece43bba53e0d13ef242f7110768e9dd2315a28d6c33d32e"],
  ["bridge_010_claim_epsilon_commutes", "225512460e5993591f6025bf01e9757753f1b3fc7d65cb02bfd86ee5a82a1735"],
  ["calc_formulae_003_matrix_decomposition", "a97a47798c1376adfb7b1536fdbb7d39f2a0953080fdf0177149de1f7ba89200"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "d56b2a60243b4307c691d3f908be75e465b5319aa6209405017082a2055eb9c3"],
  ["partition_function_2d_ising_003_definition_transfer_matrix", "48b09c189776f6550beac7306cbb8ee033259dfc84221059a44ed3c5672f607d"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
  ["transfer_matrix_003_claim_V1_in_Z_Y_epsilon", "81e8943e63a08c66cf386327af850af907b332c366431782bff3f4b1dd7092f2"],
  ["transfer_matrix_011_definition_H1_H2", "19baa8255a664202439efe07a7c18f770902aa68a0d3ce553a650712c8a23413"],
]);
const v1PlusSquareRootDefinitionExpectedDirectDependencies = [
  "calc_formulae_006_definition_of_cc",
  "evensectorT_definition_H1_plus",
  "transfer_matrix_011_definition_H1_H2",
].sort();
const v1PlusSquareRootDefinitionExpectedContentSha256 = "33659011599514363340a770866a6757ab8b49d6b7259f1c8fc777da7aea773a";
const v1PlusHalfExponentAndSquareRootSectionEntryIds = [
  "evensectorT_definition_V1_plus_square_root",
  "evensectorT_claim_V1_plus_square_root",
];
const v1PlusHalfExponentAndSquareRootExpectedInternalDependencies = new Map<string, string[]>([
  ["evensectorT_definition_V1_plus_square_root", []],
  ["evensectorT_claim_V1_plus_square_root", [
    "evensectorT_definition_V1_plus_square_root",
  ]],
]);
const v1PlusHalfExponentAndSquareRootExpectedContentSha256 = new Map<string, string>([
  ["evensectorT_definition_V1_plus_square_root", "33659011599514363340a770866a6757ab8b49d6b7259f1c8fc777da7aea773a"],
  ["evensectorT_claim_V1_plus_square_root", "351a0b91806367f7c9509c7a852a8315242a25ae34e763e00848b3bdff78a620"],
]);
const v1PlusHalfExponentAndSquareRootExpectedDirectDependencies = new Map<string, string[]>([
  ["evensectorT_definition_V1_plus_square_root", [
    "calc_formulae_006_definition_of_cc",
    "evensectorT_definition_H1_plus",
    "transfer_matrix_011_definition_H1_H2",
  ]],
  ["evensectorT_claim_V1_plus_square_root", [
    "evensectorT_definition_V1_plus_square_root",
    "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
    "transfer_matrix_007_definition_V1_pm",
    "transfer_matrix_011_definition_H1_H2",
  ]],
]);
const v1PlusHalfExponentAndSquareRootExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "evensectorT_definition_H1_plus",
  "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
  "transfer_matrix_007_definition_V1_pm",
  "transfer_matrix_011_definition_H1_H2",
].sort();
const v1PlusHalfExponentAndSquareRootExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["evensectorT_definition_H1_plus", "fff8d040f78e719bed462ae839eed9542927f1ae1f0e76c854a28333215ef6be"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "de25a7cfd8a1fd81d0d86ca48b4d3a85550853b4857925dd6768c842c31cdeb0"],
  ["transfer_matrix_007_definition_V1_pm", "7a63f3a02db439552636cb7cd8ac32f348c82f85830614ed5fc94c80b3698264"],
  ["transfer_matrix_011_definition_H1_H2", "19baa8255a664202439efe07a7c18f770902aa68a0d3ce553a650712c8a23413"],
]);
const vPlusDefinitionExpectedDirectDependencies = [
  "calc_formulae_006_definition_of_cc",
  "evensectorT_definition_V1_plus_square_root",
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_011_definition_H1_H2",
].sort();
const vPlusDefinitionExpectedContentSha256 = "25224f1a0789bbff2c99b11323319f0e297bd6a0f68c213757097e35957e37ef";
const vPlusDefinitionAndSignedTraceSectionEntryIds = [
  "evensectorT_definition_V_plus",
  "closing_006_theorem_trace_of_epsilon_V_plus",
];
const vPlusDefinitionAndSignedTraceExpectedInternalDependencies = new Map<string, string[]>([
  ["evensectorT_definition_V_plus", []],
  ["closing_006_theorem_trace_of_epsilon_V_plus", ["evensectorT_definition_V_plus"]],
]);
const vPlusDefinitionAndSignedTraceExpectedDirectDependencies = new Map<string, string[]>([
  ["evensectorT_definition_V_plus", [
    "calc_formulae_006_definition_of_cc",
    "evensectorT_definition_V1_plus_square_root",
    "transfer_matrix_001_definition_symbols",
    "transfer_matrix_011_definition_H1_H2",
  ]],
  ["closing_006_theorem_trace_of_epsilon_V_plus", [
    "bridge_001_definition_config_basis",
    "bridge_003_claim_exp_of_diagonal",
    "bridge_006_claim_V2_component_equals_pauli",
    "bridge_010_claim_epsilon_commutes",
    "calc_formulae_000b_claim_cosh_sinh_basic_properties",
    "calculation_formulae_definition_set_and_algebra_notation",
    "closing_004_claim_H1_plus_in_sigma_z_form",
    "closing_005_claim_open_chain_endpoint_product_sum",
    "closing_005_claim_open_chain_partition_sum",
    "closing_005_claim_open_chain_spin_sums_positive",
    "closing_005_definition_open_chain_spin_energy",
    "closing_claim_D0_G_diagonal_action",
    "closing_claim_epsilon_D0_G_pairwise_commute",
    "closing_claim_epsilon_G_is_involution",
    "closing_definition_D0_open_chain_operator",
    "closing_definition_G_boundary_operator",
    "eigenvalues_of_V_001_definition_trace",
    "eigenvalues_of_V_002_claim_trace_properties",
    "evensectorT_definition_V1_plus_square_root",
    "evensectorT_definition_V_plus",
    "exp_linear_map_000a_claim_real_exp_series_converges",
    "exp_linear_map_002_definition_exp_of_endomorphism",
    "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
    "linear_space_general_000b_claim_kronecker_product_rule",
    "transfer_matrix_005_definition_end_isomorphism",
    "transfer_matrix_007_definition_V1_pm",
    "transfer_matrix_011_definition_H1_H2",
  ]],
]);
const vPlusDefinitionAndSignedTraceExpectedContentSha256 = new Map<string, string>([
  ["evensectorT_definition_V_plus", "25224f1a0789bbff2c99b11323319f0e297bd6a0f68c213757097e35957e37ef"],
  ["closing_006_theorem_trace_of_epsilon_V_plus", "1e71fb721f1c97af47e60f7af81da4eb589153e70103b992205dac9baaebd81e"],
]);
const vPlusDefinitionAndSignedTraceExpectedExternalInputEntryIds = [
  "bridge_001_definition_config_basis",
  "bridge_003_claim_exp_of_diagonal",
  "bridge_006_claim_V2_component_equals_pauli",
  "bridge_010_claim_epsilon_commutes",
  "calc_formulae_000b_claim_cosh_sinh_basic_properties",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "closing_004_claim_H1_plus_in_sigma_z_form",
  "closing_005_claim_open_chain_endpoint_product_sum",
  "closing_005_claim_open_chain_partition_sum",
  "closing_005_claim_open_chain_spin_sums_positive",
  "closing_005_definition_open_chain_spin_energy",
  "closing_claim_D0_G_diagonal_action",
  "closing_claim_epsilon_D0_G_pairwise_commute",
  "closing_claim_epsilon_G_is_involution",
  "closing_definition_D0_open_chain_operator",
  "closing_definition_G_boundary_operator",
  "eigenvalues_of_V_001_definition_trace",
  "eigenvalues_of_V_002_claim_trace_properties",
  "evensectorT_definition_V1_plus_square_root",
  "exp_linear_map_000a_claim_real_exp_series_converges",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_005_definition_end_isomorphism",
  "transfer_matrix_007_definition_V1_pm",
  "transfer_matrix_011_definition_H1_H2",
].sort();
const vPlusDefinitionAndSignedTraceExpectedExternalInputContentSha256 = new Map<string, string>([
  ["bridge_001_definition_config_basis", "c29559e9454e9cb5483e5bd1a1f852995a0904aab977f59d0e209bdbcd28297d"],
  ["bridge_003_claim_exp_of_diagonal", "5113d388b0ec40f7d2e0a87983fe995b358171afa75fda040decfd1c98460747"],
  ["bridge_006_claim_V2_component_equals_pauli", "02f2eb834d7e16abf67232ac9a868ee14eec22cf56c1a5a34294d71ec51f65c1"],
  ["bridge_010_claim_epsilon_commutes", "225512460e5993591f6025bf01e9757753f1b3fc7d65cb02bfd86ee5a82a1735"],
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", "2527bb859515783eeeb40add04aa0f13c62f4d9994e2a3437db5fd501ef40aed"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["closing_004_claim_H1_plus_in_sigma_z_form", "df178854a0b0ce220da19a1eb0311b2eb72ed64947d617ef661c418d262323f6"],
  ["closing_005_claim_open_chain_endpoint_product_sum", "002ddb1410f5983a61e4df1c0cf886c47a43ca9825c9dc2563aa9bda84029d89"],
  ["closing_005_claim_open_chain_partition_sum", "97a1758b41d17a52343ba1188eecf112d46ba48112797988021d8d20669a19fc"],
  ["closing_005_claim_open_chain_spin_sums_positive", "c7a0451efa605dd17821efc7a433df7f151dee481ae5c7bb88f3003e2356da9b"],
  ["closing_005_definition_open_chain_spin_energy", "2062fa60483069fd13042b3bf943fdfaf32a14ae598f523f41b8b97380cc8f8d"],
  ["closing_claim_D0_G_diagonal_action", "12905cb05af762c01ca2a4f2806fce4b410fbacf1ce911a9379ea0ced226980c"],
  ["closing_claim_epsilon_D0_G_pairwise_commute", "54783919677061229c561142a92459a128bc9cc6e25ba1db0a1e1adde2bed343"],
  ["closing_claim_epsilon_G_is_involution", "3abbe537ba7e33208c63d767d66918eb8dd03ec8acc5fda3aea31fa82078bb9a"],
  ["closing_definition_D0_open_chain_operator", "b8dfa77a5b2a5ba4e505e614623f3f6ae1dcf44c6e9838b3c4bbe2f130ad42a4"],
  ["closing_definition_G_boundary_operator", "4705a5620e827e2607b1331c0eb24030b96fc0fd668ce9a405fa55dbdd009d22"],
  ["eigenvalues_of_V_001_definition_trace", "35ae403d96746496fb0fdaa59d0122e38c3fc5129338230666507cb62c07a73d"],
  ["eigenvalues_of_V_002_claim_trace_properties", "60f5d19acef69e141508635a57c36920bef3d1fdd9f2813bb30cb92ca808105a"],
  ["evensectorT_definition_V1_plus_square_root", "33659011599514363340a770866a6757ab8b49d6b7259f1c8fc777da7aea773a"],
  ["exp_linear_map_000a_claim_real_exp_series_converges", "1065e4f465b1b0b49eae7d16f9d734421f472beec053c3effaff63127eecf077"],
  ["exp_linear_map_002_definition_exp_of_endomorphism", "6d1e05adbfc624b89b429dda12fd2afb5818d6a62fa9f18d3801a2bca1506098"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "de25a7cfd8a1fd81d0d86ca48b4d3a85550853b4857925dd6768c842c31cdeb0"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "d56b2a60243b4307c691d3f908be75e465b5319aa6209405017082a2055eb9c3"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
  ["transfer_matrix_005_definition_end_isomorphism", "651f3dbd8a1ace2d2c641c9424fb4148011370c9100f9887ab06b9696e18d52a"],
  ["transfer_matrix_007_definition_V1_pm", "7a63f3a02db439552636cb7cd8ac32f348c82f85830614ed5fc94c80b3698264"],
  ["transfer_matrix_011_definition_H1_H2", "19baa8255a664202439efe07a7c18f770902aa68a0d3ce553a650712c8a23413"],
]);
const vPlusPositiveDefiniteExpectedDirectDependencies = [
  "calculation_formulae_definition_set_and_algebra_notation",
  "eigenvalues_of_V_011_definition_hermitian_positive_definite",
  "eigenvalues_of_V_013_claim_exp_hermitian_positive_definite",
  "eigenvalues_of_V_014_claim_iH_is_real_symmetric",
  "evensectorT_definition_V1_plus_square_root",
  "evensectorT_definition_V_plus",
  "linear_space_general_002_claim_scalar_identity_commutes",
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_011_definition_H1_H2",
].sort();
const vPlusPositiveDefiniteSectionEntryIds = [
  "evenEigen_008_claim_V_plus_is_positive_definite",
  "evenEigen_claim_trace_V_plus_is_positive",
  "evenEigen_claim_V_plus_is_invertible",
  "evenEigen_claim_V_plus_inverse_is_positive_definite",
  "evenEigen_claim_V_plus_inverse_positive_and_traces",
] as const;
const vPlusPositiveDefiniteExpectedInternalDependencies = new Map<string, string[]>([
  ["evenEigen_008_claim_V_plus_is_positive_definite", []],
  ["evenEigen_claim_V_plus_is_invertible", [
    "evenEigen_008_claim_V_plus_is_positive_definite",
  ]],
  ["evenEigen_claim_V_plus_inverse_is_positive_definite", [
    "evenEigen_claim_V_plus_is_invertible",
  ]],
  ["evenEigen_claim_trace_V_plus_is_positive", [
    "evenEigen_008_claim_V_plus_is_positive_definite",
  ]],
  ["evenEigen_claim_V_plus_inverse_positive_and_traces", [
    "evenEigen_claim_V_plus_inverse_is_positive_definite",
  ]],
]);
const vPlusPositiveDefiniteSectionExpectedContentSha256 = new Map<string, string>([
  ["evenEigen_008_claim_V_plus_is_positive_definite", "f24523708646634691ca594190862d9add2ea1adfd52be33b462cc66916628f0"],
  ["evenEigen_claim_V_plus_is_invertible", "63efd7b51b2689f7c7d312b4644fa72aa684f300e7164e22d085dee321a5dfb9"],
  ["evenEigen_claim_V_plus_inverse_is_positive_definite", "995a4de95a94e24eaf8ae55a5bfe37fe36fc3fa2acd1bf61616fbf245d56f265"],
  ["evenEigen_claim_trace_V_plus_is_positive", "e02ed47f8435891a859218fd452aebc1d91aae9d3c4bb6899a8b77768287be9e"],
  ["evenEigen_claim_V_plus_inverse_positive_and_traces", "892ca93b26b7c0a51504cd8dfeebae20c79f97e9a906ff24772b5218e3ea316f"],
]);
const vPlusPositiveDefiniteExpectedContentSha256 =
  vPlusPositiveDefiniteSectionExpectedContentSha256.get("evenEigen_008_claim_V_plus_is_positive_definite")!;
const vPlusPositiveDefiniteExpectedExternalInputEntryIds = [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "eigenvalues_of_V_011_definition_hermitian_positive_definite",
  "eigenvalues_of_V_013_claim_exp_hermitian_positive_definite",
  "eigenvalues_of_V_014_claim_iH_is_real_symmetric",
  "evensectorT_definition_V1_plus_square_root",
  "evensectorT_definition_V_plus",
  "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
  "exp_linear_map_004_theorem_exp_zero_is_identity",
  "linear_space_general_002_claim_scalar_identity_commutes",
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_011_definition_H1_H2",
].sort();
const vPlusPositiveDefiniteExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["eigenvalues_of_V_011_definition_hermitian_positive_definite", "d0d5706bfc9866ba851d979c14387aa1c99cf67bdf434f453699a1fa91d4f22c"],
  ["eigenvalues_of_V_013_claim_exp_hermitian_positive_definite", "1db946266e8e182faa5d239bcfa5b571c33fc3a776577343cf44a02f060a7db3"],
  ["eigenvalues_of_V_014_claim_iH_is_real_symmetric", "58f128326d7105d0494ee2849438389cb2a90991f8d960809e161001bd22e89d"],
  ["evensectorT_definition_V1_plus_square_root", "33659011599514363340a770866a6757ab8b49d6b7259f1c8fc777da7aea773a"],
  ["evensectorT_definition_V_plus", "25224f1a0789bbff2c99b11323319f0e297bd6a0f68c213757097e35957e37ef"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "de25a7cfd8a1fd81d0d86ca48b4d3a85550853b4857925dd6768c842c31cdeb0"],
  ["exp_linear_map_004_theorem_exp_zero_is_identity", "cd6f641666073a7e118dfad89898575b72fab87fe804f5e45cc4ec71fd28bf49"],
  ["linear_space_general_002_claim_scalar_identity_commutes", "f8f5ddafc9ff868ec1ace87dae5f992b09aacc9063d84f3f432c8b3273ba873e"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
  ["transfer_matrix_011_definition_H1_H2", "19baa8255a664202439efe07a7c18f770902aa68a0d3ce553a650712c8a23413"],
]);
const vPlusPositiveDefiniteBoundaryCandidates = [] as const;
const vPlusPositiveDefiniteExpectedBoundaryCandidates = [] as const;
const vPlusPositiveDefiniteNextTickUnit = vPlusPositiveDefiniteBoundaryCandidates.slice(0, 1);
const vPlusPositiveDefiniteExpectedNextTickUnit = [] as const;
if (JSON.stringify(vPlusPositiveDefiniteBoundaryCandidates)
    !== JSON.stringify(vPlusPositiveDefiniteExpectedBoundaryCandidates)
  || JSON.stringify(vPlusPositiveDefiniteNextTickUnit)
    !== JSON.stringify(vPlusPositiveDefiniteExpectedNextTickUnit)) {
  throw new Error("偶セクター転送行列の正定値性の境界候補または次回一項単位が変わりました");
}
const vPlusPositiveDefiniteLeanFile = "lean/Ising2D/Part017/Claim008_VPlusPositiveDefinite.lean";
const vPlusPositiveDefiniteSageMathFile =
  "sagemath/check/050_claim_even_sector_eigenvalues/check_05_positive_definite_and_c.sage";
const vPlusRightInverseSageMathFile =
  "sagemath/check/050_claim_even_sector_eigenvalues/check_07_V_plus_mul_inverse.sage";
const vPlusLeftInverseSageMathFile =
  "sagemath/check/050_claim_even_sector_eigenvalues/check_08_inverse_mul_V_plus.sage";
const vPlusInversePositiveDefiniteSageMathFile =
  "sagemath/check/050_claim_even_sector_eigenvalues/check_V_plus_inverse_positive_definite.sage";
const vPlusPositiveDefiniteLeanSource = readFileSync(join(projectDir, vPlusPositiveDefiniteLeanFile), "utf8");
const vPlusPositiveDefiniteSageMathSource = readFileSync(
  join(projectDir, vPlusPositiveDefiniteSageMathFile),
  "utf8",
);
const vPlusRightInverseSageMathSource = readFileSync(
  join(projectDir, vPlusRightInverseSageMathFile),
  "utf8",
);
const vPlusLeftInverseSageMathSource = readFileSync(
  join(projectDir, vPlusLeftInverseSageMathFile),
  "utf8",
);
const vPlusInversePositiveDefiniteSageMathSource = readFileSync(
  join(projectDir, vPlusInversePositiveDefiniteSageMathFile),
  "utf8",
);
const vPlusPositiveDefiniteExpectedLeanDeclarationFragments = new Map<string, string>([
  ["VPlusInv", `noncomputable def VPlusInv (M : ℕ) (K1 : ℂ) (s2 : ℝ) (K2star : ℂ) : TensorPow M :=
  VmatInv M K1 (-1) s2 K2star`],
  ["VPlus_posDef", `theorem VPlus_posDef {K1 K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    (VPlus M s2 K1 K2star).PosDef :=`],
  ["VPlus_mul_VPlusInv", `theorem VPlus_mul_VPlusInv {K1 K2star : ℂ} {s2 : ℝ} (hs2 : 0 < s2) :
    VPlus M s2 K1 K2star * VPlusInv M K1 s2 K2star = 1 :=`],
  ["VPlusInv_mul_VPlus", `theorem VPlusInv_mul_VPlus {K1 K2star : ℂ} {s2 : ℝ} (hs2 : 0 < s2) :
    VPlusInv M K1 s2 K2star * VPlus M s2 K1 K2star = 1 :=`],
  ["VPlusInv_posDef", `theorem VPlusInv_posDef {K1 K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    (VPlusInv M K1 s2 K2star).PosDef :=`],
  ["trace_VPlus_pos", `theorem trace_VPlus_pos {K1 K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    0 < (VPlus M s2 K1 K2star).trace :=`],
  ["trace_VPlusInv_pos", `theorem trace_VPlusInv_pos {K1 K2star : ℂ} {s2 : ℝ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2) :
    0 < (VPlusInv M K1 s2 K2star).trace :=`],
]);
const vPlusPositiveDefiniteExpectedLeanTargets = [
  "VPlusInv",
  "VPlus_posDef",
  "VPlus_mul_VPlusInv",
  "VPlusInv_mul_VPlus",
  "VPlusInv_posDef",
  "trace_VPlus_pos",
  "trace_VPlusInv_pos",
];
for (const target of vPlusPositiveDefiniteExpectedLeanTargets) {
  const declarationFragment = vPlusPositiveDefiniteExpectedLeanDeclarationFragments.get(target);
  if (declarationFragment === undefined || !vPlusPositiveDefiniteLeanSource.includes(declarationFragment)) {
    throw new Error(`偶セクター転送行列の正定値性の Lean 宣言または定理文が変わりました: ${target}`);
  }
}
const vPlusPositiveDefiniteSageMathExecutableSource = vPlusPositiveDefiniteSageMathSource
  .split("\n")
  .filter((line) => !line.trimStart().startsWith("#"))
  .join("\n");
const vPlusPositiveDefiniteExpectedSageMathExecutionFragments = [
  "Vp, Vpi = V_plus(O, K1, K2)",
  "w_herm = max(w_herm, herm_residual(Vp))",
  "w_herm = max(w_herm, herm_residual(Vpi))",
  `for z in Vp.eigenvalues():
            r = RDF(CDF(z).real())
            min_ev = r if min_ev is None else min(min_ev, r)`,
  `trV = RDF(Vp.trace().real())
        trVi = RDF(Vpi.trace().real())
        min_trV = trV if min_trV is None else min(min_trV, trV)
        min_trVinv = trVi if min_trVinv is None else min(min_trVinv, trVi)`,
  `ok_all &= report("V^{(+)}, (V^{(+)})^{-1} はエルミート", w_herm, TOL)`,
  "ok_all &= (min_ev > 0 and min_trV > 0 and min_trVinv > 0)",
];
for (const executionFragment of vPlusPositiveDefiniteExpectedSageMathExecutionFragments) {
  if (!vPlusPositiveDefiniteSageMathExecutableSource.includes(executionFragment)) {
    throw new Error(`偶セクター転送行列の正定値性の SageMath 実検査行が変わりました: ${executionFragment}`);
  }
}
const vPlusRightInverseSageMathExecutableSource = vPlusRightInverseSageMathSource
  .split("\n")
  .filter((line) => !line.trimStart().startsWith("#"))
  .join("\n");
const vPlusLeftInverseSageMathExecutableSource = vPlusLeftInverseSageMathSource
  .split("\n")
  .filter((line) => !line.trimStart().startsWith("#"))
  .join("\n");
if (!vPlusRightInverseSageMathExecutableSource.includes("opnorm(Vp * Rplus - Id) / opnorm(Id)")
  || vPlusRightInverseSageMathExecutableSource.includes("opnorm(Rplus * Vp - Id) / opnorm(Id)")) {
  throw new Error("偶セクター転送行列の右逆 SageMath 独立検査が変わりました");
}
if (!vPlusLeftInverseSageMathExecutableSource.includes("opnorm(Rplus * Vp - Id) / opnorm(Id)")
  || vPlusLeftInverseSageMathExecutableSource.includes("opnorm(Vp * Rplus - Id) / opnorm(Id)")) {
  throw new Error("偶セクター転送行列の左逆 SageMath 独立検査が変わりました");
}
const vPlusInversePositiveDefiniteSageMathExecutableSource =
  vPlusInversePositiveDefiniteSageMathSource
    .split("\n")
    .filter((line) => !line.trimStart().startsWith("#"))
    .join("\n");
if (!vPlusInversePositiveDefiniteSageMathExecutableSource.includes("for eigenvalue in Vpi.eigenvalues():")
  || !vPlusInversePositiveDefiniteSageMathExecutableSource.includes("min_inverse_eigenvalue > 0")
  || !vPlusInversePositiveDefiniteSageMathExecutableSource.includes('print("RESULT:", "PASS" if ok_all else "FAIL")')
  || !vPlusInversePositiveDefiniteSageMathExecutableSource.includes("raise RuntimeError(")
  || vPlusInversePositiveDefiniteSageMathExecutableSource.includes("Vp.eigenvalues()")) {
  throw new Error("偶セクター転送行列の逆行列の全固有値正値性の SageMath 独立検査が変わりました");
}
const v1PlusHalfInvertibleExpectedDirectDependencies = [
  "TV1_hatZ_hatY_009_definition_invertible_elements",
  "calc_formulae_006_definition_of_cc",
  "evensectorT_definition_V1_plus_square_root",
  "exp_conjugation_proof_010_theorem_matrix_exp_conjugation",
  "transfer_matrix_011_definition_H1_H2",
].sort();
const vTwoInvertibleExpectedDirectDependencies = [
  "TV1_hatZ_hatY_009_definition_invertible_elements",
  "calc_formulae_006_definition_of_cc",
  "exp_conjugation_proof_010_theorem_matrix_exp_conjugation",
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_011_definition_H1_H2",
].sort();
const v1PlusHalfInvertibleExpectedContentSha256 = "7ddf2ffcfb7f8d60b2fde61783ddc4dd251dfb8e197f8bbb4eb27b244a874dc7";
const vTwoInvertibleExpectedContentSha256 = "eabadeb2353bdb7cd8c2ff1014e2c3d6f42e52901fb3cdb657f753382ef97992";
const vPlusFactorsInvertibilityBoundaryCandidates = [
  {
    output: "偶セクター転送行列 V^{(+)} が可逆であること",
    currentEntryId: "evensectorT_claim_V_plus_factors_invertible",
    formalizationTarget: "Lean の isUnit_VPlus と SageMath の V^{(+)} の逆行列検査",
  },
] as const;
const vPlusFactorsInvertibilityExpectedBoundaryCandidates = [
  {
    output: "偶セクター転送行列 V^{(+)} が可逆であること",
    currentEntryId: "evensectorT_claim_V_plus_factors_invertible",
    formalizationTarget: "Lean の isUnit_VPlus と SageMath の V^{(+)} の逆行列検査",
  },
] as const;
const vPlusFactorsInvertibilityNextTickUnit = vPlusFactorsInvertibilityBoundaryCandidates;
const vPlusFactorsInvertibilityExpectedNextTickUnit = vPlusFactorsInvertibilityExpectedBoundaryCandidates;
if (JSON.stringify(vPlusFactorsInvertibilityBoundaryCandidates)
    !== JSON.stringify(vPlusFactorsInvertibilityExpectedBoundaryCandidates)
  || JSON.stringify(vPlusFactorsInvertibilityNextTickUnit)
    !== JSON.stringify(vPlusFactorsInvertibilityExpectedNextTickUnit)) {
  throw new Error("偶セクター転送行列の可逆性について、残る境界候補または次回一項単位が変わりました");
}
const vPlusFactorsInvertibilityLeanFile = "lean/Ising2D/Part014/Definition001_VPlus.lean";
const vTwoInvertibilityLeanFile = "lean/Ising2D/Part004/Definition010_H1H2V1V2.lean";
const vPlusFactorsInvertibilitySageMathFile =
  "sagemath/check/051_stepwise_identities_of_chapter_Cprime/check_03_014_steps.sage";
const vPlusFactorsInvertibilityLeanSource = readFileSync(
  join(projectDir, vPlusFactorsInvertibilityLeanFile),
  "utf8",
);
const vTwoInvertibilityLeanSource = readFileSync(join(projectDir, vTwoInvertibilityLeanFile), "utf8");
const vPlusFactorsInvertibilitySageMathExecutableSource = readFileSync(
  join(projectDir, vPlusFactorsInvertibilitySageMathFile),
  "utf8",
).split("\n").filter((line) => !line.trimStart().startsWith("#")).join("\n");
const vPlusFactorsInvertibilityExpectedLeanFragments = [
  `/-- **原文 \`V1_plus_half_invertible\`**: \`(V_1^{(+)})^{1/2}\` は可逆。 -/
theorem isUnit_V1halfPlus (K1 : ℂ) : IsUnit (V1half M K1 (-1)) :=`,
  `theorem isUnit_VPlus {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) :
    IsUnit (VPlus M s2 K1 K2star) :=`,
];
for (const declarationFragment of vPlusFactorsInvertibilityExpectedLeanFragments) {
  if (!vPlusFactorsInvertibilityLeanSource.includes(declarationFragment)) {
    throw new Error(`構成因子の可逆性に対応する偶セクター Lean 宣言が変わりました: ${declarationFragment}`);
  }
}
if (!vTwoInvertibilityLeanSource.includes(
  `/-- **原文 \`V2_invertible\`**: \`V_2\` は可逆。 -/
theorem isUnit_V2 {s2 : ℝ} (hs2 : 0 < s2) (K2star : ℂ) : IsUnit (V2 M s2 K2star) :=`,
)) {
  throw new Error("第二の転送行列の可逆性に対応する Lean 宣言が変わりました");
}
const vPlusFactorsInvertibilityExpectedSageMathExecutionFragments = [
  'S.add("V1_plus_half_invertible exp(X)^{-1} = exp(-X)", Vh * Vhi, Id)',
  'S.add("V2_invertible V_2 V_2^{-1} = I", V2 * V2i, Id)',
  'S.add("V_plus_factors_invertible (Vplus) V^{(+)} V^{(+)-1} = I", Vp * Vpi, Id)',
];
for (const executionFragment of vPlusFactorsInvertibilityExpectedSageMathExecutionFragments) {
  if (!vPlusFactorsInvertibilitySageMathExecutableSource.includes(executionFragment)) {
    throw new Error(`構成因子の可逆性に対応する SageMath 実検査行が変わりました: ${executionFragment}`);
  }
}
const conjugationLinearityExpectedDirectDependencies = [
  "TV1_hatZ_hatY_009_definition_invertible_elements",
  "TV1_hatZ_hatY_011_definition_T_g",
  "calc_formulae_006_definition_of_cc",
  "evensectorT_claim_V_plus_factors_invertible",
  "evensector_003a_definition_check_index_set",
  "linear_space_general_002_claim_scalar_identity_commutes",
].sort();
const conjugationLinearityExpectedContentSha256 = "edde665026f94ea622d8b11770a963ac959e09de0a3c44426d56c097be3b54eb";
const nonPrerequisiteReferenceLabelsById = new Map<string, Set<string>>([
  ["calc_formulae_006_definition_of_cc", new Set(["abs_basic_properties", "matrix_exp_series_converges"])],
  ["linear_space_general_000_definition_kronecker_product", new Set(["kronecker_product_rule", "tensor_basis"])],
  ["transfer_matrix_003_claim_V1_in_Z_Y_epsilon", new Set(["theorem_exp_product"])],
  ["TV1_hatZ_hatY_001_claim_commutator_H_Z_Y", new Set(["why_008_applies_only_to_minus_sector"])],
  ["TV1_hatZ_hatY_027_claim_eigenvector_A_theta", new Set(["A_theta_is_identity_when_gamma2_zero"])],
]);
const explicitSemanticPrerequisiteLabelsById = new Map<string, Set<string>>([
  ["partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix", new Set(["theorem_exp_product"])],
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", new Set(["mat_mult"])],
]);
const forwardNavigationReviewById = new Map<string, Map<string, string>>([
  ["calculation_formulae_definition_set_and_algebra_notation", new Map([["definition_of_cc", "既存の複素数定義への案内"]])],
  ["calc_formulae_006_definition_of_cc", new Map([["abs_basic_properties", "後続利用への案内"], ["matrix_exp_series_converges", "後続利用への案内"]])],
  ["TV1_hatZ_hatY_010a_claim_V2_not_in_clifford_group", new Map([["def_T_g", "後続の比較対象への案内"]])],
  ["TV1_hatZ_hatY_030_definition_fermi", new Map([["T_V_eq_T_Vprime_on_hatZ_hatY", "後続利用への案内"], ["T_Vprime_fixes_hatZ_hatY_when_gamma2_zero", "例外処理への案内"], ["critical_condition_c1_eq_s1_c2", "例外条件への案内"]])],
  ["freeenergy_002_claim_gamma_is_continuous", new Map([["riemann_sum_to_integral", "後続利用への案内"]])],
  ["evensector_002_claim_antiperiodic_exp_sum", new Map([["def_check_index_set", "後続表記への案内"]])],
  ["evensector_003_definition_half_integer_modes", new Map([["def_check_index_set", "後続表記への案内"], ["periodicity_of_check_fermi", "後続利用への案内"]])],
  ["evensector_003a_definition_check_index_set", new Map([["anticommutator_of_check_Z_Y", "後続利用への案内"], ["periodicity_of_check_fermi", "後続利用への案内"]])],
  ["evenEigen_004_claim_trace_of_check_number_operator_product", new Map([["check_joint_eigenspace_decomposition", "後続対応への案内"]])],
  ["evenEigen_006_claim_eigenvalues_of_check_Vprime", new Map([["max_eigenvalue_of_V_plus_simple", "後続帰結への案内"]])],
  ["closing_002_claim_epsilon_eigenvalue_on_check_Q", new Map([["max_eigenvector_in_even_sector", "後続利用への案内"], ["trace_of_epsilon_V_plus", "後続の符号決定への案内"]])],
]);
const forwardPrerequisiteLabelsById = new Map<string, Set<string>>([
  ["exp_conjugation_proof_003_definition_M_n_C_convergence", new Set(["def_hermitian_positive_definite", "def_trace"])],
  ["transfer_matrix_001_definition_symbols", new Set(["pauli_matrix_products"])],
]);
const manualGranularityReviewById = new Map<string, string>([
  ["calc_formulae_014b_claim_arcsin_bijection", "円弧長に関する外部命題の証明を本文内の一ステップ一定理へ展開する余地がある。分類境界と依存順は確定している。"],
  ["transfer_matrix_001_definition_symbols", "二次・多因子の単位行列、サイトごとの三つの Pauli 行列、V1・V2、Jordan–Wigner 行列、全スピン反転行列、双対結合定数、双曲線関数の略記という独立した定義を一ブロックへ束ねている。Pauli行列、cosh・sinh、その正値性は先行項を明示参照したが、tanh と実対数には独立した先行定義がなく、双対関係の後続証明は本項へ依存するため参照できない。分割後に節境界と依存順を再判定する必要がある。"],
  ["transfer_matrix_011_definition_H1_H2", "一般の生成子 H1^{(±)} と H2 の二定義に加え、既存の V1^{(±)} と V2 の指数表示を同じブロックへ束ねている。今回確定する節では外部入力として扱い、将来一ブロック一定義へ分割した後に依存順と節境界を再判定する必要がある。"],
  ["evensectorT_claim_V_plus_factors_invertible", "V^{(+)} の可逆性は先行する二つの構成因子の可逆性から機械的に分離した段階であり、内容と形式化同期のレビューは次回一項単位として残している。"],
]);
const futureBlockSplitRecommendedById = new Set([
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_011_definition_H1_H2",
  "evensectorT_claim_V_plus_factors_invertible",
]);
const presentationPredecessorEntryIdsById = new Map<string, string[]>([
  ["closing_definition_D0_open_chain_operator", ["evensectorT_definition_H1_plus"]],
  ["closing_definition_G_boundary_operator", ["closing_definition_D0_open_chain_operator"]],
  ["closing_claim_D0_G_diagonal_action", ["closing_004_claim_H1_plus_in_sigma_z_form"]],
  ["closing_claim_epsilon_D0_G_pairwise_commute", ["closing_claim_D0_G_diagonal_action"]],
  ["evensectorT_claim_V1_plus_half_invertible", ["evenEigen_claim_V_plus_inverse_positive_and_traces"]],
  ["evensectorT_claim_V2_invertible", ["evensectorT_claim_V1_plus_half_invertible"]],
  ["evensectorT_claim_V_plus_factors_invertible", ["evensectorT_claim_V2_invertible"]],
]);
const isingPattern = /Ising|イジング|spin|スピン|lattice|格子|site|サイト|transfer|転送|sector|セクター|momentum|運動量|fermion|フェルミオン/i;
const abstractPatterns = [
  { name: "リー群", pattern: /Lie\s*group|リー群/i },
  { name: "リー環", pattern: /Lie\s*algebra|リー環/i },
  { name: "抽象テンソル積", pattern: /abstract\s+tensor|抽象テンソル積/i },
  { name: "一般の体・環", pattern: /\\mathbb\{K\}|\bK\s*:=|Mat\([^)]*,K\)|任意の体|一般の体|一般の環/i },
  { name: "抽象線型写像", pattern: /\\mathrm\{End\}|線型写像|linear\s+map/i },
  { name: "群の一般論", pattern: /群|group/i },
];

function collectTargets(value: unknown, targets = new Set<string>()): Set<string> {
  if (Array.isArray(value)) for (const item of value) collectTargets(item, targets);
  else if (value !== null && typeof value === "object") {
    const record = value as Record<string, unknown>;
    if (record.type === "ref" && typeof record.target === "string") targets.add(record.target);
    for (const child of Object.values(record)) collectTargets(child, targets);
  }
  return targets;
}

function blockTitle(block: object): string | null {
  if (!("title" in block) || block.title === null || typeof block.title !== "object") return null;
  if ("text" in block.title && typeof block.title.text === "string") return block.title.text;
  if ("tex" in block.title && typeof block.title.tex === "string") return block.title.tex;
  return null;
}

function blockTitleFormat(block: object): "text" | "tex" | null {
  if (!("title" in block) || block.title === null || typeof block.title !== "object") return null;
  return "tex" in block.title ? "tex" : "text";
}

function stronglyConnectedComponents(nodes: string[], dependencies: Map<string, string[]>): string[][] {
  let index = 0;
  const indices = new Map<string, number>();
  const low = new Map<string, number>();
  const stack: string[] = [];
  const active = new Set<string>();
  const components: string[][] = [];
  function visit(node: string): void {
    indices.set(node, index); low.set(node, index); index += 1; stack.push(node); active.add(node);
    for (const dependency of dependencies.get(node) ?? []) {
      if (!indices.has(dependency)) { visit(dependency); low.set(node, Math.min(low.get(node)!, low.get(dependency)!)); }
      else if (active.has(dependency)) low.set(node, Math.min(low.get(node)!, indices.get(dependency)!));
    }
    if (low.get(node) !== indices.get(node)) return;
    const component: string[] = [];
    while (stack.length > 0) {
      const member = stack.pop()!; active.delete(member); component.push(member);
      if (member === node) break;
    }
    components.push(component.sort());
  }
  for (const node of [...nodes].sort()) if (!indices.has(node)) visit(node);
  return components;
}

function topologicalComponents(components: string[][], dependencies: Map<string, string[]>): string[][] {
  const owner = new Map<string, number>();
  components.forEach((component, i) => component.forEach((node) => owner.set(node, i)));
  const dependents = new Map<number, Set<number>>();
  const counts = new Map(components.map((_, i) => [i, 0]));
  for (const [node, prerequisites] of dependencies) for (const prerequisite of prerequisites) {
    const from = owner.get(prerequisite)!; const to = owner.get(node)!;
    if (from === to) continue;
    const targets = dependents.get(from) ?? new Set<number>();
    if (!targets.has(to)) { targets.add(to); dependents.set(from, targets); counts.set(to, counts.get(to)! + 1); }
  }
  const compare = (a: number, b: number) => components[a]!.join("\u0000").localeCompare(components[b]!.join("\u0000"));
  const ready = [...counts].filter(([, count]) => count === 0).map(([i]) => i).sort(compare);
  const result: string[][] = [];
  while (ready.length > 0) {
    const current = ready.shift()!; result.push(components[current]!);
    for (const dependent of dependents.get(current) ?? []) {
      counts.set(dependent, counts.get(dependent)! - 1);
      if (counts.get(dependent) === 0) { ready.push(dependent); ready.sort(compare); }
    }
  }
  if (result.length !== components.length) throw new Error("縮約依存グラフの順序を確定できません");
  return result;
}

const files = await loadContentFiles();
const allBlocks = files.flatMap(({ file, blocks }) => blocks.map((block) => ({ file, block })));
const targetBlocks = allBlocks.filter(({ block }) => ["definition", "claim", "theorem"].includes(block.kind));
const targetIds = new Set(targetBlocks.map(({ block }) => block.id));
const labelOwners = new Map<string, string>();
const blockPositionById = new Map(allBlocks.map(({ block }, position) => [block.id, position]));
for (const { block } of allBlocks) for (const label of block.labels) {
  if (labelOwners.has(label)) throw new Error(`ラベル所有者が重複しています: ${label}`);
  labelOwners.set(label, block.id);
}
const incoming = new Map<string, number>();
for (const { block } of allBlocks) for (const target of collectTargets(block)) incoming.set(target, (incoming.get(target) ?? 0) + 1);

const baseEntries = targetBlocks.map(({ file, block }) => {
  const record = block as unknown as Record<string, unknown>;
  const inspected = JSON.stringify({ title: record.title, statement: record.statement, proof: record.proof });
  const inspectedContentSha256 = createHash("sha256").update(inspected).digest("hex");
  const isingSemanticMatches = [...new Set(inspected.match(isingPattern) ?? [])].sort();
  const abstractVocabularyMatches = abstractPatterns.filter(({ pattern }) => pattern.test(inspected)).map(({ name }) => name);
  const toolCandidate = mathematicalToolFiles.has(file) || mathematicalToolEntryIdsOutsideToolFiles.has(block.id);
  const chapter: FinalChapter = toolCandidate && isingSemanticMatches.length === 0
    ? "数学的道具立て" : "2次元イジングモデル";
  const statementReferenceLabels = [...collectTargets(record.statement)].sort();
  const proofReferenceLabels = [...collectTargets(record.proof)].sort();
  const semanticPrerequisiteLabels: string[] = [];
  if (block.id !== "calculation_formulae_definition_set_and_algebra_notation" && /\\mathbb\s*(?:\{[NZR]\}|[NZR])/.test(inspected)) semanticPrerequisiteLabels.push("set_and_algebra_notation");
  if (!["calculation_formulae_definition_set_and_algebra_notation", "calc_formulae_006_definition_of_cc"].includes(block.id) && /\\mathbb\s*\{?C\}?/.test(inspected)) semanticPrerequisiteLabels.push("definition_of_cc");
  if (block.id !== "transfer_matrix_011_definition_H1_H2" && /H_[12]/.test(inspected)) {
    semanticPrerequisiteLabels.push("def_H1_H2");
  }
  semanticPrerequisiteLabels.push(...(explicitSemanticPrerequisiteLabelsById.get(block.id) ?? []));
  const rawReferenceLabels = [...new Set([...statementReferenceLabels, ...proofReferenceLabels, ...semanticPrerequisiteLabels])].sort();
  const configuredExclusions = nonPrerequisiteReferenceLabelsById.get(block.id) ?? new Set<string>();
  const forwardStatementReferenceLabels = statementReferenceLabels.filter((label) => {
    const ownerId = labelOwners.get(label);
    return ownerId !== undefined && blockPositionById.get(ownerId)! > blockPositionById.get(block.id)!;
  });
  const navigationReview = forwardNavigationReviewById.get(block.id) ?? new Map<string, string>();
  const forwardPrerequisites = forwardPrerequisiteLabelsById.get(block.id) ?? new Set<string>();
  const reviewedLabels = new Set([...navigationReview.keys(), ...forwardPrerequisites]);
  const forwardReviewMatches = forwardStatementReferenceLabels.every((label) => reviewedLabels.has(label))
    && [...reviewedLabels].every((label) => forwardStatementReferenceLabels.includes(label));
  const forwardStatementReferenceReview = navigationReview.size === 0 ? null : Object.fromEntries(navigationReview);
  const reviewedForwardNavigationLabels = forwardReviewMatches ? [...navigationReview.keys()] : [];
  const excludedReferenceLabels = new Set([...configuredExclusions, ...reviewedForwardNavigationLabels]);
  const dependsOnLabels = rawReferenceLabels.filter((label) => !excludedReferenceLabels.has(label));
  for (const label of semanticPrerequisiteLabels) if (!dependsOnLabels.includes(label)) {
    throw new Error(`記号使用から導いた意味的前提が依存辺にありません: ${block.id} -> ${label}`);
  }
  const dependsOnEntryIds = [...new Set(dependsOnLabels.map((label) => labelOwners.get(label))
    .filter((id): id is string => id !== undefined && id !== block.id && targetIds.has(id)))].sort();
  return {
    id: block.id, kind: block.kind, title: blockTitle(block), titleFormat: blockTitleFormat(block), labels: block.labels, sourceFile: file,
    sourceOrdinal: block.origin?.ordinal ?? null, provisionalFinalChapter: chapter,
    classificationEvidence: {
      mathematicalToolCandidateFile: mathematicalToolFiles.has(file),
      mathematicalToolCandidateEntry: mathematicalToolEntryIdsOutsideToolFiles.has(block.id),
      incomingReferenceCount: block.labels.reduce((sum, label) => sum + (incoming.get(label) ?? 0), 0),
      isingSemanticMatches,
      rule: "項目ごとの意味レビューで一般的な複素数・行列計算と確認され、内容にイジング固有語彙がなければ数学的道具立て、それ以外は2次元イジングモデル",
      rationale: chapter === "数学的道具立て"
        ? "イジング模型を仮定せず、複素数・有限行列の具体的な定義または計算として再利用できる。"
        : "対象の意味または導入目的がスピン・格子・転送行列などイジング模型の構成に依存する。",
    },
    explanationGranularityReview: {
      status: abstractVocabularyMatches.length === 0 && forwardStatementReferenceLabels.length === 0 && !manualGranularityReviewById.has(block.id)
        ? "自動検査で主題に適合"
        : "具体的な行列計算への展開またはブロック分割を要する",
      criterion: "複素数と有限行列の成分・和・積・極限を、依存先から順に高校生が追える粒度で説明する",
      abstractVocabularyMatches,
      inspectedCharacterCount: inspected.length,
      inspectedContentSha256,
      forwardNavigationMixedIntoStatement: forwardStatementReferenceLabels.length > 0 && !forwardReviewMatches,
      inspectedFields: ["title", "statement", "proof"],
      manualReview: manualGranularityReviewById.get(block.id) ?? null,
    },
    dependsOnLabels, dependsOnEntryIds, semanticPrerequisiteLabels,
    referenceLabelsNotUsedAsPrerequisites: [...excludedReferenceLabels].sort(),
    forwardStatementReferenceLabelsNotUsedAsPrerequisites: reviewedForwardNavigationLabels,
    forwardStatementReferenceLabelsUsedAsPrerequisites: [...forwardPrerequisites].sort(),
    forwardStatementReferenceReview,
    blockSplitRequiredBeforeFinalOrdering: forwardStatementReferenceLabels.length > 0 && !forwardReviewMatches,
    futureBlockSplitRecommended: futureBlockSplitRecommendedById.has(block.id),
    presentationPredecessorEntryIds: presentationPredecessorEntryIdsById.get(block.id) ?? [],
  };
});
const entryById = new Map(baseEntries.map((entry) => [entry.id, entry]));
const chapterStructures = finalChapters.map((chapter) => {
  const chapterEntries = baseEntries.filter((entry) => entry.provisionalFinalChapter === chapter);
  const chapterIds = new Set(chapterEntries.map(({ id }) => id));
  const dependencies = new Map(chapterEntries.map(({ id, dependsOnEntryIds, presentationPredecessorEntryIds }) => [
    id,
    [...new Set([...dependsOnEntryIds, ...presentationPredecessorEntryIds])].filter((x) => chapterIds.has(x)),
  ]));
  const ordered = topologicalComponents(stronglyConnectedComponents([...chapterIds], dependencies), dependencies);
  return {
    chapter, entryCount: chapterEntries.length, dependencyDirection: "prerequisite から dependent へ",
    topologicalOrder: ordered.map((entryIds, i) => ({ order: i + 1, entryIds, inseparableDependencyUnit: entryIds.length > 1 })),
    crossChapterPrerequisites: chapterEntries.flatMap((entry) => entry.dependsOnEntryIds
      .filter((id) => entryById.get(id)?.provisionalFinalChapter !== chapter)
      .map((prerequisiteId) => ({ dependentId: entry.id, prerequisiteId }))),
  };
});
const toolStructure = chapterStructures.find(({ chapter }) => chapter === "数学的道具立て")!;
if (toolStructure.crossChapterPrerequisites.length > 0) throw new Error(`数学的道具立てが後章を前提にしています: ${JSON.stringify(toolStructure.crossChapterPrerequisites)}`);
const order = new Map<string, { chapterOrder: number; dependencyUnitEntryIds: string[] }>();
for (const structure of chapterStructures) for (const unit of structure.topologicalOrder) for (const id of unit.entryIds) {
  order.set(id, { chapterOrder: unit.order, dependencyUnitEntryIds: unit.entryIds });
}
const entries = baseEntries.map((entry) => ({ ...entry, dependencyPlacement: order.get(entry.id) }));
const unresolvedBlockSplits = entries.filter((entry) => entry.blockSplitRequiredBeforeFinalOrdering);
if (unresolvedBlockSplits.length > 0) {
  throw new Error(`未レビューの前方参照が残っています: ${unresolvedBlockSplits.map(({ id }) => id).join(", ")}`);
}
const matrixExponentialConjugationSectionIdSet = new Set<string>(matrixExponentialConjugationSectionEntryIds);
const matrixExponentialConjugationSectionEntries = matrixExponentialConjugationSectionEntryIds.map((id) => {
  const entry = entries.find((candidate) => candidate.id === id);
  if (entry === undefined) throw new Error(`行列指数関数による共役の節候補に必要な項目がありません: ${id}`);
  if (entry.provisionalFinalChapter !== "数学的道具立て") {
    throw new Error(`行列指数関数による共役の節候補が数学的道具立てにありません: ${id}`);
  }
  const actualInternalDependencies = entry.dependsOnEntryIds
    .filter((dependencyId) => matrixExponentialConjugationSectionIdSet.has(dependencyId))
    .sort();
  const expectedInternalDependencies = [...matrixExponentialConjugationExpectedInternalDependencies.get(id)!].sort();
  if (JSON.stringify(actualInternalDependencies) !== JSON.stringify(expectedInternalDependencies)) {
    throw new Error(`行列指数関数による共役の節候補の内部依存辺が変わりました: ${id}: ${JSON.stringify(actualInternalDependencies)}`);
  }
  if (entry.explanationGranularityReview.inspectedContentSha256 !== matrixExponentialConjugationExpectedContentSha256.get(id)) {
    throw new Error(`行列指数関数による共役の節候補のレビュー済み本文が変わりました: ${id}`);
  }
  return entry;
});
const matrixExponentialConjugationSectionOrders = matrixExponentialConjugationSectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (!matrixExponentialConjugationSectionOrders.every((chapterOrder, index) =>
  index === 0 || chapterOrder === matrixExponentialConjugationSectionOrders[index - 1]! + 1)) {
  throw new Error(`行列指数関数による共役の節候補が章内依存順の連続区間ではありません: ${JSON.stringify(matrixExponentialConjugationSectionOrders)}`);
}
const matrixExponentialConjugationInternalDependencyTargets = new Set(
  [...matrixExponentialConjugationExpectedInternalDependencies.values()].flat(),
);
const matrixExponentialConjugationTerminalEntryIds = matrixExponentialConjugationSectionEntryIds
  .filter((id) => !matrixExponentialConjugationInternalDependencyTargets.has(id));
if (JSON.stringify(matrixExponentialConjugationTerminalEntryIds) !== JSON.stringify(["exp_conjugation_proof_008_theorem_exp_ad_series"])) {
  throw new Error(`行列指数関数による共役の節候補が節末の系へ閉じていません: ${JSON.stringify(matrixExponentialConjugationTerminalEntryIds)}`);
}
const matrixExponentialConjugationExternalInputEntryIds = [...new Set(
  matrixExponentialConjugationSectionEntries.flatMap((entry) => entry.dependsOnEntryIds)
    .filter((id) => !matrixExponentialConjugationSectionIdSet.has(id)),
)].sort((a, b) => order.get(a)!.chapterOrder - order.get(b)!.chapterOrder);
if (JSON.stringify([...matrixExponentialConjugationExternalInputEntryIds].sort())
  !== JSON.stringify(matrixExponentialConjugationExpectedExternalInputEntryIds)) {
  throw new Error(`行列指数関数による共役の節候補の外部入力が変わりました: ${JSON.stringify(matrixExponentialConjugationExternalInputEntryIds)}`);
}
const matrixLinearMapCorrespondenceSectionIdSet = new Set<string>(matrixLinearMapCorrespondenceSectionEntryIds);
const matrixLinearMapCorrespondenceSectionEntries = matrixLinearMapCorrespondenceSectionEntryIds.map((id) => {
  const entry = entries.find((candidate) => candidate.id === id);
  if (entry === undefined) throw new Error(`行列と線型写像の対応の節候補に必要な項目がありません: ${id}`);
  if (entry.provisionalFinalChapter !== "数学的道具立て") {
    throw new Error(`行列と線型写像の対応の節候補が数学的道具立てにありません: ${id}`);
  }
  const actualInternalDependencies = entry.dependsOnEntryIds
    .filter((dependencyId) => matrixLinearMapCorrespondenceSectionIdSet.has(dependencyId))
    .sort();
  const expectedInternalDependencies = [...matrixLinearMapCorrespondenceExpectedInternalDependencies.get(id)!].sort();
  if (JSON.stringify(actualInternalDependencies) !== JSON.stringify(expectedInternalDependencies)) {
    throw new Error(`行列と線型写像の対応の節候補の内部依存辺が変わりました: ${id}: ${JSON.stringify(actualInternalDependencies)}`);
  }
  if (entry.explanationGranularityReview.inspectedContentSha256 !== matrixLinearMapCorrespondenceExpectedContentSha256.get(id)) {
    throw new Error(`行列と線型写像の対応の節候補のレビュー済み本文が変わりました: ${id}`);
  }
  return entry;
});
const matrixLinearMapCorrespondenceSectionOrders = matrixLinearMapCorrespondenceSectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (!matrixLinearMapCorrespondenceSectionOrders.every((chapterOrder, index) =>
  index === 0 || chapterOrder === matrixLinearMapCorrespondenceSectionOrders[index - 1]! + 1)) {
  throw new Error(`行列と線型写像の対応の節候補が章内依存順の連続区間ではありません: ${JSON.stringify(matrixLinearMapCorrespondenceSectionOrders)}`);
}
const matrixLinearMapCorrespondenceInternalDependencyTargets = new Set(
  [...matrixLinearMapCorrespondenceExpectedInternalDependencies.values()].flat(),
);
const matrixLinearMapCorrespondenceTerminalEntryIds = matrixLinearMapCorrespondenceSectionEntryIds
  .filter((id) => !matrixLinearMapCorrespondenceInternalDependencyTargets.has(id));
if (JSON.stringify(matrixLinearMapCorrespondenceTerminalEntryIds)
  !== JSON.stringify([
    "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
    "transfer_matrix_claim_end_acts_on_kronecker_products",
  ])) {
  throw new Error(`行列と線型写像の対応の節候補が二つの節末出力へ閉じていません: ${JSON.stringify(matrixLinearMapCorrespondenceTerminalEntryIds)}`);
}
const matrixLinearMapCorrespondenceExternalInputEntryIds = [...new Set(
  matrixLinearMapCorrespondenceSectionEntries.flatMap((entry) => entry.dependsOnEntryIds)
    .filter((id) => !matrixLinearMapCorrespondenceSectionIdSet.has(id)),
)].sort((a, b) => order.get(a)!.chapterOrder - order.get(b)!.chapterOrder);
if (JSON.stringify([...matrixLinearMapCorrespondenceExternalInputEntryIds].sort())
  !== JSON.stringify(matrixLinearMapCorrespondenceExpectedExternalInputEntryIds)) {
  throw new Error(`行列と線型写像の対応の節候補の外部入力が変わりました: ${JSON.stringify(matrixLinearMapCorrespondenceExternalInputEntryIds)}`);
}
for (const id of matrixLinearMapCorrespondenceExternalInputEntryIds) {
  const entry = entries.find((candidate) => candidate.id === id)!;
  if (entry.explanationGranularityReview.inspectedContentSha256
    !== matrixLinearMapCorrespondenceExpectedExternalInputContentSha256.get(id)) {
    throw new Error(`行列と線型写像の対応の節候補の外部入力本文が変わりました: ${id}`);
  }
}
const invertibleMatrixConjugationSectionIdSet = new Set<string>(invertibleMatrixConjugationSectionEntryIds);
const invertibleMatrixConjugationSectionEntries = invertibleMatrixConjugationSectionEntryIds.map((id) => {
  const entry = entries.find((candidate) => candidate.id === id);
  if (entry === undefined) throw new Error(`可逆行列と共役写像の節候補に必要な項目がありません: ${id}`);
  if (entry.provisionalFinalChapter !== "数学的道具立て") {
    throw new Error(`可逆行列と共役写像の節候補が数学的道具立てにありません: ${id}`);
  }
  const actualInternalDependencies = entry.dependsOnEntryIds
    .filter((dependencyId) => invertibleMatrixConjugationSectionIdSet.has(dependencyId))
    .sort();
  const expectedInternalDependencies = [...invertibleMatrixConjugationExpectedInternalDependencies.get(id)!].sort();
  if (JSON.stringify(actualInternalDependencies) !== JSON.stringify(expectedInternalDependencies)) {
    throw new Error(`可逆行列と共役写像の節候補の内部依存辺が変わりました: ${id}: ${JSON.stringify(actualInternalDependencies)}`);
  }
  if (entry.explanationGranularityReview.inspectedContentSha256 !== invertibleMatrixConjugationExpectedContentSha256.get(id)) {
    throw new Error(`可逆行列と共役写像の節候補のレビュー済み本文が変わりました: ${id}`);
  }
  return entry;
});
const invertibleMatrixConjugationSectionOrders = invertibleMatrixConjugationSectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (!invertibleMatrixConjugationSectionOrders.every((chapterOrder, index) =>
  index === 0 || chapterOrder === invertibleMatrixConjugationSectionOrders[index - 1]! + 1)) {
  throw new Error(`可逆行列と共役写像の節候補が章内依存順の連続区間ではありません: ${JSON.stringify(invertibleMatrixConjugationSectionOrders)}`);
}
const invertibleMatrixConjugationInternalDependencyTargets = new Set(
  [...invertibleMatrixConjugationExpectedInternalDependencies.values()].flat(),
);
const invertibleMatrixConjugationTerminalEntryIds = invertibleMatrixConjugationSectionEntryIds
  .filter((id) => !invertibleMatrixConjugationInternalDependencyTargets.has(id));
if (JSON.stringify(invertibleMatrixConjugationTerminalEntryIds)
  !== JSON.stringify(["TV1_hatZ_hatY_011a_claim_injectivity_of_T"])) {
  throw new Error(`可逆行列と共役写像の節候補が節末の主定理へ閉じていません: ${JSON.stringify(invertibleMatrixConjugationTerminalEntryIds)}`);
}
const invertibleMatrixConjugationExternalInputEntryIds = [...new Set(
  invertibleMatrixConjugationSectionEntries.flatMap((entry) => entry.dependsOnEntryIds)
    .filter((id) => !invertibleMatrixConjugationSectionIdSet.has(id)),
)].sort((a, b) => order.get(a)!.chapterOrder - order.get(b)!.chapterOrder);
if (JSON.stringify([...invertibleMatrixConjugationExternalInputEntryIds].sort())
  !== JSON.stringify(invertibleMatrixConjugationExpectedExternalInputEntryIds)) {
  throw new Error(`可逆行列と共役写像の節候補の外部入力が変わりました: ${JSON.stringify(invertibleMatrixConjugationExternalInputEntryIds)}`);
}
for (const id of invertibleMatrixConjugationExternalInputEntryIds) {
  const entry = entries.find((candidate) => candidate.id === id)!;
  const expectedSha256 = invertibleMatrixConjugationExpectedExternalInputContentSha256.get(id)!;
  try {
    assertReviewedContentFingerprint(
      id,
      entry.explanationGranularityReview.inspectedContentSha256,
      expectedSha256,
    );
  } catch {
    throw new Error(`可逆行列と共役写像の節候補の外部入力本文が変わりました: ${id}`);
  }
}
function validateReviewedSection(
  sectionName: string,
  expectedChapter: FinalChapter,
  sectionEntryIds: readonly string[],
  expectedInternalDependencies: Map<string, string[]>,
  expectedContentSha256: Map<string, string>,
  expectedExternalInputEntryIds: string[],
  expectedExternalInputContentSha256: Map<string, string>,
  expectedTerminalEntryIds: string[],
) {
  const sectionIdSet = new Set(sectionEntryIds);
  const sectionEntries = sectionEntryIds.map((id) => {
    const entry = entries.find((candidate) => candidate.id === id);
    if (entry === undefined) throw new Error(`${sectionName}の節候補に必要な項目がありません: ${id}`);
    if (entry.provisionalFinalChapter !== expectedChapter) {
      throw new Error(`${sectionName}の節候補が${expectedChapter}にありません: ${id}`);
    }
    const actualInternalDependencies = entry.dependsOnEntryIds
      .filter((dependencyId) => sectionIdSet.has(dependencyId))
      .sort();
    const expected = [...expectedInternalDependencies.get(id)!].sort();
    if (JSON.stringify(actualInternalDependencies) !== JSON.stringify(expected)) {
      throw new Error(`${sectionName}の節候補の内部依存辺が変わりました: ${id}: ${JSON.stringify(actualInternalDependencies)}`);
    }
    if (entry.explanationGranularityReview.inspectedContentSha256 !== expectedContentSha256.get(id)) {
      throw new Error(`${sectionName}の節候補のレビュー済み本文が変わりました: ${id}: ${JSON.stringify({
        actual: entry.explanationGranularityReview.inspectedContentSha256,
        expected: expectedContentSha256.get(id),
      })}`);
    }
    return entry;
  });
  const sectionOrders = sectionEntries.map((entry) => entry.dependencyPlacement!.chapterOrder);
  if (!sectionOrders.every((chapterOrder, index) =>
    index === 0 || chapterOrder === sectionOrders[index - 1]! + 1)) {
    throw new Error(`${sectionName}の節候補が章内依存順の連続区間ではありません: ${JSON.stringify(sectionOrders)}`);
  }
  const internalDependencyTargets = new Set([...expectedInternalDependencies.values()].flat());
  const terminalEntryIds = sectionEntryIds.filter((id) => !internalDependencyTargets.has(id));
  if (JSON.stringify(terminalEntryIds) !== JSON.stringify(expectedTerminalEntryIds)) {
    throw new Error(`${sectionName}の節候補が期待する節末出力へ閉じていません: ${JSON.stringify(terminalEntryIds)}`);
  }
  const externalInputEntryIds = [...new Set(
    sectionEntries.flatMap((entry) => entry.dependsOnEntryIds)
      .filter((id) => !sectionIdSet.has(id)),
  )].sort((a, b) => order.get(a)!.chapterOrder - order.get(b)!.chapterOrder);
  if (JSON.stringify([...externalInputEntryIds].sort()) !== JSON.stringify(expectedExternalInputEntryIds)) {
    throw new Error(`${sectionName}の節候補の外部入力が変わりました: ${JSON.stringify(externalInputEntryIds)}`);
  }
  for (const id of externalInputEntryIds) {
    const entry = entries.find((candidate) => candidate.id === id)!;
    if (entry.explanationGranularityReview.inspectedContentSha256 !== expectedExternalInputContentSha256.get(id)) {
      throw new Error(`${sectionName}の節候補の外部入力本文が変わりました: ${id}: ${JSON.stringify({
        actual: entry.explanationGranularityReview.inspectedContentSha256,
        expected: expectedExternalInputContentSha256.get(id),
      })}`);
    }
  }
  return { sectionEntries, externalInputEntryIds };
}
function validateNextIsingBoundaryComparison() {
  for (const id of nextIsingBoundaryComparisonEntryIds) {
    const entry = entries.find((candidate) => candidate.id === id);
    if (entry === undefined) throw new Error(`次のイジング節境界の比較対象がありません: ${id}`);
    if (entry.provisionalFinalChapter !== "2次元イジングモデル") {
      throw new Error(`次のイジング節境界の比較対象が2次元イジングモデル章にありません: ${id}`);
    }
    if (entry.dependencyPlacement!.chapterOrder !== nextIsingBoundaryComparisonExpectedChapterOrders.get(id)) {
      throw new Error(`次のイジング節境界の比較対象の章内依存順が変わりました: ${id}: ${entry.dependencyPlacement!.chapterOrder}`);
    }
    const actualDependencies = [...entry.dependsOnEntryIds].sort();
    const expectedDependencies = [...nextIsingBoundaryComparisonExpectedDependencies.get(id)!].sort();
    if (JSON.stringify(actualDependencies) !== JSON.stringify(expectedDependencies)) {
      throw new Error(`次のイジング節境界の比較対象の直接依存が変わりました: ${id}: ${JSON.stringify(actualDependencies)}`);
    }
    if (entry.explanationGranularityReview.inspectedContentSha256
      !== nextIsingBoundaryComparisonExpectedContentSha256.get(id)) {
      throw new Error(`次のイジング節境界の比較対象本文が変わりました: ${id}`);
    }
  }
  const comparisonInputIds = [...new Set(
    [...nextIsingBoundaryComparisonExpectedDependencies.values()].flat(),
  )];
  for (const id of comparisonInputIds) {
    const entry = entries.find((candidate) => candidate.id === id);
    if (entry === undefined) throw new Error(`次のイジング節境界の比較対象の外部入力がありません: ${id}`);
    if (entry.explanationGranularityReview.inspectedContentSha256
      !== nextIsingBoundaryComparisonExpectedInputContentSha256.get(id)) {
      throw new Error(`次のイジング節境界の比較対象の外部入力本文が変わりました: ${id}`);
    }
  }
}
validateNextIsingBoundaryComparison();
const pauliAndCliffordMatrixGroupsSection = validateReviewedSection(
  "Pauli 行列と共役で保たれる行列群",
  "数学的道具立て",
  pauliAndCliffordMatrixGroupsSectionEntryIds,
  pauliAndCliffordMatrixGroupsExpectedInternalDependencies,
  pauliAndCliffordMatrixGroupsExpectedContentSha256,
  pauliAndCliffordMatrixGroupsExpectedExternalInputEntryIds,
  pauliAndCliffordMatrixGroupsExpectedExternalInputContentSha256,
  ["TV1_hatZ_hatY_010_definition_clifford_group"],
);
const singleFactorAnticommutationSection = validateReviewedSection(
  "一因子の反可換性から得るクロネッカー積の反交換",
  "数学的道具立て",
  singleFactorAnticommutationSectionEntryIds,
  singleFactorAnticommutationExpectedInternalDependencies,
  singleFactorAnticommutationExpectedContentSha256,
  singleFactorAnticommutationExpectedExternalInputEntryIds,
  singleFactorAnticommutationExpectedExternalInputContentSha256,
  ["Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site"],
);
const isingModelDefinitionSection = validateReviewedSection(
  "格子と転送行列の定義",
  "2次元イジングモデル",
  isingModelDefinitionSectionEntryIds,
  isingModelDefinitionExpectedInternalDependencies,
  isingModelDefinitionExpectedContentSha256,
  isingModelDefinitionExpectedExternalInputEntryIds,
  isingModelDefinitionExpectedExternalInputContentSha256,
  ["partition_function_2d_ising_003_definition_transfer_matrix"],
);
const isingModelDefinitionExpectedChapterOrders = [1, 2, 3];
const isingModelDefinitionActualChapterOrders = isingModelDefinitionSection.sectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (JSON.stringify(isingModelDefinitionActualChapterOrders) !== JSON.stringify(isingModelDefinitionExpectedChapterOrders)) {
  throw new Error(`格子と転送行列の定義が章内依存順1–3ではありません: ${JSON.stringify(isingModelDefinitionActualChapterOrders)}`);
}
const isingModelDefinitionUnexpectedGranularity = isingModelDefinitionSection.sectionEntries
  .filter((entry) => entry.explanationGranularityReview.status !== "自動検査で主題に適合")
  .map(({ id }) => id);
if (isingModelDefinitionUnexpectedGranularity.length > 0) {
  throw new Error(`格子と転送行列の定義に説明粒度未確認の項目があります: ${isingModelDefinitionUnexpectedGranularity.join(", ")}`);
}
const spinConfigurationBasisSection = validateReviewedSection(
  "スピン配置と標準基底の対応",
  "2次元イジングモデル",
  spinConfigurationBasisSectionEntryIds,
  spinConfigurationBasisExpectedInternalDependencies,
  spinConfigurationBasisExpectedContentSha256,
  spinConfigurationBasisExpectedExternalInputEntryIds,
  spinConfigurationBasisExpectedExternalInputContentSha256,
  ["bridge_001_definition_config_basis"],
);
const spinConfigurationBasisActualChapterOrders = spinConfigurationBasisSection.sectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (JSON.stringify(spinConfigurationBasisActualChapterOrders) !== JSON.stringify([4])) {
  throw new Error(`スピン配置と標準基底の対応が章内依存順4ではありません: ${JSON.stringify(spinConfigurationBasisActualChapterOrders)}`);
}
const spinConfigurationBasisUnexpectedGranularity = spinConfigurationBasisSection.sectionEntries
  .filter((entry) => entry.explanationGranularityReview.status !== "自動検査で主題に適合")
  .map(({ id }) => id);
if (spinConfigurationBasisUnexpectedGranularity.length > 0) {
  throw new Error(`スピン配置と標準基底の対応に説明粒度未確認の項目があります: ${spinConfigurationBasisUnexpectedGranularity.join(", ")}`);
}
const firstOpenChainEntry = entries.find((entry) => entry.id === "closing_005_definition_open_chain_spin_energy")!;
if (firstOpenChainEntry.dependencyPlacement!.chapterOrder !== 5) {
  throw new Error(`スピン配置と標準基底の対応の次項が章内依存順5ではありません: ${firstOpenChainEntry.dependencyPlacement!.chapterOrder}`);
}
if (JSON.stringify([...firstOpenChainEntry.dependsOnEntryIds].sort()) !== JSON.stringify([
  "calculation_formulae_definition_set_and_algebra_notation",
  "partition_function_2d_ising_003_definition_transfer_matrix",
])) {
  throw new Error(`スピン配置と標準基底の対応の次項の直接依存が変わりました: ${JSON.stringify(firstOpenChainEntry.dependsOnEntryIds)}`);
}
if (firstOpenChainEntry.dependsOnEntryIds.includes("bridge_001_definition_config_basis")) {
  throw new Error("スピン配置と標準基底の対応の次項から前節への依存が生じました");
}
if (firstOpenChainEntry.explanationGranularityReview.inspectedContentSha256
  !== openChainSpinSumsExpectedContentSha256.get("closing_005_definition_open_chain_spin_energy")) {
  throw new Error("スピン配置と標準基底の対応の次項本文が変わりました");
}
const openChainSpinSumsSection = validateReviewedSection(
  "1次元開鎖のスピン和",
  "2次元イジングモデル",
  openChainSpinSumsSectionEntryIds,
  openChainSpinSumsExpectedInternalDependencies,
  openChainSpinSumsExpectedContentSha256,
  openChainSpinSumsExpectedExternalInputEntryIds,
  openChainSpinSumsExpectedExternalInputContentSha256,
  ["closing_005_claim_open_chain_spin_sums_positive"],
);
const openChainSpinSumsActualChapterOrders = openChainSpinSumsSection.sectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (JSON.stringify(openChainSpinSumsActualChapterOrders) !== JSON.stringify([5, 6, 7, 8])) {
  throw new Error(`1次元開鎖のスピン和が章内依存順5–8ではありません: ${JSON.stringify(openChainSpinSumsActualChapterOrders)}`);
}
const openChainSpinSumsUnexpectedGranularity = openChainSpinSumsSection.sectionEntries
  .filter((entry) => entry.explanationGranularityReview.status !== "自動検査で主題に適合")
  .map(({ id }) => id);
if (openChainSpinSumsUnexpectedGranularity.length > 0) {
  throw new Error(`1次元開鎖のスピン和に説明粒度未確認の項目があります: ${openChainSpinSumsUnexpectedGranularity.join(", ")}`);
}
const openChainSpinSumsSectionIdSet = new Set<string>(openChainSpinSumsSectionEntryIds);
for (const nextEntryId of [
  "partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix",
  "transfer_matrix_001_definition_symbols",
]) {
  const nextEntry = entries.find((entry) => entry.id === nextEntryId)!;
  const dependenciesOnOpenChainSection = nextEntry.dependsOnEntryIds
    .filter((dependencyId) => openChainSpinSumsSectionIdSet.has(dependencyId));
  if (dependenciesOnOpenChainSection.length > 0) {
    throw new Error(`1次元開鎖のスピン和の次の項目から節内への依存が生じました: ${nextEntryId}: ${JSON.stringify(dependenciesOnOpenChainSection)}`);
  }
}
const partitionFunctionTraceSection = validateReviewedSection(
  "分配関数の転送行列表示",
  "2次元イジングモデル",
  partitionFunctionTraceSectionEntryIds,
  partitionFunctionTraceExpectedInternalDependencies,
  partitionFunctionTraceExpectedContentSha256,
  partitionFunctionTraceExpectedExternalInputEntryIds,
  partitionFunctionTraceExpectedExternalInputContentSha256,
  ["partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix"],
);
const partitionFunctionTraceActualChapterOrders = partitionFunctionTraceSection.sectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (JSON.stringify(partitionFunctionTraceActualChapterOrders) !== JSON.stringify([9])) {
  throw new Error(`分配関数の転送行列表示が章内依存順9ではありません: ${JSON.stringify(partitionFunctionTraceActualChapterOrders)}`);
}
const partitionFunctionTraceUnexpectedGranularity = partitionFunctionTraceSection.sectionEntries
  .filter((entry) => entry.explanationGranularityReview.status !== "自動検査で主題に適合")
  .map(({ id }) => id);
if (partitionFunctionTraceUnexpectedGranularity.length > 0) {
  throw new Error(`分配関数の転送行列表示に説明粒度未確認の項目があります: ${partitionFunctionTraceUnexpectedGranularity.join(", ")}`);
}
const partitionFunctionTraceSectionIdSet = new Set<string>(partitionFunctionTraceSectionEntryIds);
for (const nextEntryId of [
  "transfer_matrix_001_definition_symbols",
  "bridge_002_claim_sigma_z_diagonal_action",
]) {
  const nextEntry = entries.find((entry) => entry.id === nextEntryId)!;
  const dependenciesOnPartitionFunctionTrace = nextEntry.dependsOnEntryIds
    .filter((dependencyId) => partitionFunctionTraceSectionIdSet.has(dependencyId));
  if (dependenciesOnPartitionFunctionTrace.length > 0) {
    throw new Error(`分配関数の転送行列表示の次の項目から節内への依存が生じました: ${nextEntryId}: ${JSON.stringify(dependenciesOnPartitionFunctionTrace)}`);
  }
}
const v1PauliRepresentationSection = validateReviewedSection(
  "V1 のパウリ行列表示",
  "2次元イジングモデル",
  v1PauliRepresentationSectionEntryIds,
  v1PauliRepresentationExpectedInternalDependencies,
  v1PauliRepresentationExpectedContentSha256,
  v1PauliRepresentationExpectedExternalInputEntryIds,
  v1PauliRepresentationExpectedExternalInputContentSha256,
  ["bridge_004_claim_V1_component_equals_pauli"],
);
const v1PauliRepresentationActualChapterOrders = v1PauliRepresentationSection.sectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (JSON.stringify(v1PauliRepresentationActualChapterOrders) !== JSON.stringify([10, 11, 12])) {
  throw new Error(`V1 のパウリ行列表示が章内依存順10–12ではありません: ${JSON.stringify(v1PauliRepresentationActualChapterOrders)}`);
}
for (const entry of v1PauliRepresentationSection.sectionEntries) {
  const actualDependencies = [...entry.dependsOnEntryIds].sort();
  const expectedDependencies = [...v1PauliRepresentationExpectedDirectDependencies.get(entry.id)!].sort();
  if (JSON.stringify(actualDependencies) !== JSON.stringify(expectedDependencies)) {
    throw new Error(`V1 のパウリ行列表示の直接依存が変わりました: ${entry.id}: ${JSON.stringify(actualDependencies)}`);
  }
}
const v1PauliRepresentationUnresolvedGranularity = v1PauliRepresentationSection.sectionEntries
  .filter((entry) => entry.explanationGranularityReview.status !== "自動検査で主題に適合")
  .map(({ id }) => id);
if (JSON.stringify(v1PauliRepresentationUnresolvedGranularity)
  !== JSON.stringify(["transfer_matrix_001_definition_symbols"])) {
  throw new Error(`V1 のパウリ行列表示の説明粒度判定が変わりました: ${JSON.stringify(v1PauliRepresentationUnresolvedGranularity)}`);
}
const v1PauliRepresentationUnresolvedExternalInputGranularity = v1PauliRepresentationSection.externalInputEntryIds
  .map((id) => entries.find((entry) => entry.id === id)!)
  .filter((entry) => entry.explanationGranularityReview.status !== "自動検査で主題に適合")
  .map(({ id }) => id);
if (JSON.stringify(v1PauliRepresentationUnresolvedExternalInputGranularity) !== JSON.stringify([
  "calculation_formulae_definition_set_and_algebra_notation",
  "calc_formulae_006_definition_of_cc",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "transfer_matrix_005_definition_end_isomorphism",
])) {
  throw new Error(`V1 のパウリ行列表示の外部入力の説明粒度判定が変わりました: ${JSON.stringify(v1PauliRepresentationUnresolvedExternalInputGranularity)}`);
}
const v1PauliRepresentationSectionIdSet = new Set<string>(v1PauliRepresentationSectionEntryIds);
for (const [nextEntryId, expectedDependenciesOnSection] of [
  ["bridge_005_claim_two_by_two_transfer_identity", ["transfer_matrix_001_definition_symbols"]],
  ["bridge_006_claim_V2_component_equals_pauli", ["transfer_matrix_001_definition_symbols"]],
  ["bridge_007_claim_partition_function_in_pauli_form", ["bridge_004_claim_V1_component_equals_pauli", "transfer_matrix_001_definition_symbols"]],
] as const) {
  const nextEntry = entries.find((entry) => entry.id === nextEntryId)!;
  const dependenciesOnV1PauliRepresentation = nextEntry.dependsOnEntryIds
    .filter((dependencyId) => v1PauliRepresentationSectionIdSet.has(dependencyId));
  if (JSON.stringify(dependenciesOnV1PauliRepresentation) !== JSON.stringify(expectedDependenciesOnSection)) {
    throw new Error(`V1 のパウリ行列表示の次の項目から節内への依存が変わりました: ${nextEntryId}: ${JSON.stringify(dependenciesOnV1PauliRepresentation)}`);
  }
}
const v2PauliPartitionFunctionSection = validateReviewedSection(
  "V2 のパウリ行列表示と分配関数への接続",
  "2次元イジングモデル",
  v2PauliPartitionFunctionSectionEntryIds,
  v2PauliPartitionFunctionExpectedInternalDependencies,
  nextIsingBoundaryComparisonExpectedContentSha256,
  v2PauliPartitionFunctionExpectedExternalInputEntryIds,
  nextIsingBoundaryComparisonExpectedInputContentSha256,
  ["bridge_007_claim_partition_function_in_pauli_form"],
);
const v2PauliPartitionFunctionActualChapterOrders = v2PauliPartitionFunctionSection.sectionEntries
  .map((entry) => entry.dependencyPlacement!.chapterOrder);
if (JSON.stringify(v2PauliPartitionFunctionActualChapterOrders) !== JSON.stringify([13, 14, 15])) {
  throw new Error(`V2 のパウリ行列表示と分配関数への接続が章内依存順13–15ではありません: ${JSON.stringify(v2PauliPartitionFunctionActualChapterOrders)}`);
}
const v2PauliPartitionFunctionUnexpectedGranularity = v2PauliPartitionFunctionSection.sectionEntries
  .filter((entry) => entry.explanationGranularityReview.status !== "自動検査で主題に適合")
  .map(({ id }) => id);
if (v2PauliPartitionFunctionUnexpectedGranularity.length > 0) {
  throw new Error(`V2 のパウリ行列表示と分配関数への接続に説明粒度未確認の項目があります: ${v2PauliPartitionFunctionUnexpectedGranularity.join(", ")}`);
}
const epsilonProjectorsEntry = entries.find((entry) => entry.id === "bridge_008_definition_epsilon_projectors")!;
if (epsilonProjectorsEntry.dependencyPlacement!.chapterOrder !== 16
  || JSON.stringify([...epsilonProjectorsEntry.dependsOnEntryIds].sort()) !== JSON.stringify([
    "calc_formulae_006_definition_of_cc",
    "transfer_matrix_001_definition_symbols",
  ])) {
  throw new Error(`V2 のパウリ行列表示と分配関数への接続の次項が変わりました: ${JSON.stringify({
    chapterOrder: epsilonProjectorsEntry.dependencyPlacement!.chapterOrder,
    dependencies: epsilonProjectorsEntry.dependsOnEntryIds,
  })}`);
}
if (epsilonProjectorsEntry.explanationGranularityReview.inspectedContentSha256
  !== "be5003446b4cb92b2911fb88cee1a7cc85dd13f412c3207866e1f70d987c4890") {
  throw new Error("V2 のパウリ行列表示と分配関数への接続の次項本文が変わりました");
}
const v2PauliPartitionFunctionSectionIdSet = new Set<string>(v2PauliPartitionFunctionSectionEntryIds);
const epsilonProjectorDependenciesOnPreviousSection = epsilonProjectorsEntry.dependsOnEntryIds
  .filter((id) => v2PauliPartitionFunctionSectionIdSet.has(id));
if (epsilonProjectorDependenciesOnPreviousSection.length > 0) {
  throw new Error(`射影子の定義から直前節への依存が生じました: ${JSON.stringify(epsilonProjectorDependenciesOnPreviousSection)}`);
}
const epsilonProjectorDefinitionSection = validateReviewedSection(
  "全スピン反転行列から定める二つの行列",
  "2次元イジングモデル",
  epsilonProjectorDefinitionSectionEntryIds,
  epsilonProjectorDefinitionExpectedInternalDependencies,
  epsilonProjectorDefinitionExpectedContentSha256,
  epsilonProjectorDefinitionExpectedExternalInputEntryIds,
  epsilonProjectorDefinitionExpectedExternalInputContentSha256,
  ["bridge_008_definition_epsilon_projectors"],
);
if (epsilonProjectorDefinitionSection.sectionEntries[0]!.dependencyPlacement!.chapterOrder !== 16) {
  throw new Error("全スピン反転行列から定める二つの行列が章内依存順16ではありません");
}
const kappaDefinitionSection = validateReviewedSection(
  "臨界条件からの差を表す実数",
  "2次元イジングモデル",
  kappaDefinitionSectionEntryIds,
  kappaDefinitionExpectedInternalDependencies,
  kappaDefinitionExpectedContentSha256,
  kappaDefinitionExpectedExternalInputEntryIds,
  kappaDefinitionExpectedExternalInputContentSha256,
  ["critical_002_definition_kappa"],
);
const criticalSinhProductDefinitionSection = validateReviewedSection(
  "二つの双曲線正弦の積",
  "2次元イジングモデル",
  criticalSinhProductDefinitionSectionEntryIds,
  criticalSinhProductDefinitionExpectedInternalDependencies,
  criticalSinhProductDefinitionExpectedContentSha256,
  criticalSinhProductDefinitionExpectedExternalInputEntryIds,
  criticalSinhProductDefinitionExpectedExternalInputContentSha256,
  ["critical_002a_definition_critical_sinh_product_A"],
);
const kappaDefinitionEntry = kappaDefinitionSection.sectionEntries[0]!;
const criticalSinhProductDefinitionEntry = criticalSinhProductDefinitionSection.sectionEntries[0]!;
const symmetrizedTransferMatrixSection = validateReviewedSection(
  "転送行列の平方根・対称化転送行列・トレース公式",
  "2次元イジングモデル",
  symmetrizedTransferMatrixSectionEntryIds,
  symmetrizedTransferMatrixExpectedInternalDependencies,
  symmetrizedTransferMatrixExpectedContentSha256,
  symmetrizedTransferMatrixExpectedExternalInputEntryIds,
  symmetrizedTransferMatrixExpectedExternalInputContentSha256,
  ["maxeig_002_claim_Z_equals_trace_of_W"],
);
const positiveSymmetrizedTransferMatrixEntriesSection = validateReviewedSection(
  "対称化転送行列の全成分正値性",
  "2次元イジングモデル",
  positiveSymmetrizedTransferMatrixEntriesSectionEntryIds,
  positiveSymmetrizedTransferMatrixEntriesExpectedInternalDependencies,
  positiveSymmetrizedTransferMatrixEntriesExpectedContentSha256,
  positiveSymmetrizedTransferMatrixEntriesExpectedExternalInputEntryIds,
  positiveSymmetrizedTransferMatrixEntriesExpectedExternalInputContentSha256,
  ["maxeig_004_claim_W_has_positive_entries"],
);
const zYLinearIndependenceSection = validateReviewedSection(
  "Jordan–Wigner 行列の線型独立性",
  "2次元イジングモデル",
  zYLinearIndependenceSectionEntryIds,
  zYLinearIndependenceExpectedInternalDependencies,
  zYLinearIndependenceExpectedContentSha256,
  zYLinearIndependenceExpectedExternalInputEntryIds,
  zYLinearIndependenceExpectedExternalInputContentSha256,
  ["transfer_matrix_002_claim_Z_Y_linearly_independent"],
);
const v1V2JordanWignerSection = validateReviewedSection(
  "V1・V2 の Jordan–Wigner 行列表示",
  "2次元イジングモデル",
  v1V2JordanWignerSectionEntryIds,
  v1V2JordanWignerExpectedInternalDependencies,
  v1V2JordanWignerExpectedContentSha256,
  v1V2JordanWignerExpectedExternalInputEntryIds,
  v1V2JordanWignerExpectedExternalInputContentSha256,
  ["transfer_matrix_003_claim_V1_in_Z_Y_epsilon", "transfer_matrix_003a_claim_V2_in_Z_Y"],
);
const epsilonEigenspacesAndComplementaryProjectorsSection = validateReviewedSection(
  "全スピン反転行列の固有空間と相補射影",
  "2次元イジングモデル",
  epsilonEigenspacesAndComplementaryProjectorsSectionEntryIds,
  epsilonEigenspacesAndComplementaryProjectorsExpectedInternalDependencies,
  epsilonEigenspacesAndComplementaryProjectorsExpectedContentSha256,
  epsilonEigenspacesAndComplementaryProjectorsExpectedExternalInputEntryIds,
  epsilonEigenspacesAndComplementaryProjectorsExpectedExternalInputContentSha256,
  ["bridge_009_claim_epsilon_projector_properties"],
);
const v1RestrictionToEigenspacesSection = validateReviewedSection(
  "V1 の固有空間への制限",
  "2次元イジングモデル",
  v1RestrictionToEigenspacesSectionEntryIds,
  v1RestrictionToEigenspacesExpectedInternalDependencies,
  v1RestrictionToEigenspacesSectionExpectedContentSha256,
  v1RestrictionToEigenspacesExpectedDirectDependencies,
  v1RestrictionToEigenspacesExpectedExternalInputContentSha256,
  ["transfer_matrix_006_claim_V1_restriction_to_eigenspaces"],
);
const v1PlusMinusAndCommutationSection = validateReviewedSection(
  "境界項の符号を固定した指数行列と全スピン反転対称性",
  "2次元イジングモデル",
  v1PlusMinusAndCommutationSectionEntryIds,
  v1PlusMinusAndCommutationExpectedInternalDependencies,
  v1PlusMinusAndCommutationExpectedContentSha256,
  v1PlusMinusAndCommutationExpectedExternalInputEntryIds,
  v1PlusMinusAndCommutationExpectedExternalInputContentSha256,
  ["bridge_011a_claim_sector_replacement_pow"],
);
const realSymmetricGeneratorsAndSignFlipSection = validateReviewedSection(
  "実対称な生成子と符号反転共役",
  "2次元イジングモデル",
  realSymmetricGeneratorsAndSignFlipSectionEntryIds,
  realSymmetricGeneratorsAndSignFlipExpectedInternalDependencies,
  realSymmetricGeneratorsAndSignFlipExpectedContentSha256,
  realSymmetricGeneratorsAndSignFlipExpectedExternalInputEntryIds,
  realSymmetricGeneratorsAndSignFlipExpectedExternalInputContentSha256,
  ["eigenvalues_of_V_016_claim_sign_flip_conjugation"],
);
const evenSectorGeneratorSection = validateReviewedSection(
  "偶セクター生成子のスピン作用素表示",
  "2次元イジングモデル",
  evenSectorGeneratorSectionEntryIds,
  evenSectorGeneratorExpectedInternalDependencies,
  evenSectorGeneratorExpectedContentSha256,
  evenSectorGeneratorExpectedExternalInputEntryIds,
  evenSectorGeneratorExpectedExternalInputContentSha256,
  [
    "closing_004_claim_H1_plus_in_sigma_z_form",
    "closing_claim_D0_G_diagonal_action",
    "closing_claim_epsilon_G_is_involution",
  ],
);
const v1PlusHalfExponentAndSquareRootSection = validateReviewedSection(
  "偶セクターの半指数行列と平方根性",
  "2次元イジングモデル",
  v1PlusHalfExponentAndSquareRootSectionEntryIds,
  v1PlusHalfExponentAndSquareRootExpectedInternalDependencies,
  v1PlusHalfExponentAndSquareRootExpectedContentSha256,
  v1PlusHalfExponentAndSquareRootExpectedExternalInputEntryIds,
  v1PlusHalfExponentAndSquareRootExpectedExternalInputContentSha256,
  ["evensectorT_claim_V1_plus_square_root"],
);
const vPlusDefinitionAndSignedTraceSection = validateReviewedSection(
  "偶セクター転送行列と符号付きトレースの正値公式",
  "2次元イジングモデル",
  vPlusDefinitionAndSignedTraceSectionEntryIds,
  vPlusDefinitionAndSignedTraceExpectedInternalDependencies,
  vPlusDefinitionAndSignedTraceExpectedContentSha256,
  vPlusDefinitionAndSignedTraceExpectedExternalInputEntryIds,
  vPlusDefinitionAndSignedTraceExpectedExternalInputContentSha256,
  ["closing_006_theorem_trace_of_epsilon_V_plus"],
);
const vPlusPositiveDefiniteSection = validateReviewedSection(
  "偶セクター転送行列の正定値性・可逆性とトレース正値性",
  "2次元イジングモデル",
  vPlusPositiveDefiniteSectionEntryIds,
  vPlusPositiveDefiniteExpectedInternalDependencies,
  vPlusPositiveDefiniteSectionExpectedContentSha256,
  vPlusPositiveDefiniteExpectedExternalInputEntryIds,
  vPlusPositiveDefiniteExpectedExternalInputContentSha256,
  [
    "evenEigen_claim_trace_V_plus_is_positive",
    "evenEigen_claim_V_plus_inverse_positive_and_traces",
  ],
);
const positiveSymmetrizedTransferMatrixEntriesEntry = positiveSymmetrizedTransferMatrixEntriesSection.sectionEntries[0]!;
const zYLinearIndependenceEntry = zYLinearIndependenceSection.sectionEntries[0]!;
const epsilonEigenspacesEntry = epsilonEigenspacesAndComplementaryProjectorsSection.sectionEntries[0]!;
const epsilonSquareAndEigenvaluesEntry = epsilonEigenspacesAndComplementaryProjectorsSection.sectionEntries[1]!;
const epsilonProjectorPropertiesEntry = epsilonEigenspacesAndComplementaryProjectorsSection.sectionEntries[2]!;
const v1RestrictionToEigenspacesEntry = v1RestrictionToEigenspacesSection.sectionEntries[0]!;
const v1PlusMinusDefinitionEntry = v1PlusMinusAndCommutationSection.sectionEntries[0]!;
const sectorReplacementEntry = v1PlusMinusAndCommutationSection.sectionEntries[1]!;
const v1PlusMinusSquareRootDefinitionEntry = v1PlusMinusAndCommutationSection.sectionEntries[2]!;
const v1PlusMinusSquareRootClaimEntry = v1PlusMinusAndCommutationSection.sectionEntries[3]!;
const epsilonCommutationEntry = v1PlusMinusAndCommutationSection.sectionEntries[4]!;
const epsilonProjectorCommutationEntry = v1PlusMinusAndCommutationSection.sectionEntries[5]!;
const sectorReplacementPowerEntry = v1PlusMinusAndCommutationSection.sectionEntries[6]!;
const realSymmetricGeneratorsEntry = realSymmetricGeneratorsAndSignFlipSection.sectionEntries[0]!;
const signFlipConjugationEntry = realSymmetricGeneratorsAndSignFlipSection.sectionEntries[1]!;
const evenSectorGeneratorDefinitionEntry = evenSectorGeneratorSection.sectionEntries[0]!;
const positiveDefiniteSymmetrizedTransferMatrixEntry = entries.find((entry) =>
  entry.id === "maxeig_003_claim_W_is_positive_definite")!;
const evenSectorOpenChainDefinitionEntry = evenSectorGeneratorSection.sectionEntries[1]!;
const evenSectorBoundaryDefinitionEntry = evenSectorGeneratorSection.sectionEntries[2]!;
const evenSectorGeneratorSpinFormEntry = evenSectorGeneratorSection.sectionEntries[3]!;
const evenSectorGeneratorDiagonalActionEntry = evenSectorGeneratorSection.sectionEntries[4]!;
const evenSectorGeneratorPairwiseCommutationEntry = evenSectorGeneratorSection.sectionEntries[5]!;
const evenSectorGeneratorInvolutionEntry = evenSectorGeneratorSection.sectionEntries[6]!;
const v1PlusSquareRootDefinitionEntry = entries.find((entry) =>
  entry.id === "evensectorT_definition_V1_plus_square_root")!;
const v1PlusSquareRootClaimEntry = v1PlusHalfExponentAndSquareRootSection.sectionEntries[1]!;
const vPlusDefinitionEntry = vPlusDefinitionAndSignedTraceSection.sectionEntries[0]!;
const signedTraceOfVPlusEntry = vPlusDefinitionAndSignedTraceSection.sectionEntries[1]!;
const vPlusPositiveDefiniteEntry = vPlusPositiveDefiniteSection.sectionEntries[0]!;
const traceVPlusPositiveEntry = vPlusPositiveDefiniteSection.sectionEntries[1]!;
const vPlusInvertibleEntry = vPlusPositiveDefiniteSection.sectionEntries[2]!;
const vPlusInversePositiveDefiniteEntry = vPlusPositiveDefiniteSection.sectionEntries[3]!;
const vPlusInversePositiveAndTracesEntry = vPlusPositiveDefiniteSection.sectionEntries[4]!;
const v1PlusHalfInvertibleEntry = entries.find((entry) =>
  entry.id === "evensectorT_claim_V1_plus_half_invertible")!;
const vTwoInvertibleEntry = entries.find((entry) =>
  entry.id === "evensectorT_claim_V2_invertible")!;
const vPlusFactorsInvertibleEntry = entries.find((entry) =>
  entry.id === "evensectorT_claim_V_plus_factors_invertible")!;
const conjugationLinearityEntry = entries.find((entry) =>
  entry.id === "evensectorT_006_claim_linearity_of_T")!;
if (kappaDefinitionEntry.dependencyPlacement!.chapterOrder !== 17
  || criticalSinhProductDefinitionEntry.dependencyPlacement!.chapterOrder !== 18
  || symmetrizedTransferMatrixSection.sectionEntries[0]!.dependencyPlacement!.chapterOrder !== 19
  || symmetrizedTransferMatrixSection.sectionEntries[1]!.dependencyPlacement!.chapterOrder !== 20
  || symmetrizedTransferMatrixSection.sectionEntries[2]!.dependencyPlacement!.chapterOrder !== 21
  || positiveSymmetrizedTransferMatrixEntriesEntry.dependencyPlacement!.chapterOrder !== 22
  || zYLinearIndependenceEntry.dependencyPlacement!.chapterOrder !== 23
  || v1V2JordanWignerSection.sectionEntries[0]!.dependencyPlacement!.chapterOrder !== 24
  || v1V2JordanWignerSection.sectionEntries[1]!.dependencyPlacement!.chapterOrder !== 25
  || epsilonEigenspacesEntry.dependencyPlacement!.chapterOrder !== 26
  || epsilonSquareAndEigenvaluesEntry.dependencyPlacement!.chapterOrder !== 27
  || epsilonProjectorPropertiesEntry.dependencyPlacement!.chapterOrder !== 28
  || v1RestrictionToEigenspacesEntry.dependencyPlacement!.chapterOrder !== 29) {
  throw new Error(`臨界条件用実数から V1 の固有空間への制限までの章内順が変わりました: ${JSON.stringify({
    kappaOrder: kappaDefinitionEntry.dependencyPlacement!.chapterOrder,
    criticalSinhProductOrder: criticalSinhProductDefinitionEntry.dependencyPlacement!.chapterOrder,
    sectionOrders: symmetrizedTransferMatrixSection.sectionEntries.map((entry) => entry.dependencyPlacement!.chapterOrder),
    positiveEntriesOrder: positiveSymmetrizedTransferMatrixEntriesEntry.dependencyPlacement!.chapterOrder,
    zYLinearIndependenceOrder: zYLinearIndependenceEntry.dependencyPlacement!.chapterOrder,
    v1V2JordanWignerOrders: v1V2JordanWignerSection.sectionEntries.map((entry) => entry.dependencyPlacement!.chapterOrder),
    epsilonSectionOrders: epsilonEigenspacesAndComplementaryProjectorsSection.sectionEntries.map(
      (entry) => entry.dependencyPlacement!.chapterOrder,
    ),
    v1RestrictionToEigenspacesOrder: v1RestrictionToEigenspacesEntry.dependencyPlacement!.chapterOrder,
  })}`);
}
if (zYLinearIndependenceEntry.dependsOnEntryIds.includes("maxeig_004_claim_W_has_positive_entries")
  || positiveSymmetrizedTransferMatrixEntriesEntry.dependsOnEntryIds.includes("transfer_matrix_002_claim_Z_Y_linearly_independent")) {
  throw new Error("対称化転送行列の全成分正値性と Z_m,Y_m の線型独立性との節境界が変わりました");
}
const positiveEntriesExternalInputSet = new Set(positiveSymmetrizedTransferMatrixEntriesSection.externalInputEntryIds);
const sharedInputsWithZYLinearIndependence = zYLinearIndependenceEntry.dependsOnEntryIds
  .filter((id) => positiveEntriesExternalInputSet.has(id));
if (sharedInputsWithZYLinearIndependence.length > 0) {
  throw new Error(`対称化転送行列の全成分正値性と Z_m,Y_m の線型独立性の入力集合が重なりました: ${sharedInputsWithZYLinearIndependence.join(", ")}`);
}
if (v1V2JordanWignerSection.sectionEntries.some((entry) =>
  entry.dependsOnEntryIds.includes("transfer_matrix_002_claim_Z_Y_linearly_independent"))
  || v1V2JordanWignerSection.sectionEntries.some((entry) =>
    zYLinearIndependenceEntry.dependsOnEntryIds.includes(entry.id))) {
  throw new Error("Jordan–Wigner 行列の線型独立性と V1,V2 の Jordan–Wigner 行列表示との節境界が変わりました");
}
const zYLinearIndependenceExternalInputSet = new Set(zYLinearIndependenceSection.externalInputEntryIds);
const inputsAddedForV1V2JordanWigner = v1V2JordanWignerSection.externalInputEntryIds
  .filter((id) => !zYLinearIndependenceExternalInputSet.has(id));
const inputsDroppedAfterZYLinearIndependence = zYLinearIndependenceSection.externalInputEntryIds
  .filter((id) => !v1V2JordanWignerSection.externalInputEntryIds.includes(id));
if (JSON.stringify(inputsAddedForV1V2JordanWigner.sort()) !== JSON.stringify([
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "linear_space_general_000c_claim_kronecker_multilinear",
].sort())
  || JSON.stringify(inputsDroppedAfterZYLinearIndependence.sort()) !== JSON.stringify([
    "linear_space_general_001_theorem_tensor_product_basis",
  ])) {
  throw new Error(`Jordan–Wigner 行列の線型独立性の直後で入力集合の切り替わり方が変わりました: ${JSON.stringify({
    added: inputsAddedForV1V2JordanWigner,
    dropped: inputsDroppedAfterZYLinearIndependence,
  })}`);
}
if (JSON.stringify([...epsilonEigenspacesEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(epsilonEigenspacesExpectedDirectDependencies)
  || epsilonEigenspacesEntry.explanationGranularityReview.inspectedContentSha256
    !== epsilonEigenspacesExpectedContentSha256
  || v1V2JordanWignerSection.sectionEntries.some((entry) =>
    epsilonEigenspacesEntry.dependsOnEntryIds.includes(entry.id))
  || v1V2JordanWignerSection.sectionEntries.some((entry) =>
    entry.dependsOnEntryIds.includes("transfer_matrix_004_definition_eigenspaces_of_epsilon"))) {
  throw new Error("V1・V2 の Jordan–Wigner 行列表示と全スピン反転行列の固有空間との節境界が変わりました");
}
const v1V2JordanWignerExternalInputSet = new Set(v1V2JordanWignerSection.externalInputEntryIds);
const inputsAddedForEpsilonEigenspaces = epsilonEigenspacesEntry.dependsOnEntryIds
  .filter((id) => !v1V2JordanWignerExternalInputSet.has(id));
const inputsDroppedAfterV1V2JordanWigner = v1V2JordanWignerSection.externalInputEntryIds
  .filter((id) => !epsilonEigenspacesEntry.dependsOnEntryIds.includes(id));
if (JSON.stringify(inputsAddedForEpsilonEigenspaces.sort()) !== JSON.stringify([
  "transfer_matrix_005_definition_end_isomorphism",
].sort())
  || JSON.stringify(inputsDroppedAfterV1V2JordanWigner.sort()) !== JSON.stringify([
    "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
    "calculation_formulae_definition_set_and_algebra_notation",
    "linear_space_general_000b_claim_kronecker_product_rule",
    "linear_space_general_000c_claim_kronecker_multilinear",
  ].sort())) {
  throw new Error(`V1・V2 の Jordan–Wigner 行列表示の直後で入力集合の切り替わり方が変わりました: ${JSON.stringify({
    added: inputsAddedForEpsilonEigenspaces,
    dropped: inputsDroppedAfterV1V2JordanWigner,
  })}`);
}
if (JSON.stringify([...v1RestrictionToEigenspacesEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(v1RestrictionToEigenspacesExpectedDirectDependencies)
  || v1RestrictionToEigenspacesEntry.explanationGranularityReview.inspectedContentSha256
    !== v1RestrictionToEigenspacesExpectedContentSha256
  || v1RestrictionToEigenspacesEntry.dependsOnEntryIds.includes(epsilonSquareAndEigenvaluesEntry.id)
  || v1RestrictionToEigenspacesEntry.dependsOnEntryIds.includes(epsilonProjectorPropertiesEntry.id)
  || epsilonEigenspacesAndComplementaryProjectorsSection.sectionEntries.some((entry) =>
    entry.dependsOnEntryIds.includes(v1RestrictionToEigenspacesEntry.id))) {
  throw new Error("全スピン反転行列の固有空間と相補射影の節末から V1 の固有空間への制限への境界が変わりました");
}
const epsilonSectionIdSet = new Set<string>(epsilonEigenspacesAndComplementaryProjectorsSectionEntryIds);
const v1RestrictionExternalInputEntryIds = v1RestrictionToEigenspacesEntry.dependsOnEntryIds
  .filter((id) => !epsilonSectionIdSet.has(id));
const epsilonSectionExternalInputSet = new Set(
  epsilonEigenspacesAndComplementaryProjectorsSection.externalInputEntryIds,
);
const inputsAddedForV1Restriction = v1RestrictionExternalInputEntryIds
  .filter((id) => !epsilonSectionExternalInputSet.has(id));
const inputsDroppedAfterEpsilonProjectors = epsilonEigenspacesAndComplementaryProjectorsSection.externalInputEntryIds
  .filter((id) => !v1RestrictionExternalInputEntryIds.includes(id));
if (JSON.stringify(inputsAddedForV1Restriction.sort()) !== JSON.stringify([
  "Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site",
  "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
  "transfer_matrix_003_claim_V1_in_Z_Y_epsilon",
  "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
].sort())
  || JSON.stringify(inputsDroppedAfterEpsilonProjectors.sort()) !== JSON.stringify([
    "bridge_008_definition_epsilon_projectors",
    "linear_space_general_000b_claim_kronecker_product_rule",
  ].sort())) {
  throw new Error(`全スピン反転行列の相補射影の直後で入力集合の切り替わり方が変わりました: ${JSON.stringify({
    added: inputsAddedForV1Restriction,
    dropped: inputsDroppedAfterEpsilonProjectors,
  })}`);
}
if (v1PlusMinusDefinitionEntry.dependencyPlacement!.chapterOrder !== 30
  || JSON.stringify([...v1PlusMinusDefinitionEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(v1PlusMinusDefinitionExpectedDirectDependencies)
  || v1PlusMinusDefinitionEntry.explanationGranularityReview.inspectedContentSha256
    !== v1PlusMinusDefinitionExpectedContentSha256
  || v1PlusMinusDefinitionEntry.dependsOnEntryIds.includes(v1RestrictionToEigenspacesEntry.id)
  || v1RestrictionToEigenspacesEntry.dependsOnEntryIds.includes(v1PlusMinusDefinitionEntry.id)) {
  throw new Error("V1 の固有空間への制限と境界項の符号を固定した二つの指数行列 V1^{(±)} の定義との節境界が変わりました");
}
const v1RestrictionExternalInputSet = new Set(v1RestrictionToEigenspacesSection.externalInputEntryIds);
const inputsAddedForV1PlusMinusDefinition = v1PlusMinusDefinitionEntry.dependsOnEntryIds
  .filter((id) => !v1RestrictionExternalInputSet.has(id));
const inputsDroppedAfterV1Restriction = v1RestrictionToEigenspacesSection.externalInputEntryIds
  .filter((id) => !v1PlusMinusDefinitionEntry.dependsOnEntryIds.includes(id));
if (JSON.stringify(inputsAddedForV1PlusMinusDefinition.sort()) !== JSON.stringify([
  "exp_linear_map_002_definition_exp_of_endomorphism",
].sort())
  || JSON.stringify(inputsDroppedAfterV1Restriction.sort()) !== JSON.stringify([
    "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
    "Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site",
    "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "transfer_matrix_003_claim_V1_in_Z_Y_epsilon",
    "transfer_matrix_004_definition_eigenspaces_of_epsilon",
    "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
    "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
  ].sort())) {
  throw new Error(`V1 の固有空間への制限の直後で入力集合の切り替わり方が変わりました: ${JSON.stringify({
    added: inputsAddedForV1PlusMinusDefinition,
    dropped: inputsDroppedAfterV1Restriction,
  })}`);
}
if (v1PlusMinusDefinitionEntry.dependencyPlacement!.chapterOrder !== 30
  || sectorReplacementEntry.dependencyPlacement!.chapterOrder !== 31
  || v1PlusMinusSquareRootDefinitionEntry.dependencyPlacement!.chapterOrder !== 32
  || v1PlusMinusSquareRootClaimEntry.dependencyPlacement!.chapterOrder !== 33
  || epsilonCommutationEntry.dependencyPlacement!.chapterOrder !== 34
  || epsilonProjectorCommutationEntry.dependencyPlacement!.chapterOrder !== 35
  || sectorReplacementPowerEntry.dependencyPlacement!.chapterOrder !== 36
  || JSON.stringify([...sectorReplacementEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(sectorReplacementExpectedDirectDependencies)
  || sectorReplacementEntry.explanationGranularityReview.inspectedContentSha256
    !== sectorReplacementExpectedContentSha256
  || !sectorReplacementPowerEntry.dependsOnEntryIds.includes(epsilonProjectorCommutationEntry.id)
  || !sectorReplacementPowerEntry.dependsOnEntryIds.includes(sectorReplacementEntry.id)
  || sectorReplacementEntry.dependsOnEntryIds.includes(epsilonCommutationEntry.id)
  || !sectorReplacementEntry.dependsOnEntryIds.includes(v1PlusMinusDefinitionEntry.id)
  || epsilonCommutationEntry.dependsOnEntryIds.includes(sectorReplacementEntry.id)) {
  throw new Error(`境界項の符号を固定した指数行列からセクター上の置き換えの冪への依存構造が変わりました: ${JSON.stringify({
    orders: v1PlusMinusAndCommutationSection.sectionEntries.map((entry) => entry.dependencyPlacement!.chapterOrder),
    sectorReplacementDependencies: sectorReplacementEntry.dependsOnEntryIds,
    sectorReplacementPowerDependencies: sectorReplacementPowerEntry.dependsOnEntryIds,
  })}`);
}
if (realSymmetricGeneratorsEntry.dependencyPlacement!.chapterOrder
    <= sectorReplacementPowerEntry.dependencyPlacement!.chapterOrder
  || JSON.stringify([...realSymmetricGeneratorsEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(realSymmetricGeneratorsExpectedDirectDependencies)
  || realSymmetricGeneratorsEntry.explanationGranularityReview.inspectedContentSha256
    !== realSymmetricGeneratorsExpectedContentSha256
  || v1PlusMinusAndCommutationSection.sectionEntries.slice(1).some((entry) =>
    realSymmetricGeneratorsEntry.dependsOnEntryIds.includes(entry.id))
  || v1PlusMinusAndCommutationSection.sectionEntries.some((entry) =>
    entry.dependsOnEntryIds.includes(realSymmetricGeneratorsEntry.id))) {
  throw new Error(`セクター上での V1 の置き換えと二つの生成子の実対称性との節境界が変わりました: ${JSON.stringify({
    order: realSymmetricGeneratorsEntry.dependencyPlacement!.chapterOrder,
    dependencies: realSymmetricGeneratorsEntry.dependsOnEntryIds,
  })}`);
}
const sectorReplacementExternalInputSet = new Set(v1PlusMinusAndCommutationSection.externalInputEntryIds);
const inputsAddedForRealSymmetricGenerators = realSymmetricGeneratorsEntry.dependsOnEntryIds
  .filter((id) => !sectorReplacementExternalInputSet.has(id));
const inputsDroppedAfterSectorReplacement = v1PlusMinusAndCommutationSection.externalInputEntryIds
  .filter((id) => !realSymmetricGeneratorsEntry.dependsOnEntryIds.includes(id));
if (JSON.stringify(inputsAddedForRealSymmetricGenerators.sort()) !== JSON.stringify([
  "eigenvalues_of_V_011_definition_hermitian_positive_definite",
  "linear_space_general_000_definition_kronecker_product",
  "linear_space_general_000d_claim_kronecker_transpose",
  "transfer_matrix_007_definition_V1_pm",
  "transfer_matrix_011_definition_H1_H2",
].sort())
  || JSON.stringify(inputsDroppedAfterSectorReplacement.sort()) !== JSON.stringify([
    "bridge_008_definition_epsilon_projectors",
    "bridge_009_claim_epsilon_projector_properties",
    "exp_linear_map_002_definition_exp_of_endomorphism",
    "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
    "linear_space_general_002_claim_scalar_identity_commutes",
    "linear_space_general_003b_claim_matrix_multiplication_continuity",
    "transfer_matrix_005_definition_end_isomorphism",
    "transfer_matrix_006_claim_V1_restriction_to_eigenspaces",
  ].sort())) {
  throw new Error(`セクター上の置き換えの冪の直後で入力集合の切り替わり方が変わりました: ${JSON.stringify({
    added: inputsAddedForRealSymmetricGenerators,
    dropped: inputsDroppedAfterSectorReplacement,
  })}`);
}
if (signFlipConjugationEntry.dependencyPlacement!.chapterOrder
    !== realSymmetricGeneratorsEntry.dependencyPlacement!.chapterOrder + 1
  || JSON.stringify([...signFlipConjugationEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(signFlipConjugationExpectedDirectDependencies)) {
  throw new Error("実対称な生成子と符号反転共役の節末が変わりました");
}
if (!positiveDefiniteSymmetrizedTransferMatrixEntry.dependsOnEntryIds.includes(realSymmetricGeneratorsEntry.id)
  || positiveDefiniteSymmetrizedTransferMatrixEntry.dependsOnEntryIds.includes(signFlipConjugationEntry.id)
  || positiveDefiniteSymmetrizedTransferMatrixEntry.dependencyPlacement!.chapterOrder
    <= signFlipConjugationEntry.dependencyPlacement!.chapterOrder) {
  throw new Error("実対称性から対称化転送行列の正定値性へ分岐する節境界が変わりました");
}
if (JSON.stringify([...evenSectorGeneratorDefinitionEntry.dependsOnEntryIds].sort())
    !== JSON.stringify([
      "transfer_matrix_011_definition_H1_H2",
    ].sort())
  || evenSectorGeneratorDefinitionEntry.dependsOnEntryIds.includes(realSymmetricGeneratorsEntry.id)
  || evenSectorGeneratorDefinitionEntry.dependsOnEntryIds.includes(signFlipConjugationEntry.id)
  || realSymmetricGeneratorsAndSignFlipSection.sectionEntries.some((entry) =>
    entry.dependsOnEntryIds.includes(evenSectorGeneratorDefinitionEntry.id))) {
  throw new Error(`実対称な生成子と符号反転共役の節末、および偶セクター生成子の定義との節境界が変わりました: ${JSON.stringify({
    evenSectorGeneratorDependencies: evenSectorGeneratorDefinitionEntry.dependsOnEntryIds,
    realSymmetricDependsOnGenerator: realSymmetricGeneratorsEntry.dependsOnEntryIds.includes(evenSectorGeneratorDefinitionEntry.id),
    signFlipDependsOnGenerator: signFlipConjugationEntry.dependsOnEntryIds.includes(evenSectorGeneratorDefinitionEntry.id),
  })}`);
}
if (evenSectorOpenChainDefinitionEntry.dependencyPlacement!.chapterOrder
    !== evenSectorGeneratorDefinitionEntry.dependencyPlacement!.chapterOrder + 1
  || evenSectorBoundaryDefinitionEntry.dependencyPlacement!.chapterOrder
    !== evenSectorGeneratorDefinitionEntry.dependencyPlacement!.chapterOrder + 2
  || evenSectorGeneratorSpinFormEntry.dependencyPlacement!.chapterOrder
    !== evenSectorGeneratorDefinitionEntry.dependencyPlacement!.chapterOrder + 3
  || evenSectorGeneratorDiagonalActionEntry.dependencyPlacement!.chapterOrder
    !== evenSectorGeneratorDefinitionEntry.dependencyPlacement!.chapterOrder + 4
  || evenSectorGeneratorPairwiseCommutationEntry.dependencyPlacement!.chapterOrder
    !== evenSectorGeneratorDefinitionEntry.dependencyPlacement!.chapterOrder + 5
  || evenSectorGeneratorInvolutionEntry.dependencyPlacement!.chapterOrder
    !== evenSectorGeneratorDefinitionEntry.dependencyPlacement!.chapterOrder + 6
  || v1PlusSquareRootDefinitionEntry.dependencyPlacement!.chapterOrder
    !== evenSectorGeneratorDefinitionEntry.dependencyPlacement!.chapterOrder + 7
  || JSON.stringify([...v1PlusSquareRootDefinitionEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(v1PlusSquareRootDefinitionExpectedDirectDependencies)
  || v1PlusSquareRootDefinitionEntry.explanationGranularityReview.inspectedContentSha256
    !== v1PlusSquareRootDefinitionExpectedContentSha256
  || v1PlusSquareRootDefinitionEntry.dependsOnEntryIds.includes(evenSectorGeneratorSpinFormEntry.id)
  || evenSectorGeneratorSection.sectionEntries.some((entry) =>
    entry.dependsOnEntryIds.includes(v1PlusSquareRootDefinitionEntry.id))) {
  throw new Error(`偶セクター生成子のスピン作用素表示と半指数行列の定義との節境界が変わりました: ${JSON.stringify({
    orders: evenSectorGeneratorSection.sectionEntries.map((entry) => [entry.id, entry.dependencyPlacement?.chapterOrder]),
    nextOrder: v1PlusSquareRootDefinitionEntry.dependencyPlacement?.chapterOrder,
    nextDependencies: v1PlusSquareRootDefinitionEntry.dependsOnEntryIds,
    nextContentSha256: v1PlusSquareRootDefinitionEntry.explanationGranularityReview.inspectedContentSha256,
    expectedNextContentSha256: v1PlusSquareRootDefinitionExpectedContentSha256,
    interveningEntries: entries
      .filter((entry) => entry.provisionalFinalChapter === "2次元イジングモデル"
        && entry.dependencyPlacement!.chapterOrder >= 37
        && entry.dependencyPlacement!.chapterOrder <= 62)
      .map((entry) => [entry.dependencyPlacement!.chapterOrder, entry.id]),
  })}`);
}
for (const entry of evenSectorGeneratorSection.sectionEntries) {
  const expectedDependencies = [...evenSectorGeneratorExpectedDirectDependencies.get(entry.id)!].sort();
  if (JSON.stringify([...entry.dependsOnEntryIds].sort()) !== JSON.stringify(expectedDependencies)) {
    throw new Error(`偶セクター生成子のスピン作用素表示の直接依存が変わりました: ${entry.id}: ${JSON.stringify(entry.dependsOnEntryIds)}`);
  }
}
if (evenSectorGeneratorDefinitionEntry.kind !== "definition"
  || evenSectorOpenChainDefinitionEntry.kind !== "definition"
  || evenSectorBoundaryDefinitionEntry.kind !== "definition"
  || evenSectorGeneratorSpinFormEntry.kind !== "claim"
  || evenSectorGeneratorDiagonalActionEntry.kind !== "claim"
  || evenSectorGeneratorPairwiseCommutationEntry.kind !== "claim"
  || evenSectorGeneratorInvolutionEntry.kind !== "claim") {
  throw new Error("偶セクター生成子の定義とスピン作用素表示が一ブロック一定義・一主張の構造ではありません");
}
const evenSectorGeneratorExternalInputSet = new Set(evenSectorGeneratorSection.externalInputEntryIds);
const inputsAddedForV1PlusSquareRootDefinition = v1PlusSquareRootDefinitionEntry.dependsOnEntryIds
  .filter((id) => !evenSectorGeneratorExternalInputSet.has(id));
const inputsDroppedAfterEvenSectorGenerator = evenSectorGeneratorSection.externalInputEntryIds
  .filter((id) => !v1PlusSquareRootDefinitionEntry.dependsOnEntryIds.includes(id));
if (JSON.stringify(inputsAddedForV1PlusSquareRootDefinition.sort()) !== JSON.stringify([
  "evensectorT_definition_H1_plus",
].sort())
  || JSON.stringify(inputsDroppedAfterEvenSectorGenerator.sort()) !== JSON.stringify([
    "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
    "bridge_001_definition_config_basis",
    "bridge_002_claim_sigma_z_diagonal_action",
    "bridge_009_claim_epsilon_projector_properties",
    "bridge_010_claim_epsilon_commutes",
    "calc_formulae_003_matrix_decomposition",
    "calculation_formulae_definition_set_and_algebra_notation",
    "linear_space_general_000b_claim_kronecker_product_rule",
    "transfer_matrix_001_definition_symbols",
    "transfer_matrix_003_claim_V1_in_Z_Y_epsilon",
  ].sort())) {
  throw new Error(`偶セクター生成子のスピン作用素表示の直後で入力集合の切り替わり方が変わりました: ${JSON.stringify({
    added: inputsAddedForV1PlusSquareRootDefinition,
    dropped: inputsDroppedAfterEvenSectorGenerator,
  })}`);
}
for (const entry of v1PlusHalfExponentAndSquareRootSection.sectionEntries) {
  const expectedDependencies = [
    ...v1PlusHalfExponentAndSquareRootExpectedDirectDependencies.get(entry.id)!,
  ].sort();
  if (JSON.stringify([...entry.dependsOnEntryIds].sort()) !== JSON.stringify(expectedDependencies)) {
    throw new Error(`偶セクターの半指数行列と平方根性の直接依存が変わりました: ${entry.id}: ${JSON.stringify(entry.dependsOnEntryIds)}`);
  }
}
if (v1PlusSquareRootDefinitionEntry.dependencyPlacement!.chapterOrder !== 55
  || v1PlusSquareRootClaimEntry.dependencyPlacement!.chapterOrder !== 56
  || vPlusDefinitionEntry.dependencyPlacement!.chapterOrder !== 57
  || v1PlusSquareRootDefinitionEntry.kind !== "definition"
  || v1PlusSquareRootClaimEntry.kind !== "claim"
  || vPlusDefinitionEntry.kind !== "definition"
  || JSON.stringify([...vPlusDefinitionEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(vPlusDefinitionExpectedDirectDependencies)
  || vPlusDefinitionEntry.explanationGranularityReview.inspectedContentSha256
    !== vPlusDefinitionExpectedContentSha256
  || !vPlusDefinitionEntry.dependsOnEntryIds.includes(v1PlusSquareRootDefinitionEntry.id)
  || vPlusDefinitionEntry.dependsOnEntryIds.includes(v1PlusSquareRootClaimEntry.id)
  || v1PlusSquareRootClaimEntry.dependsOnEntryIds.includes(vPlusDefinitionEntry.id)) {
  throw new Error(`偶セクターの半指数行列と平方根性、および V^{(+)} の定義との節境界が変わりました: ${JSON.stringify({
    sectionOrders: v1PlusHalfExponentAndSquareRootSection.sectionEntries.map(
      (entry) => [entry.id, entry.dependencyPlacement?.chapterOrder],
    ),
    nextOrder: vPlusDefinitionEntry.dependencyPlacement?.chapterOrder,
    nextDependencies: vPlusDefinitionEntry.dependsOnEntryIds,
  })}`);
}
const v1PlusHalfExponentExternalInputSet = new Set(
  v1PlusHalfExponentAndSquareRootSection.externalInputEntryIds,
);
const vPlusDefinitionExternalInputEntryIds = vPlusDefinitionEntry.dependsOnEntryIds
  .filter((id) => !v1PlusHalfExponentAndSquareRootSectionEntryIds.includes(id));
const inputsAddedForVPlusDefinition = vPlusDefinitionExternalInputEntryIds
  .filter((id) => !v1PlusHalfExponentExternalInputSet.has(id));
const inputsDroppedAfterV1PlusSquareRoot = v1PlusHalfExponentAndSquareRootSection.externalInputEntryIds
  .filter((id) => !vPlusDefinitionExternalInputEntryIds.includes(id));
if (JSON.stringify(inputsAddedForVPlusDefinition.sort()) !== JSON.stringify([
  "transfer_matrix_001_definition_symbols",
].sort())
  || JSON.stringify(inputsDroppedAfterV1PlusSquareRoot.sort()) !== JSON.stringify([
    "evensectorT_definition_H1_plus",
    "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
    "transfer_matrix_007_definition_V1_pm",
  ].sort())) {
  throw new Error(`偶セクターの平方根性の直後で入力集合の切り替わり方が変わりました: ${JSON.stringify({
    added: inputsAddedForVPlusDefinition,
    dropped: inputsDroppedAfterV1PlusSquareRoot,
  })}`);
}
if (!v1PlusHalfExponentAndSquareRootSection.sectionEntries.every((entry) =>
  entry.explanationGranularityReview.status === "自動検査で主題に適合")
  || vPlusDefinitionEntry.explanationGranularityReview.status !== "自動検査で主題に適合") {
  throw new Error("偶セクターの半指数行列・平方根性または直後の V^{(+)} 定義の説明粒度判定が変わりました");
}
for (const entry of vPlusDefinitionAndSignedTraceSection.sectionEntries) {
  const expectedDependencies = [
    ...vPlusDefinitionAndSignedTraceExpectedDirectDependencies.get(entry.id)!,
  ].sort();
  if (JSON.stringify([...entry.dependsOnEntryIds].sort()) !== JSON.stringify(expectedDependencies)) {
    throw new Error(`偶セクター転送行列と符号付きトレースの正値公式の直接依存が変わりました: ${entry.id}: ${JSON.stringify(entry.dependsOnEntryIds)}`);
  }
}
if (vPlusDefinitionEntry.dependencyPlacement!.chapterOrder !== 57
  || signedTraceOfVPlusEntry.dependencyPlacement!.chapterOrder !== 58
  || vPlusPositiveDefiniteEntry.dependencyPlacement!.chapterOrder !== 59
  || vPlusDefinitionEntry.kind !== "definition"
  || signedTraceOfVPlusEntry.kind !== "theorem"
  || vPlusPositiveDefiniteEntry.kind !== "claim"
  || JSON.stringify([...vPlusPositiveDefiniteEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(vPlusPositiveDefiniteExpectedDirectDependencies)
  || vPlusPositiveDefiniteEntry.explanationGranularityReview.inspectedContentSha256
    !== vPlusPositiveDefiniteExpectedContentSha256
  || !signedTraceOfVPlusEntry.dependsOnEntryIds.includes(vPlusDefinitionEntry.id)
  || !vPlusPositiveDefiniteEntry.dependsOnEntryIds.includes(vPlusDefinitionEntry.id)
  || signedTraceOfVPlusEntry.dependsOnEntryIds.includes(vPlusPositiveDefiniteEntry.id)
  || vPlusPositiveDefiniteEntry.dependsOnEntryIds.includes(signedTraceOfVPlusEntry.id)) {
  throw new Error(`偶セクター転送行列と符号付きトレースの正値公式、および V^{(+)} の正定値性との節境界が変わりました: ${JSON.stringify({
    sectionOrders: vPlusDefinitionAndSignedTraceSection.sectionEntries.map(
      (entry) => [entry.id, entry.dependencyPlacement?.chapterOrder],
    ),
    nextOrder: vPlusPositiveDefiniteEntry.dependencyPlacement?.chapterOrder,
    nextDependencies: vPlusPositiveDefiniteEntry.dependsOnEntryIds,
  })}`);
}
if (!vPlusDefinitionAndSignedTraceSection.sectionEntries.every((entry) =>
  entry.explanationGranularityReview.status === "自動検査で主題に適合")
  || vPlusPositiveDefiniteEntry.explanationGranularityReview.status
    !== "自動検査で主題に適合") {
  throw new Error("偶セクター転送行列・符号付きトレースまたは直後の正定値性の説明粒度判定が変わりました");
}
if (vPlusPositiveDefiniteEntry.dependencyPlacement!.chapterOrder !== 59
  || traceVPlusPositiveEntry.dependencyPlacement!.chapterOrder !== 60
  || vPlusInvertibleEntry.dependencyPlacement!.chapterOrder !== 61
  || vPlusInversePositiveDefiniteEntry.dependencyPlacement!.chapterOrder !== 62
  || vPlusInversePositiveAndTracesEntry.dependencyPlacement!.chapterOrder !== 63
  || v1PlusHalfInvertibleEntry.dependencyPlacement!.chapterOrder !== 64
  || vTwoInvertibleEntry.dependencyPlacement!.chapterOrder !== 65
  || vPlusFactorsInvertibleEntry.dependencyPlacement!.chapterOrder !== 66
  || conjugationLinearityEntry.dependencyPlacement!.chapterOrder !== 67
  || vPlusInvertibleEntry.kind !== "claim"
  || vPlusInversePositiveDefiniteEntry.kind !== "claim"
  || traceVPlusPositiveEntry.kind !== "claim"
  || vPlusInversePositiveAndTracesEntry.kind !== "claim"
  || v1PlusHalfInvertibleEntry.kind !== "claim"
  || vTwoInvertibleEntry.kind !== "claim"
  || vPlusFactorsInvertibleEntry.kind !== "claim"
  || conjugationLinearityEntry.kind !== "claim"
  || JSON.stringify(vPlusInvertibleEntry.dependsOnEntryIds
    .filter((id) => vPlusPositiveDefiniteSectionEntryIds.includes(id as typeof vPlusPositiveDefiniteSectionEntryIds[number])))
    !== JSON.stringify(vPlusPositiveDefiniteExpectedInternalDependencies.get(vPlusInvertibleEntry.id))
  || JSON.stringify(vPlusInversePositiveAndTracesEntry.dependsOnEntryIds
    .filter((id) => vPlusPositiveDefiniteSectionEntryIds.includes(id as typeof vPlusPositiveDefiniteSectionEntryIds[number])))
    !== JSON.stringify(vPlusPositiveDefiniteExpectedInternalDependencies.get(vPlusInversePositiveAndTracesEntry.id))
  || JSON.stringify(vPlusInversePositiveDefiniteEntry.dependsOnEntryIds
    .filter((id) => vPlusPositiveDefiniteSectionEntryIds.includes(id as typeof vPlusPositiveDefiniteSectionEntryIds[number])))
    !== JSON.stringify(vPlusPositiveDefiniteExpectedInternalDependencies.get(vPlusInversePositiveDefiniteEntry.id))
  || JSON.stringify(traceVPlusPositiveEntry.dependsOnEntryIds
    .filter((id) => vPlusPositiveDefiniteSectionEntryIds.includes(id as typeof vPlusPositiveDefiniteSectionEntryIds[number])))
    !== JSON.stringify(vPlusPositiveDefiniteExpectedInternalDependencies.get(traceVPlusPositiveEntry.id))
  || JSON.stringify([...v1PlusHalfInvertibleEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(v1PlusHalfInvertibleExpectedDirectDependencies)
  || JSON.stringify([...vTwoInvertibleEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(vTwoInvertibleExpectedDirectDependencies)
  || !vPlusFactorsInvertibleEntry.dependsOnEntryIds.includes("evensectorT_claim_V1_plus_half_invertible")
  || !vPlusFactorsInvertibleEntry.dependsOnEntryIds.includes("evensectorT_claim_V2_invertible")
  || !vPlusFactorsInvertibleEntry.dependsOnEntryIds.includes("evensectorT_definition_V_plus")
  || JSON.stringify([...conjugationLinearityEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(conjugationLinearityExpectedDirectDependencies)
  || v1PlusHalfInvertibleEntry.explanationGranularityReview.inspectedContentSha256
    !== v1PlusHalfInvertibleExpectedContentSha256
  || vTwoInvertibleEntry.explanationGranularityReview.inspectedContentSha256
    !== vTwoInvertibleExpectedContentSha256
  || conjugationLinearityEntry.explanationGranularityReview.inspectedContentSha256
    !== conjugationLinearityExpectedContentSha256
  || vPlusPositiveDefiniteSection.sectionEntries.some((entry) =>
    entry.dependsOnEntryIds.includes(vPlusFactorsInvertibleEntry.id))
  || vPlusPositiveDefiniteSection.sectionEntries.some((entry) =>
    vPlusFactorsInvertibleEntry.dependsOnEntryIds.includes(entry.id))
  || !conjugationLinearityEntry.dependsOnEntryIds.includes(vPlusFactorsInvertibleEntry.id)
  || vPlusPositiveDefiniteSection.sectionEntries.some((entry) =>
    conjugationLinearityEntry.dependsOnEntryIds.includes(entry.id))
  || vPlusFactorsInvertibleEntry.dependsOnEntryIds.includes(conjugationLinearityEntry.id)
  || vPlusInvertibleEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || vPlusInversePositiveDefiniteEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || traceVPlusPositiveEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || vPlusInversePositiveAndTracesEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || v1PlusHalfInvertibleEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || vTwoInvertibleEntry.explanationGranularityReview.status !== "自動検査で主題に適合") {
  throw new Error(`偶セクター転送行列の正定値性・可逆性・残余候補、構成因子の可逆性、共役写像の線型性の節境界が変わりました: ${JSON.stringify({
    orders: [...vPlusPositiveDefiniteSection.sectionEntries, v1PlusHalfInvertibleEntry,
      vTwoInvertibleEntry, vPlusFactorsInvertibleEntry, conjugationLinearityEntry]
      .map((entry) => [entry.id, entry.dependencyPlacement?.chapterOrder]),
    reviewedSectionDependencies: vPlusPositiveDefiniteSection.sectionEntries
      .map((entry) => [entry.id, entry.dependsOnEntryIds]),
    invertibilityDependencies: vPlusFactorsInvertibleEntry.dependsOnEntryIds,
    linearityDependencies: conjugationLinearityEntry.dependsOnEntryIds,
  })}`);
}
const vPlusPositiveDefiniteExternalInputSet = new Set(vPlusPositiveDefiniteSection.externalInputEntryIds);
const inputsAddedForV1PlusHalfInvertibility = v1PlusHalfInvertibleEntry.dependsOnEntryIds
  .filter((id) => !vPlusPositiveDefiniteExternalInputSet.has(id));
const inputsDroppedAfterVPlusPositiveDefiniteness = vPlusPositiveDefiniteSection.externalInputEntryIds
  .filter((id) => !v1PlusHalfInvertibleEntry.dependsOnEntryIds.includes(id));
if (JSON.stringify(inputsAddedForV1PlusHalfInvertibility.sort()) !== JSON.stringify([
  "TV1_hatZ_hatY_009_definition_invertible_elements",
  "exp_conjugation_proof_010_theorem_matrix_exp_conjugation",
].sort())
  || JSON.stringify(inputsDroppedAfterVPlusPositiveDefiniteness.sort()) !== JSON.stringify([
    "calculation_formulae_definition_set_and_algebra_notation",
    "eigenvalues_of_V_011_definition_hermitian_positive_definite",
    "eigenvalues_of_V_013_claim_exp_hermitian_positive_definite",
    "eigenvalues_of_V_014_claim_iH_is_real_symmetric",
    "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
    "exp_linear_map_004_theorem_exp_zero_is_identity",
    "evensectorT_definition_V_plus",
    "linear_space_general_002_claim_scalar_identity_commutes",
    "transfer_matrix_001_definition_symbols",
  ].sort())) {
  throw new Error(`偶セクター転送行列の正定値性の直後で入力集合の切り替わり方が変わりました: ${JSON.stringify({
    added: inputsAddedForV1PlusHalfInvertibility,
    dropped: inputsDroppedAfterVPlusPositiveDefiniteness,
  })}`);
}
const v1PlusHalfInvertibilityInputSet = new Set(v1PlusHalfInvertibleEntry.dependsOnEntryIds);
const inputsAddedForVTwoInvertibility = vTwoInvertibleEntry.dependsOnEntryIds
  .filter((id) => !v1PlusHalfInvertibilityInputSet.has(id));
const inputsDroppedAfterV1PlusHalfInvertibility = v1PlusHalfInvertibleEntry.dependsOnEntryIds
  .filter((id) => !vTwoInvertibleEntry.dependsOnEntryIds.includes(id));
if (JSON.stringify(inputsAddedForVTwoInvertibility.sort()) !== JSON.stringify([
  "transfer_matrix_001_definition_symbols",
].sort())
  || JSON.stringify(inputsDroppedAfterV1PlusHalfInvertibility.sort()) !== JSON.stringify([
    "evensectorT_definition_V1_plus_square_root",
  ].sort())) {
  throw new Error(`半指数行列の可逆性から V_2 の可逆性への入力集合が変わりました: ${JSON.stringify({
    added: inputsAddedForVTwoInvertibility,
    dropped: inputsDroppedAfterV1PlusHalfInvertibility,
  })}`);
}
const vPlusFactorsInvertibilityInputSet = new Set(vPlusFactorsInvertibleEntry.dependsOnEntryIds);
const inputsAddedForConjugationLinearity = conjugationLinearityEntry.dependsOnEntryIds
  .filter((id) => !vPlusFactorsInvertibilityInputSet.has(id));
const inputsDroppedAfterVPlusFactorsInvertibility = vPlusFactorsInvertibleEntry.dependsOnEntryIds
  .filter((id) => !conjugationLinearityEntry.dependsOnEntryIds.includes(id));
if (JSON.stringify(inputsAddedForConjugationLinearity.sort()) !== JSON.stringify([
  "TV1_hatZ_hatY_011_definition_T_g",
  "calc_formulae_006_definition_of_cc",
  "evensectorT_claim_V_plus_factors_invertible",
  "evensector_003a_definition_check_index_set",
  "linear_space_general_002_claim_scalar_identity_commutes",
].sort())
  || JSON.stringify(inputsDroppedAfterVPlusFactorsInvertibility.sort()) !== JSON.stringify([
    "evensectorT_claim_V1_plus_half_invertible",
    "evensectorT_claim_V2_invertible",
    "evensectorT_definition_V_plus",
  ].sort())
  || vPlusFactorsInvertibleEntry.explanationGranularityReview.status
    !== "具体的な行列計算への展開またはブロック分割を要する"
  || conjugationLinearityEntry.explanationGranularityReview.status !== "自動検査で主題に適合") {
  throw new Error(`構成因子の可逆性から共役写像の線型性への入力集合が変わりました: ${JSON.stringify({
    added: inputsAddedForConjugationLinearity,
    dropped: inputsDroppedAfterVPlusFactorsInvertibility,
  })}`);
}
if (!realSymmetricGeneratorsAndSignFlipSection.sectionEntries.every((entry) =>
  entry.explanationGranularityReview.status === "自動検査で主題に適合")
  || ![
    "calculation_formulae_definition_set_and_algebra_notation",
    "calc_formulae_006_definition_of_cc",
    "transfer_matrix_001_definition_symbols",
  ].every((id) => entries.find((entry) => entry.id === id)!.explanationGranularityReview.status
    === "具体的な行列計算への展開またはブロック分割を要する")) {
  throw new Error("実対称な生成子と符号反転共役の対象本文または外部入力の説明粒度判定が変わりました");
}
if (!evenSectorGeneratorSection.sectionEntries.every((entry) =>
  entry.explanationGranularityReview.status === "自動検査で主題に適合")
  || v1PlusSquareRootDefinitionEntry.explanationGranularityReview.status !== "自動検査で主題に適合") {
  throw new Error("偶セクター生成子のスピン作用素表示または直後の半指数行列の説明粒度判定が変わりました");
}
if (kappaDefinitionEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || criticalSinhProductDefinitionEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || !symmetrizedTransferMatrixSection.sectionEntries.every((entry) => entry.explanationGranularityReview.status === "自動検査で主題に適合")
  || positiveSymmetrizedTransferMatrixEntriesEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || zYLinearIndependenceEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || !v1V2JordanWignerSection.sectionEntries.every((entry) =>
    entry.explanationGranularityReview.status === "自動検査で主題に適合")
  || epsilonEigenspacesEntry.explanationGranularityReview.status !== "具体的な行列計算への展開またはブロック分割を要する"
  || epsilonSquareAndEigenvaluesEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || epsilonProjectorPropertiesEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || v1RestrictionToEigenspacesEntry.explanationGranularityReview.status !== "具体的な行列計算への展開またはブロック分割を要する"
  || !positiveSymmetrizedTransferMatrixEntriesSection.externalInputEntryIds.every((id) =>
    entries.find((entry) => entry.id === id)!.explanationGranularityReview.status === "自動検査で主題に適合")
  || epsilonProjectorDefinitionSection.sectionEntries[0]!.explanationGranularityReview.status !== "自動検査で主題に適合"
  ) {
  throw new Error("章内依存順16–29と対称化転送行列の全成分正値性の外部入力の説明粒度判定が変わりました");
}
const mathematicalToolSectionBoundaries = [{
  name: "行列指数関数による共役の級数公式",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度未解決",
  entryIds: matrixExponentialConjugationSectionEntryIds,
  input: [
    "複素数と有限複素行列の四則演算、交換子作用とその二項展開",
    "行列ノルムと完備性",
    "実数・行列・行列作用の指数級数、その収束、可換行列の指数関数の積公式",
  ],
  externalInputEntryIds: matrixExponentialConjugationExternalInputEntryIds,
  output: [
    "行列指数関数による共役を反復交換子の指数級数で表す主定理",
    "主定理の右辺を項ごとに明示する系",
  ],
  mainTheorem: "行列版の指数関数による共役公式",
  mainTheoremEntryId: "exp_conjugation_proof_010_theorem_matrix_exp_conjugation",
  concludingCorollary: "主定理の反復交換子級数を項ごとに明示する系",
  concludingCorollaryEntryId: "exp_conjugation_proof_008_theorem_exp_ad_series",
  boundaryEvidence: "章内依存順の連続する二項であり、行列版の共役公式を主定理とし、その右辺を項ごとに明示する系で節を閉じる。外部入力・内部依存辺・本文 fingerprint・連続性・節末の一意性を生成時に固定検査する。",
  readabilityStatus: "二項とも具体的な行列計算への展開またはブロック分割を要するため、節境界だけを確定し、本文完成とは扱わない。",
}, {
  name: "行列と線型写像の対応",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度未解決",
  entryIds: matrixLinearMapCorrespondenceSectionEntryIds,
  input: [
    "複素数、有限複素行列、数ベクトル、線型写像",
    "具体的なクロネッカー積、その積と多重線型性、クロネッカー積で作る行列単位と数ベクトルの基底",
    "行列と線型写像の指数級数",
  ],
  externalInputEntryIds: matrixLinearMapCorrespondenceExternalInputEntryIds,
  output: [
    "行列単位を基底上の線型写像へ送る写像の具体的な定義",
    "その写像が積と単位元を保つ全単射であるという主定理",
    "クロネッカー積で作る行列が各因子の数ベクトルへ成分ごとに作用する公式",
    "行列表示と線型写像表示の間で指数関数が保たれる系",
  ],
  mainTheorem: "行列表示から線型写像表示への写像は単位的な複素代数の同型である",
  mainTheoremEntryId: "transfer_matrix_005b_claim_end_is_algebra_isomorphism",
  concludingCorollary: "行列表示と線型写像表示の間で指数関数が保たれる系",
  concludingCorollaryEntryId: "transfer_matrix_005c_claim_end_preserves_matrix_exponential",
  boundaryEvidence: "章内依存順の連続する四項であり、対応の定義から積と単位元を保つ全単射という主定理へ進み、クロネッカー積の作用公式と指数関数保存の系という二つの出力で節を閉じる。外部入力とその本文 fingerprint、内部依存辺、節内本文 fingerprint、連続性、二つの節末出力を生成時に固定検査する。",
  readabilityStatus: "四項とも線型写像の抽象語彙を含むため、節境界だけを確定し、定義内の基底・基底作用・対応の分割を含む本文完成とは扱わない。",
}, {
  name: "可逆行列と共役写像",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度確認済み",
  entryIds: invertibleMatrixConjugationSectionEntryIds,
  input: [
    "複素数と有限複素行列の和・積・単位行列",
    "具体的なクロネッカー積の積と多重線型性、およびクロネッカー積で作る行列単位の基底",
    "スカラー倍した単位行列が全行列と可換すること",
    "全行列と可換する複素行列がスカラー倍した単位行列に限ること",
  ],
  externalInputEntryIds: invertibleMatrixConjugationExternalInputEntryIds,
  output: [
    "可逆行列と逆行列の具体的な定義および積・逆元・スカラー単位行列に関する基本性質",
    "可逆行列による共役写像の定義",
    "可逆行列全体の中で全可逆行列と可換する元が非零スカラー倍の単位行列に限ること",
    "二つの共役写像が等しいことと、それらを定める可逆行列が非零スカラー倍だけ異なることの同値",
  ],
  mainTheorem: "可逆行列による共役写像は、それを定める行列の非零スカラー倍を除いて単射である",
  mainTheoremEntryId: "TV1_hatZ_hatY_011a_claim_injectivity_of_T",
  boundaryEvidence: "章内依存順の連続する四項であり、可逆元の定義から共役写像の定義と可逆行列全体の可換元の特徴付けへ進み、両者を使う定数倍を除いた単射性の主定理で節を閉じる。外部入力とその本文 fingerprint、内部依存辺、節内本文 fingerprint、連続性、節末出力の一意性を生成時に固定検査する。",
  readabilityStatus: "四項とも複素数と有限行列の具体的な計算で書かれ、現行の説明粒度検査に合格している。未定義だった特性多項式・固有値・行列式による可逆化を削除し、明示的な逆行列をもつ行列単位の摂動だけを使う証明へ置き換えた。",
}, {
  name: "Pauli 行列と共役で保たれる行列群",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度未解決",
  entryIds: pauliAndCliffordMatrixGroupsSectionEntryIds,
  input: [
    "複素数と二次の複素行列の成分表示および行列積",
    "具体的なクロネッカー積の積と多重線型性",
    "有限複素行列の可逆元と逆行列",
  ],
  externalInputEntryIds: pauliAndCliffordMatrixGroupsSection.externalInputEntryIds,
  output: [
    "三つの Pauli 行列の平方と相互の反可換性を成分で確かめる積公式",
    "Pauli 行列のクロネッカー積と四乗根の係数からなる有限な行列群の定義",
    "その行列群を共役で保つ可逆行列全体の定義",
  ],
  mainTheorem: null,
  mainTheoremEntryId: null,
  concludingDefinition: "Pauli 行列群を共役で保つ可逆行列全体",
  concludingDefinitionEntryId: "TV1_hatZ_hatY_010_definition_clifford_group",
  boundaryEvidence: "章内依存順の連続する三項であり、Pauli 行列の積公式から多因子の Pauli 行列群を定め、その行列群を共役で保つ可逆行列全体の定義へ閉じる。直後の一因子反可換性はこの行列群を使わず、外部入力も可逆元を含まない独立した帰結なので別節とする。外部入力とその本文 fingerprint、内部依存辺、節内本文 fingerprint、連続性、節末定義の一意性を生成時に固定検査する。",
  readabilityStatus: "Pauli 行列群とクリフォード行列群を別ブロックへ分け、後者からイジング模型固有の V_2 による導入理由を除いた。二つの行列群について群の閉性を具体的な行列計算へさらに展開する余地があるため、本文完成とは扱わない。",
}, {
  name: "一因子の反可換性から得るクロネッカー積の反交換",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度確認済み",
  entryIds: singleFactorAnticommutationSectionEntryIds,
  input: [
    "複素数と二次の複素行列",
    "具体的なクロネッカー積の積と各因子についての多重線型性",
    "一つの因子での反可換性と残りの因子での可換性",
  ],
  externalInputEntryIds: singleFactorAnticommutationSection.externalInputEntryIds,
  output: [
    "一因子だけの負号がクロネッカー積全体の負号となり、二つの多因子行列が反交換する公式",
  ],
  mainTheorem: "一因子だけ反可換で他の因子が可換なら、二つのクロネッカー積は反交換する",
  mainTheoremEntryId: "Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site",
  boundaryEvidence: "直前の行列群の定義に依存せず、クロネッカー積の積と多重線型性だけを外部入力として一つの主張へ閉じる独立した葉である。したがって行列群の節へ混ぜず、一項の節として確定する。外部入力とその本文 fingerprint、本文 fingerprint、節末出力の一意性を生成時に固定検査する。",
  readabilityStatus: "二次の複素行列とクロネッカー積の積を一因子ずつ書いた具体的な計算であり、現行の説明粒度検査に合格している。",
}];
const isingModelSectionBoundaries = [{
  name: "格子と転送行列の定義",
  chapter: "2次元イジングモデル",
  status: "構造確定・本文粒度確認済み",
  entryIds: isingModelDefinitionSectionEntryIds,
  input: [
    "自然数と実数・複素数の集合記号",
    "有限複素行列の成分表示",
  ],
  externalInputEntryIds: isingModelDefinitionSection.externalInputEntryIds,
  output: [
    "格子の縦横の大きさ",
    "周期境界条件をもつ2次元イジング模型の分配関数",
    "一行分のスピン配置を添え字とする二つの転送行列",
  ],
  concludingDefinition: "2次元イジング模型の分配関数を行列積へ移すための転送行列",
  concludingDefinitionEntryId: "partition_function_2d_ising_003_definition_transfer_matrix",
  boundaryEvidence: "章内依存順の連続する三項であり、格子サイズを分配関数が意味的前提として明示し、分配関数を転送行列が周期境界条件の参照先として使う。格子サイズから転送行列までが模型の有限サイズ表現を定め、次の転送行列による分配関数の表式へ入力を渡すため、三つの定義で最初の節を閉じる。外部入力とその本文 fingerprint、内部依存辺、節内本文 fingerprint、連続性、節末定義の一意性を生成時に固定検査する。",
  readabilityStatus: "三項とも有限集合、有限和、有限複素行列の成分として具体的に定義され、現行の説明粒度検査に合格している。",
}, {
  name: "スピン配置と標準基底の対応",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: spinConfigurationBasisSectionEntryIds,
  input: [
    "最初の節で定めた一行分のスピン配置と転送行列",
    "クロネッカー積の標準基底を番号づける多重添字と、その多重添字による行列成分の表示",
  ],
  externalInputEntryIds: spinConfigurationBasisSection.externalInputEntryIds,
  output: [
    "一行分のスピン配置から多重添字への全単射",
    "スピン配置を添え字として転送行列の成分を読むための具体的な対応",
  ],
  concludingDefinition: "スピン配置からクロネッカー積の標準基底の多重添字への全単射",
  concludingDefinitionEntryId: "bridge_001_definition_config_basis",
  boundaryEvidence: "章内依存順4の一項は、最初の節で定めた転送行列と、数学的道具立ての標準基底・行列表示の対応を入力として、スピン配置から多重添字への全単射を定める。次の章内依存順5は、転送行列定義のスピン配置集合を別の行長記号で読み替えて開鎖エネルギーを定めるが、順4の標準基底との対応には依存せず、外部入力集合も異なる。したがって外部入力集合が変わる章内依存順4の後でこの一項の節を閉じる。外部入力とその本文 fingerprint、本文 fingerprint、章内依存順、節末定義の一意性に加え、次項の章内順・直接依存・本文 fingerprint・前節からの非依存を生成時に固定検査する。",
  readabilityStatus: "対象定義は有限集合の各成分について二通りの値を対応させ、転送行列の行・列を具体的に読み替えるため、現行の説明粒度検査に合格している。外部入力である行列と線型写像の対応の節には、具体的な行列計算への展開またはブロック分割が残る。",
}, {
  name: "1次元開鎖のスピン和",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: openChainSpinSumsSectionEntryIds,
  input: [
    "最初の節で定めた一行分のスピン配置",
    "双曲線関数の定義・基本性質と指数関数の積公式",
    "有限集合と有限和の記号",
  ],
  externalInputEntryIds: openChainSpinSumsSection.externalInputEntryIds,
  output: [
    "1次元開鎖のスピン配置集合と開鎖エネルギー",
    "端点因子を持たない1次元開鎖のスピン和と、両端のスピンの積を掛けたスピン和の閉じた式",
    "正の結合定数に対する二つのスピン和の正値性",
  ],
  mainTheorem: "端点因子のないスピン和と両端のスピンの積を掛けたスピン和を双曲線関数で表す二公式",
  mainTheoremEntryIds: [
    "closing_005_claim_open_chain_partition_sum",
    "closing_005_claim_open_chain_endpoint_product_sum",
  ],
  concludingClaim: "正の結合定数に対する二つの1次元開鎖のスピン和の正値性",
  concludingClaimEntryId: "closing_005_claim_open_chain_spin_sums_positive",
  boundaryEvidence: "旧来一ブロックだった内容を、共通記法、端点因子のない和、両端積付きの和、正値性の四項へ分けた章内依存順5–8の連続区間である。二つの和は共通記法だけに依存し、正値性が二公式を受け取って節末を閉じる。章内依存順9の転送行列による分配関数の表式および章内依存順10の記号の定義はこの節へ依存せず、節末を含む三項の外部入力集合もそれぞれ異なる。したがって外部入力集合が切り替わる章内依存順8の後で節を閉じる。外部入力とその本文 fingerprint、四項の本文 fingerprint、内部依存辺、章内依存順、節末出力の一意性を生成時に固定検査する。",
  readabilityStatus: "共通記法と三つの主張を分離し、二公式は初期スピンと隣接スピンの積への具体的な全単射で有限和を計算しているため、対象四項は現行の説明粒度検査に合格している。外部入力である集合と代数構造の記号、双曲線関数の基本性質、可換行列の指数積公式には、複数の定義・主張の分割または具体的な行列計算への展開が残る。",
}, {
  name: "分配関数の転送行列表示",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: partitionFunctionTraceSectionEntryIds,
  input: [
    "最初の節で定めた周期境界条件つき分配関数と二つの転送行列",
    "有限複素行列の積・冪・トレース",
    "可換な指数関数の積公式と有限和・有限積の計算規則",
  ],
  externalInputEntryIds: partitionFunctionTraceSection.externalInputEntryIds,
  output: [
    "2次元イジング模型の分配関数を転送行列の積の冪のトレースとして表す公式",
  ],
  mainTheorem: "2次元イジング模型の分配関数は二つの転送行列の積の冪のトレースに等しい",
  mainTheoremEntryId: "partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix",
  boundaryEvidence: "章内依存順9の一項は、最初の節で定めた分配関数と転送行列を入力として、有限行列の成分・冪・トレースを展開し、分配関数の転送行列表示という一つの主張へ閉じる。章内依存順10の記号の定義と順11のσzの基底作用はこの主張へ依存せず、順10は別の行列指数関数とクロネッカー積を入力とし、順11は順10とスピン配置・標準基底の対応を入力とする。したがって外部入力集合が切り替わる章内依存順9の後で一項の節を閉じる。外部入力とその本文 fingerprint、対象本文 fingerprint、章内依存順、節末出力の一意性に加え、次の二項の章内順・直接依存・本文 fingerprint・本節からの非依存を生成時に固定検査する。",
  readabilityStatus: "対象主張は有限集合上の和、有限複素行列の積と冪、トレースを一段ずつ展開しているため、現行の説明粒度検査に合格している。外部入力である集合と代数構造の記号、複素数の定義、可換行列の指数積公式には、複数の定義・主張の分割または具体的な行列計算への展開が残る。",
}, {
  name: "V1 のパウリ行列表示",
  chapter: "2次元イジングモデル",
  status: "境界候補・対象本文粒度未解決・外部入力粒度未解決",
  entryIds: v1PauliRepresentationSectionEntryIds,
  input: [
    "最初の節で成分表示により定めた転送行列 V1",
    "スピン配置とクロネッカー積の標準基底の多重添字との対応",
    "二次の Pauli 行列、サイトごとのクロネッカー積、その積・多重線型性・基底作用",
    "実数の双曲線余弦・双曲線正弦の定義と正値性",
    "有限複素行列の指数関数と対角行列の指数関数",
  ],
  externalInputEntryIds: v1PauliRepresentationSection.externalInputEntryIds,
  output: [
    "サイトごとの Pauli 行列と V1・V2、Jordan–Wigner 行列、全スピン反転行列、双対結合定数の記号",
    "サイトごとの σz とその二つの積がスピン配置基底へ対角に作用する公式",
    "成分で定義した V1 と Pauli 行列の指数関数で表した V1 が同じ行列であること",
  ],
  mainTheorem: "成分定義の V1 と Pauli 行列による指数表示の一致",
  mainTheoremEntryId: "bridge_004_claim_V1_component_equals_pauli",
  boundaryEvidence: "現行の未分割グラフでは章内依存順10–12が連続し、順10のサイト作用素の記号を順11のσzの基底作用が受け取り、順12がその作用と対角行列の指数関数を用いて、成分定義とPauli行列表示のV1が同じ行列であるという主定理へ閉じるため、順12の後は節境界の候補となる。ただし順10はV1だけでなくV2とJordan–Wigner変換の記号も束ね、順13・14は順10を再利用し、順15は順10と順12を受け取る。順10を一ブロック一定義へ分割すると依存辺と境界が変わりうるため、最終的な節構造は確定しない。生成時には、この暫定評価の前提として、外部入力とその本文 fingerprint、三項の本文 fingerprint、内部依存辺、章内依存順、現行グラフ上の節末出力に加え、章内依存順13–15の章内順・直接依存・本文 fingerprint、および順15がこの候補から順10・12を受け取ることを固定検査する。",
  readabilityStatus: "対象三項のうち、σzの基底作用とV1の二表示の一致は、二次行列の基底作用、クロネッカー積、周期端を分けた対角成分を一段ずつ計算しており、現行の説明粒度検査に合格している。先頭の「記号の定義」は、単位行列、サイトごとの三つのPauli行列、V1・V2、Jordan–Wigner行列、全スピン反転行列、双対結合定数、双曲線関数の略記を一ブロックへ束ねているため未解決である。Pauli行列、cosh・sinh、その正値性は先行項へ明示参照したが、tanh と実対数には独立した先行定義がなく、双対関係の証明は本項を入力とする後続主張なので循環参照を避けた。さらに外部入力では、集合と代数構造の記号、複素数、行列指数関数、行列と線型写像の対応に説明粒度の未解決が残る。対象側と外部入力側を区別して、境界候補・本文未完成として扱う。",
}, {
  name: "V2 のパウリ行列表示と分配関数への接続",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: v2PauliPartitionFunctionSectionEntryIds,
  input: [
    "双対結合定数 K2* と双曲線関数の略記、およびサイトごとの Pauli 行列と V2 の定義",
    "二次の Pauli 行列、非負実数の平方根、指数関数・双曲線関数の級数と基本性質",
    "スピン配置とクロネッカー積の標準基底の対応、およびクロネッカー積の成分・積・多重線型性",
    "成分表示で定めた転送行列 V2 と、確定済みの V1 の二表示の一致・分配関数の転送行列表示",
  ],
  externalInputEntryIds: v2PauliPartitionFunctionSection.externalInputEntryIds,
  output: [
    "一サイトの二次転送行列を Pauli 行列の指数関数で表す恒等式",
    "成分で定義した V2 と Pauli 行列の指数関数で表した V2 が同じ行列であること",
    "2次元イジング模型の分配関数を Pauli 行列表示の転送行列の積の冪のトレースで表す公式",
  ],
  mainTheorem: "分配関数を Pauli 行列表示の二つの転送行列で表す公式",
  mainTheoremEntryId: "bridge_007_claim_partition_function_in_pauli_form",
  boundaryEvidence: "章内依存順13–15は連続し、二次転送行列の恒等式からV2の二表示の一致へ進み、確定済みのV1の二表示の一致と分配関数の転送行列表示を合わせて、分配関数のPauli行列表示へ一方向に閉じる。次の章内依存順16の射影子定義は全スピン反転行列だけを使い、この三項へ依存しないため、外部入力集合が切り替わる順15の後で節を閉じる。順10の混在した記号定義を分割した後は、順13が双対結合定数と双曲線関数の略記、順14がサイトごとのσxとV2、順15がV1・V2の定義片へ依存することを再判定する。分割によりこれらの意味的依存、三項の連続性、順15への一意な閉包、または順16からの非依存が変わった場合は境界を再確定する。",
  readabilityStatus: "対象三項は、二次行列の指数級数、クロネッカー積の成分と積、二つの転送行列表示の置換を一段ずつ計算しており、現行の説明粒度検査に合格している。外部入力では、混在した記号定義、集合と代数構造の記号、複素数、行列指数関数とその収束・可換積公式に説明粒度の未解決が残る。とくにtanhと実対数の独立した先行定義は未整備であり、順10の分割時に補う必要がある。",
}, {
  name: "全スピン反転行列から定める二つの行列",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: epsilonProjectorDefinitionSectionEntryIds,
  input: [
    "混在した記号定義に含まれる全スピン反転行列",
    "複素数と有限複素行列の単位行列・和・スカラー倍",
  ],
  externalInputEntryIds: epsilonProjectorDefinitionSection.externalInputEntryIds,
  output: [
    "全スピン反転行列と単位行列の和・差から定める二つの行列",
  ],
  concludingDefinition: "全スピン反転行列から作る二つの行列",
  concludingDefinitionEntryId: "bridge_008_definition_epsilon_projectors",
  boundaryEvidence: "章内依存順16の一項は全スピン反転行列だけをイジング固有の入力として二つの行列を定める。次の章内依存順17は双対結合定数と双曲線関数の略記だけを使い、本項へ依存しない。外部入力集合が切り替わるため、順16の後で一項の節を閉じる。これらが固有空間への射影子であることは後続主張で証明するため、本節の出力には含めない。生成時に対象と全外部入力の本文 fingerprint、章内順、節末出力の一意性、次項の直接依存、および次項からの非依存を固定検査する。",
  readabilityStatus: "対象定義は単位行列と全スピン反転行列の和・差とスカラー倍として具体的に書かれ、現行の説明粒度検査に合格している。外部入力では、混在した記号定義と複素数の定義に説明粒度の未解決が残る。射影子性は章内依存順24の後続主張で証明される。",
}, {
  name: "臨界条件からの差を表す実数",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: kappaDefinitionSectionEntryIds,
  input: [
    "混在した記号定義に含まれる二つの正の結合定数と双対結合定数",
    "実数の差とスカラー倍",
  ],
  externalInputEntryIds: kappaDefinitionSection.externalInputEntryIds,
  output: ["二つの結合定数の差を二倍した実数 κ"],
  concludingDefinition: "臨界条件からの差を表す実数 κ",
  concludingDefinitionEntryId: "critical_002_definition_kappa",
  boundaryEvidence: "章内依存順17の一項は結合定数と双対結合定数の差だけから κ を定める。次の章内依存順18は双曲線正弦の積を定めるため基本性質を追加で入力し、κ へ依存しない。外部入力集合が切り替わるため、順17の後で一項の節を閉じる。生成時に対象と全外部入力の本文 fingerprint、章内順、節末定義の一意性、次項からの非依存を固定検査する。",
  readabilityStatus: "対象定義は二つの正の実数の差と二倍だけで具体的に書かれ、現行の説明粒度検査に合格している。外部入力である混在した記号定義には分割が残る。",
}, {
  name: "二つの双曲線正弦の積",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: criticalSinhProductDefinitionSectionEntryIds,
  input: [
    "混在した記号定義に含まれる二つの正の結合定数と双対結合定数",
    "実数の双曲線正弦の定義と正値性",
  ],
  externalInputEntryIds: criticalSinhProductDefinitionSection.externalInputEntryIds,
  output: ["二つの正の双曲線正弦の積 A"],
  concludingDefinition: "二つの双曲線正弦の積 A",
  concludingDefinitionEntryId: "critical_002a_definition_critical_sinh_product_A",
  boundaryEvidence: "章内依存順18の一項は二つの正の双曲線正弦の積 A を定め、その正値性までを同じ定義の well-defined 性として確認する。順17の κ へ依存せず、次の章内依存順19は V1 の平方根として使う行列を別の行列指数関数入力から定めるため外部入力集合が切り替わる。したがって順18の後で一項の節を閉じる。生成時に対象と全外部入力の本文 fingerprint、章内順、節末定義の一意性、前後項からの非依存を固定検査する。",
  readabilityStatus: "対象定義は二つの正の実数へ双曲線正弦を適用して積を取る具体的な計算であり、正値性の根拠も明示しているため、現行の説明粒度検査に合格している。外部入力である混在した記号定義と双曲線関数の基本性質には分割が残る。",
}, {
  name: "転送行列の平方根・対称化転送行列・トレース公式",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: symmetrizedTransferMatrixSectionEntryIds,
  input: [
    "混在した記号定義に含まれる転送行列 V1・V2、格子幅と周期規約",
    "可換な複素行列の指数関数の積公式",
    "分配関数のパウリ行列表示と有限複素行列のトレースの巡回性",
  ],
  externalInputEntryIds: symmetrizedTransferMatrixSection.externalInputEntryIds,
  output: [
    "V1 の平方根として使う具体的な行列 V1^{1/2}",
    "V1^{1/2} で V2 を挟んだ対称化転送行列 W",
    "分配関数を W の冪のトレースで表す公式",
  ],
  mainTheorem: "V1V2 の冪と W の冪のトレースが一致する公式",
  mainTheoremEntryId: "maxeig_002_claim_Z_equals_trace_of_W",
  boundaryEvidence: "章内依存順19で V1 の平方根として使う行列を定め、順20でその行列と V2 から W を定め、順21でトレースの巡回性により分配関数の表示へ閉じる。三項は一方向の依存鎖をなし、節末のトレース公式だけが三項をまとめた数学的帰結である。順22の W の成分正値性は二つの定義を再利用するがトレース公式へ依存せず、標準基底上の対角作用と V2 の成分表示という別の入力を追加するため、順21の後で節を閉じる。生成時に三項の連続性、内部依存辺、対象と全外部入力の本文 fingerprint、節末出力の一意性に加え、順22の本文・直接依存・トレース公式からの非依存を固定検査する。",
  readabilityStatus: "二つの定義を別ブロックに分けたため、各ブロックは一つの行列だけを定める。平方根の意味は可換な行列指数関数の積公式で確認し、トレース公式は有限行列の積と巡回性だけで証明されており、対象三項は現行の説明粒度検査に合格している。外部入力である混在した記号定義には分割が残る。",
}, {
  name: "対称化転送行列の全成分正値性",
  chapter: "2次元イジングモデル",
  status: "構造確定・本文粒度確認済み",
  entryIds: positiveSymmetrizedTransferMatrixEntriesSectionEntryIds,
  input: [
    "スピン配置と標準基底の多重添字の対応",
    "サイトごとの σz の対角作用、対角行列の指数関数、実指数関数の正値性",
    "V2 の正の実数成分表示",
    "V1 の平方根として使う正の対角行列と、それで V2 を挟んだ対称化転送行列 W",
  ],
  externalInputEntryIds: positiveSymmetrizedTransferMatrixEntriesSection.externalInputEntryIds,
  output: ["対称化転送行列 W のすべての成分が正の実数であること"],
  mainTheorem: "対称化転送行列 W の全成分正値性",
  mainTheoremEntryId: "maxeig_004_claim_W_has_positive_entries",
  boundaryEvidence: "章内依存順22の一項は、V1 の平方根の正の対角成分と V2 の正の成分を、W の成分ごとの行列積へ代入して全成分正値性へ閉じる。直後の章内依存順23の Z_m,Y_m の線型独立性は、サイト作用素の記号、Pauli 行列から作るクロネッカー積基底とその積の規則だけを入力とし、本項との相互依存がない。直接入力集合が完全に切り替わるため、順22の後で一項の節を閉じる。生成時に対象と全外部入力の本文 fingerprint、章内順、節末出力の一意性、順23の直接依存・本文 fingerprint、および二項間の相互非依存を固定検査する。",
  readabilityStatus: "対象本文は、実指数関数の正値性を明示参照したうえで、正の対角行列と正の成分を持つ行列の積を成分ごとに有限和へ展開している。対象と外部入力はいずれも現行の説明粒度検査に合格している。",
}, {
  name: "Jordan–Wigner 行列の線型独立性",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: zYLinearIndependenceSectionEntryIds,
  input: [
    "サイトごとの Pauli 行列から定める Jordan–Wigner 行列 Z_m,Y_m",
    "二次の Pauli 行列が作る基底と、そのクロネッカー積が作る多因子行列の基底",
    "クロネッカー積の積の規則",
  ],
  externalInputEntryIds: zYLinearIndependenceSection.externalInputEntryIds,
  output: ["2M 個の Jordan–Wigner 行列 Z_1,…,Z_M,Y_1,…,Y_M の複素数上の線型独立性"],
  mainTheorem: "Jordan–Wigner 行列 Z_m,Y_m の線型独立性",
  mainTheoremEntryId: "transfer_matrix_002_claim_Z_Y_linearly_independent",
  boundaryEvidence: "章内依存順23の一項は、各 Z_m,Y_m を Pauli 行列からなるクロネッカー積基底の相異なる元として表示し、基底表示の一意性から線型独立性へ閉じる。直後の章内依存順24は V1,V2 を Jordan–Wigner 行列で表すが、この線型独立性を使わず、クロネッカー積基底を入力から外して Pauli 行列の積とクロネッカー積の多重線型性を追加する。二項に相互依存がなく外部入力集合も切り替わるため、順23の後で一項の節を閉じる。生成時に対象と全外部入力の本文 fingerprint、章内順、節末出力の一意性、順24の直接依存・本文 fingerprint、二項間の相互非依存、および入力集合の追加・除外を固定検査する。",
  readabilityStatus: "対象本文は、二次の Pauli 行列を成分比較で基底と確認し、Z_m,Y_m をクロネッカー積基底の相異なる多重添字へ対応させたうえで、基底表示の一意性から結論しているため、現行の説明粒度検査に合格している。外部入力では、集合と代数構造の記号、複素数の定義、および混在したサイト作用素の記号定義に分割が残る。",
}, {
  name: "V1・V2 の Jordan–Wigner 行列表示",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: v1V2JordanWignerSectionEntryIds,
  input: [
    "V1・V2、Jordan–Wigner 行列 Z_m,Y_m、全スピン反転行列 ε と結合定数の記号",
    "単一サイトの Pauli 行列の積",
    "クロネッカー積の積の規則と各因子についての複素線型性",
  ],
  externalInputEntryIds: v1V2JordanWignerSection.externalInputEntryIds,
  output: [
    "V1 の指数を Jordan–Wigner 行列と全スピン反転行列で表す等式",
    "V2 の指数を Jordan–Wigner 行列で表す等式",
  ],
  mainTheorem: "V1 の Jordan–Wigner 行列表示",
  mainTheoremEntryId: "transfer_matrix_003_claim_V1_in_Z_Y_epsilon",
  boundaryEvidence: "章内依存順24–25は、旧ブロックに束ねられていた独立な二等式を V1 と V2 の二つの主張へ分けたものである。順24は隣接サイト項と周期境界項を、順25は単一サイト項を、Pauli 行列の積とクロネッカー積の規則からそれぞれ Jordan–Wigner 行列で計算する。二項は同じ外部入力を共有する並行した出力で、相互依存はない。直後の章内依存順26は全スピン反転行列 ε の二つの固有空間を定義するだけで、二つの表示のどちらも使わない。順26では Pauli 行列の積とクロネッカー積の規則を入力から外し、行列を数ベクトル空間上の線型写像として作用させる対応を追加するため、順25の後で二項の節を閉じる。生成時に二項と全外部入力の本文 fingerprint、章内順、内部依存がないこと、二つの節末出力、順26の直接依存・本文 fingerprint、節と順26との相互非依存、および入力集合の追加・除外を固定検査する。",
  readabilityStatus: "V1 と V2 の独立した等式を別ブロックへ分けた。V1 は単一サイトの Pauli 行列積から隣接項・周期境界項を、V2 は単一サイト項を、それぞれクロネッカー積で一段ずつ導いており、両方とも現行の説明粒度検査に合格している。外部入力では、集合と代数構造の記号、複素数の定義、および混在したサイト作用素の記号定義に分割が残る。直後の固有空間定義には抽象線型写像の記述が残る。",
}, {
  name: "全スピン反転行列の固有空間と相補射影",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度未解決・外部入力粒度未解決",
  entryIds: epsilonEigenspacesAndComplementaryProjectorsSectionEntryIds,
  input: [
    "全スピン反転行列 ε と、ε と単位行列の和・差から定めた二つの行列 P^{(±)}",
    "有限複素行列を数ベクトル空間上の線型写像として作用させる対応と、その積の保存",
    "Pauli 行列の二乗とクロネッカー積の積・単位元の規則",
  ],
  externalInputEntryIds: epsilonEigenspacesAndComplementaryProjectorsSection.externalInputEntryIds,
  output: [
    "全スピン反転行列の固有値 +1 と −1 に対応する二つの固有空間",
    "全スピン反転行列の二乗が単位行列であり、その作用の固有値が +1 または −1 に限ること",
    "P^{(+)} と P^{(-)} が互いに補い合い、それぞれの像が対応する固有空間に一致すること",
  ],
  mainTheorem: "全スピン反転行列から作る二つの行列が対応する固有空間への相補射影であること",
  mainTheoremEntryId: "bridge_009_claim_epsilon_projector_properties",
  boundaryEvidence: "章内依存順26–28は、順26で全スピン反転行列 ε の固有空間を定め、これと相互依存しない順27で ε²=I と固有値が ±1 に限ることを証明し、順28で順26の固有空間と順27の二乗公式を合わせて二つの行列の冪等性・相互直交性・和・像を計算する。従来は相補射影の主張に二乗公式が重複して含まれ、その証明が固有空間の定義を二乗公式の根拠として誤参照していた。二乗・固有値を独立した主張へ分け、順26と順27が順28へ合流する依存形に直した。直後の順29は順26の固有空間だけを再利用して V1 の制限へ分岐し、順27の二乗・固有値と順28の相補射影には依存しない。順29では P^{(±)} の定義とクロネッカー積の積の規則を入力から外し、V1 の Jordan–Wigner 行列表示、一因子の反可換性、ノルムの基本性質の数ベクトル版、行列指数関数の作用保存を追加するため、順28の主定理で節を閉じる。生成時に三項の連続性、順28へ入る二本の内部依存辺、節内本文と全外部入力の fingerprint、節末出力の一意性、順29の章内順・直接依存・本文、順29が順27・28へ依存しないこと、および入力集合の追加・除外を固定検査する。",
  readabilityStatus: "二乗公式を相補射影の主張から重複して述べる箇条書きを除き、相補射影という一つの主張の三組の等式へ整理した。二乗と固有値は二乗公式から固有値の候補を絞る一方向の主張であり、相補射影の証明も有限行列の分配法則とベクトルへの作用を一段ずつ記すため、この二項は現行の説明粒度検査に合格している。固有空間の定義には抽象線型写像の記述が残るため、対象本文全体は未完成として扱う。外部入力にも、複素数の定義、混在したサイト作用素の記号定義、行列と線型写像の対応および積の保存に説明粒度の未解決が残る。",
}, {
  name: "V1 の固有空間への制限",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度未解決・外部入力粒度未解決",
  entryIds: v1RestrictionToEigenspacesSectionEntryIds,
  input: [
    "V1 の Jordan–Wigner 行列表示と全スピン反転行列の二つの固有空間",
    "Pauli 行列の積と、一因子だけが反可換なクロネッカー積の反交換公式",
    "ノルムの非負性・三角不等式・非退化性の数ベクトル版",
    "有限複素行列から数ベクトル上の作用への対応、その積・線型結合・指数関数の保存",
  ],
  externalInputEntryIds: v1RestrictionToEigenspacesSection.externalInputEntryIds,
  output: [
    "V1 の作用を全スピン反転行列の各固有空間へ制限すると、境界項の符号だけを固定した指数行列の作用に一致すること",
  ],
  mainTheorem: "V1 の固有空間への制限",
  mainTheoremEntryId: "transfer_matrix_006_claim_V1_restriction_to_eigenspaces",
  boundaryEvidence: "章内依存順29の一項は、V1 の Jordan–Wigner 行列表示、全スピン反転行列の固有空間、ノルムの基本性質の数ベクトル版を入力に、全スピン反転行列を固有値 ±1 へ置き換え、行列指数関数の部分和を通じて V1 の作用を各固有空間へ制限する主張へ閉じる。直後の章内依存順30は、境界項の符号を固定した二つの指数行列 V1^{(±)} を定義するだけで順29を参照せず、順29も証明内の局所的な略記として同じ指数行列を自足的に定めるため、二項に相互依存はない。順30は転送行列とサイト作用素の記号定義を順29と共有する一方、V1 の Jordan–Wigner 表示、固有空間、一因子の反可換性、ノルムの基本性質の数ベクトル版、作用対応の積・指数保存を入力から外し、線型写像の指数関数の定義を追加するため、外部入力集合も切り替わる。したがって順29の後で一項の節を閉じる。生成時に対象と全外部入力の本文 fingerprint、章内順、節末出力の一意性、順30の直接依存・本文 fingerprint、二項間の相互非依存、および入力集合の追加・除外を固定検査する。",
  readabilityStatus: "対象は複素行列の積・反交換・有限和・部分和の極限を一段ずつ展開しているが、行列と抽象線型写像の対応を証明全体で往復しており、現行の説明粒度検査では未完成である。外部入力にも、集合と代数構造の記号、複素数、混在したサイト作用素の記号、ノルムの基本性質の数ベクトル版、行列と線型写像の対応および指数関数保存に説明粒度の未解決が残る。直後の V1^{(±)} の定義自体は現行の説明粒度検査に合格している。",
}, {
  name: "境界項の符号を固定した指数行列・全スピン反転対称性・セクター上の置き換え",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度合格・外部入力粒度未解決",
  entryIds: v1PlusMinusAndCommutationSectionEntryIds,
  input: [
    "境界項の符号を固定した指数行列を作る転送行列・サイト作用素の記号",
    "Pauli 行列の積と、相異なるサイトに置いた因子の積の規則",
    "全スピン反転行列から作る二つの相補射影の定義・像・冪等性",
    "V1 の作用を全スピン反転行列の二つの固有空間へ制限した等式",
    "行列指数関数、その部分和、および行列積と極限の交換",
  ],
  externalInputEntryIds: v1PlusMinusAndCommutationSection.externalInputEntryIds,
  output: [
    "境界項の符号を固定した二つの指数行列 V1^{(±)}",
    "半指数行列として定めた行列の二乗が V1^{(±)} に等しいこと",
    "全スピン反転行列と V1・V2・V1^{(±)}・その平方根との可換性",
    "二つの相補射影と V1・V2・V1^{(±)}・その平方根との可換性",
    "各セクターへの射影後は V1 を V1^{(±)} へ置き換えられること",
    "その置き換えを転送行列の積の任意の非負整数冪へ反復できること",
  ],
  mainTheorems: [
    "全スピン反転行列と転送行列および境界項の符号を固定した指数行列との可換性",
    "セクター上での V1 の置き換え",
  ],
  mainTheoremEntryIds: [
    "bridge_010_claim_epsilon_commutes",
    "bridge_011_claim_sector_replacement",
  ],
  concludingCorollary: "セクター上での置き換えを転送行列の積の非負整数冪へ反復する公式",
  concludingCorollaryEntryId: "bridge_011a_claim_sector_replacement_pow",
  boundaryEvidence: "章内依存順30で V1^{(±)} を定義する。順31はこの定義と既に閉じた V1 の固有空間への制限・相補射影の像から、射影後の V1 を V1^{(±)} へ置き換える主定理へ進む。並行して順32–35は半指数行列とその平方根性、全スピン反転行列との可換性、相補射影との可換性へ進む。順36は順31の置換等式、相補射影の冪等性、順35の可換性を合流させ、置き換えを転送行列の積の任意の非負整数冪へ反復する系で節を閉じる。直後の順37は V1^{(±)} の定義を再利用するが、順31–36の主張には依存せず、Pauli 行列の積とクロネッカー積の転置から iK1H1^{(±)} と iK2*H2 の実対称性を示す。生成時に七項の連続性と内部依存、対象と全外部入力の本文 fingerprint、順36への一意な閉包、順37の直接依存・本文 fingerprint、順31–36からの非依存、および入力集合の追加・除外を固定検査する。",
  readabilityStatus: "未定義だった H1^{(±)} を使わず、半指数行列の定義・平方根性・二種類の可換性を別ブロックにした。さらに、射影後の V1 の置き換えと、その置き換えを積の冪へ反復する系を別ブロックへ分けた。対象七項は一ブロック一主張で依存順に読め、現行の説明粒度検査に合格している。外部入力では集合と代数構造の記号、複素数、混在した転送行列・サイト作用素の記号、行列指数関数、固有空間への制限、行列と線型写像の対応に説明粒度の未解決が残る。",
}, {
  name: "実対称な生成子と符号反転共役",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度確認済み・外部入力粒度未解決",
  entryIds: realSymmetricGeneratorsAndSignFlipSectionEntryIds,
  input: [
    "転送行列・サイト作用素と境界項の符号を固定した二つの生成子",
    "Pauli 行列の積と、相異なるサイトに置いた因子の積の規則",
    "具体的なクロネッカー積の成分と転置",
    "有限複素行列のエルミート性の定義",
  ],
  externalInputEntryIds: realSymmetricGeneratorsAndSignFlipSection.externalInputEntryIds,
  output: [
    "二つの生成子を実係数の Pauli 行列積として表し、実対称性を示すこと",
    "両方の生成子の符号を同時に反転する可逆行列による共役",
  ],
  mainTheorems: [
    "境界項の符号を固定した生成子と双対結合の生成子が実対称であること",
    "二つの生成子を同時に符号反転する共役",
  ],
  mainTheoremEntryIds: [
    "eigenvalues_of_V_014_claim_iH_is_real_symmetric",
    "eigenvalues_of_V_016_claim_sign_flip_conjugation",
  ],
  boundaryEvidence: "章内依存順45で一般の H1^{(±)},H2 を定義する。順46は Pauli 行列の積とクロネッカー積の転置を使い、iK1H1^{(±)} と iK2*H2 を実係数の Pauli 行列積として表して実対称性を示す。順47は順46で得た H2 の表示を直接用い、両方の生成子を同時に負号へ移す可逆行列による共役へ進むため、二項は一方向の内部依存で連続する。後続の正定値性は順46の実対称性だけを再利用して順47には依存せず、順48の偶セクター生成子は一般定義から上符号を選ぶ別枝である。したがって実対称性と符号反転共役を二出力として順47で節を閉じる。生成時に二項の連続性、全直接依存、本文 fingerprint、後続二枝の依存差、および入力集合の切り替わりを固定検査する。",
  readabilityStatus: "実対称性は二次の Pauli 行列の積、サイトごとの積、クロネッカー積の転置を一段ずつ計算し、符号反転共役は各サイトの共役から生成子の各項へ進むため、対象二項は現行の説明粒度検査に合格している。外部入力では集合と代数構造の記号、複素数、混在した転送行列・サイト作用素の記号に説明粒度の未解決が残る。",
}, {
  name: "偶セクター生成子のスピン作用素表示",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度合格・外部入力粒度未解決",
  entryIds: evenSectorGeneratorSectionEntryIds,
  input: [
    "一般の生成子 H1^{(±)}, H2 と境界項の符号を固定した指数行列 V1^{(±)}, V2 の複合定義",
    "Jordan–Wigner 行列と全スピン反転行列のサイトごとの Pauli 行列表示",
    "クロネッカー積の積の規則と、スピン配置に対応する標準基底上の σz の作用",
  ],
  externalInputEntryIds: evenSectorGeneratorSection.externalInputEntryIds,
  output: [
    "偶セクターの生成子 H1^{(+)} の定義",
    "開鎖項 D0 と周期境界項 G の定義",
    "iH1^{(+)} を隣接する σz の積と周期境界項で表す等式",
    "開鎖項と境界項の対角作用、全スピン反転行列との可換性、および境界項を含む行列の二乗",
  ],
  mainTheorems: [
    "偶セクターの生成子のスピン作用素表示と配置基底上の対角作用",
    "全スピン反転行列・開鎖項・境界項の可換性と境界項を含む行列の二乗",
  ],
  mainTheoremEntryIds: [
    "closing_004_claim_H1_plus_in_sigma_z_form",
    "closing_claim_D0_G_diagonal_action",
    "closing_claim_epsilon_G_is_involution",
  ],
  boundaryEvidence: "章内依存順48で一般の H1^{(±)} の定義から上符号を選び、偶セクターの生成子 H1^{(+)} を一対象だけ定める。順49–50の開鎖項 D0 と周期境界項 G は H1^{(+)} に意味的依存しない並行定義であり、読み順だけを提示順制約で固定する。順51はこの三定義を受け取り、Jordan–Wigner 行列をサイトごとの Pauli 行列積へ展開して iH1^{(+)}=D0+εG を示す。順52の対角作用と順53の可換性も相互に意味的依存しない出力で、提示順だけを固定する。順54は順53の可換性を使った (εG)^2=I を示す。直後の順55は順48だけを再利用して V1^{(+)} の半指数行列を定義し、順49–54の出力を使わない。順55では Pauli 行列積、配置基底、クロネッカー積、全スピン反転行列を入力から外すため、順54で節を閉じる。生成時に七項の連続性、項目ごとの全直接依存、意味的依存とは分離した提示順、対象と全外部入力の本文 fingerprint、三つの節末出力、順55の直接依存・本文・順49–54からの非依存、および入力集合の切り替わりを固定検査する。",
  readabilityStatus: "生成子、半指数行列、転送行列、共役写像、可逆性、平方根性、共役合成一致を束ねていた旧定義ブロックを一ブロック一定義または一主張へ分割した。さらに、局所積、境界項、生成子表示、可換性、二乗、対角作用を束ねていた旧主張を、D0 の定義、G の定義、生成子表示、対角作用、二つずつの可換性、二乗へ分割した。対象七項は生成子の定義から二次の Pauli 行列積とクロネッカー積の有限計算を経て三つの節末出力へ進み、現行の説明粒度検査に合格している。外部入力では集合と代数構造の記号、複素数、混在した転送行列・サイト作用素の記号に加え、H1^{(±)}, H2 と V1^{(±)}, V2 を束ねた複合定義に説明粒度の未解決と将来の分割が残る。",
}, {
  name: "偶セクターの半指数行列と平方根性",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度合格・外部入力粒度未解決",
  entryIds: v1PlusHalfExponentAndSquareRootSectionEntryIds,
  input: [
    "一般の生成子から上符号を選んだ偶セクター生成子 H1^{(+)}",
    "境界項の符号を固定した指数行列 V1^{(+)} の定義",
    "可換な有限複素行列の指数関数の積公式",
  ],
  externalInputEntryIds: v1PlusHalfExponentAndSquareRootSection.externalInputEntryIds,
  output: [
    "V1^{(+)} の半指数行列として用いる具体的な行列",
    "その行列の二乗が V1^{(+)} に等しいこと",
  ],
  mainTheorem: "偶セクターの半指数行列の平方根性",
  mainTheoremEntryId: "evensectorT_claim_V1_plus_square_root",
  boundaryEvidence: "章内依存順55で偶セクター生成子 H1^{(+)} から半指数行列を定義し、順56で可換な行列指数関数の積公式と V1^{(+)} の定義を使って、その二乗が V1^{(+)} に等しいことを示す。二項は一方向の依存鎖をなし、平方根性で閉じる。直後の順57は半指数行列の定義だけを再利用して V2 と挟み、偶セクター転送行列 V^{(+)} を定義するが、順56の平方根性には依存しない。順57では転送行列の記号を入力へ追加し、偶セクター生成子、指数関数の積公式、V1^{(±)} の一般定義を直接入力から外すため、順56の後で節を閉じる。生成時に二項の連続性、全直接依存、対象と全外部入力の本文 fingerprint、順56への一意な閉包、順57の直接依存・本文・順56からの非依存、および入力集合の切り替わりを固定検査する。",
  readabilityStatus: "定義は一つの有限複素行列だけを定め、平方根性は同じ行列指数関数を二回掛ける計算を一段ずつ示しているため、対象二項は現行の説明粒度検査に合格している。外部入力では複素数、H1^{(±)}, H2 と V1^{(±)}, V2 を束ねた一般の生成子定義、および可換な行列指数関数の積公式に説明粒度の未解決が残る。",
}, {
  name: "偶セクター転送行列と符号付きトレースの正値公式",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度合格・外部入力粒度未解決",
  entryIds: vPlusDefinitionAndSignedTraceSectionEntryIds,
  input: [
    "V1^{(+)} の半指数行列と V2",
    "全スピン反転行列、開鎖項、周期境界項の配置基底上の作用と可換性",
    "配置基底上の対角指数、有限行列のトレース、および開鎖イジング模型の有限和公式",
  ],
  externalInputEntryIds: vPlusDefinitionAndSignedTraceSection.externalInputEntryIds,
  output: [
    "偶セクター転送行列 V^{(+)} の定義",
    "符号付きトレース tr(εV^{(+)}) の厳密な正値公式",
  ],
  mainTheorem: "偶セクター転送行列の符号付きトレースの正値公式",
  mainTheoremEntryId: "closing_006_theorem_trace_of_epsilon_V_plus",
  boundaryEvidence: "章内依存順57で V1^{(+)} の半指数行列と V2 を掛け合わせて偶セクター転送行列 V^{(+)} を定義し、順58で配置基底上の対角作用、全スピン反転行列との可換性、開鎖イジング模型の有限和を使って tr(εV^{(+)}) を明示的な正の実数へ計算する。二項は定義から正値公式へ進む一方向の依存鎖をなす。直後の順59は V^{(+)} の定義を再利用するが、エルミート正定値行列の指数関数と実対称生成子を入力に正定値性を示す別枝であり、順58のトレース公式には依存しない。順58も順59に依存せず、両者の全直接依存集合は異なるため、順58の後で節を閉じる。生成時に二項の連続性と全直接依存、対象と全外部入力の本文 fingerprint、順58への一意な閉包、順59の直接依存・本文、順58と順59の相互非依存、および対象三項の説明粒度を固定検査する。",
  readabilityStatus: "順57は一つの有限複素行列だけを定義する。順58は符号付きトレースを配置基底和へ直し、開鎖スピン配置の有限和を因数分解して正の閉形式へ至る一つの計算鎖であり、対象二項は現行の説明粒度検査に合格している。三項以上の本文分割または形式化同期は不要だった。外部入力では集合と代数構造の記号、複素数、混在した転送行列・サイト作用素の記号、H1^{(±)}, H2 と V1^{(±)}, V2 を束ねた複合定義、行列指数関数の定義と可換積公式、および行列と線型写像の対応に説明粒度の未解決が残る。",
}, {
  name: "偶セクター転送行列の正定値性・可逆性とトレース正値性",
  chapter: "2次元イジングモデル",
  status: "構造確定・対象本文粒度合格・外部入力粒度未解決",
  entryIds: vPlusPositiveDefiniteSectionEntryIds,
  input: [
    "偶セクター転送行列 V^{(+)} とその半指数行列",
    "二つの生成子の実対称性",
    "エルミート正定値行列と行列指数関数の正定値性",
    "可換な有限複素行列の指数関数の積公式と零行列の指数関数",
  ],
  externalInputEntryIds: vPlusPositiveDefiniteSection.externalInputEntryIds,
  output: [
    "V^{(+)} の正定値性",
    "tr(V^{(+)}) の正値性",
    "V^{(+)} の左右逆と逆行列の明示式",
    "(V^{(+)})^{-1} の正定値性",
    "tr((V^{(+)})^{-1}) の正値性",
  ],
  boundaryCandidates: vPlusPositiveDefiniteBoundaryCandidates,
  nextTickUnit: vPlusPositiveDefiniteNextTickUnit,
  formalizationEvidence: {
    leanFile: vPlusPositiveDefiniteLeanFile,
    sageMathFiles: [
      vPlusPositiveDefiniteSageMathFile,
      vPlusRightInverseSageMathFile,
      vPlusLeftInverseSageMathFile,
      vPlusInversePositiveDefiniteSageMathFile,
    ],
    currentStatus: "本文は V^{(+)} の正定値性、tr(V^{(+)}) の正値性、可逆性、(V^{(+)})^{-1} の正定値性、tr((V^{(+)})^{-1}) の正値性を一主張ずつに分け、Lean の VPlus_posDef、trace_VPlus_pos、VPlus_mul_VPlusInv、VPlusInv_mul_VPlus、VPlusInv_posDef、trace_VPlusInv_pos との対応を記録した。SageMath は左右逆、候補逆行列の全固有値正値性、および二つのトレース正値性を検査する。",
  },
  mainTheorem: "偶セクター転送行列の逆行列のトレース正値性",
  mainTheoremEntryId: "evenEigen_claim_V_plus_inverse_positive_and_traces",
  boundaryEvidence: "章内依存順59は順57の V^{(+)} の定義と順46の生成子の実対称性を受けて V^{(+)} の正定値性を示す。順60の tr(V^{(+)}) の正値性は順59だけを直接使う並行出力である。順61は順59を受けて明示候補が左右逆であることから可逆性と逆行列の式を示し、順62は順61の明示式と順46の実対称性を使って (V^{(+)})^{-1} の正定値性を示す。順63は節内では順62だけを直接受け、外部入力の正定値行列の指数関数と集合・代数構造の記号も用いて tr((V^{(+)})^{-1}) の正値性を示す。Lean はこれらを VPlus_posDef、trace_VPlus_pos、VPlus_mul_VPlusInv、VPlusInv_mul_VPlus、VPlusInv_posDef、trace_VPlusInv_pos で検証する。SageMath は左右逆を別々に検査し、候補逆行列の全固有値について虚部の最大値が 1.732×10^{-14}、実部の最小値が 5.145×10^{-4}>0 であること、および tr((V^{(+)})^{-1}) の全体最小値が 1.032>0 であることを検査した。直後の順64は同じ V^{(+)} と半指数行列を再利用するものの、一般の行列指数関数の逆行列公式と可逆元の積から三つの構成因子の可逆性を示す別枝であり、順59〜63とは相互に依存しない。順65は順64だけへ依存する。この入力集合の切り替わりにより順63の後で節を閉じる。生成時には順59〜63の全直接依存、二つの節末出力、本文 fingerprint、Lean 宣言、SageMath の実検査、順64〜65との相互非依存、および入力集合の切り替わりを固定検査する。",
  readabilityStatus: "順63は既に一ブロック一主張であり、直前に確定した (V^{(+)})^{-1} の正定値性から、正定値行列のトレースが正であることを一段だけ適用している。Lean の trace_VPlusInv_pos も VPlusInv_posDef に trace_pos を一段適用する同じ推論で、SageMath は候補逆行列のトレース正値性を直接検査する。したがって対象本文の推論粒度と形式化対応は合格であり、順63の後を節境界として確定する。外部入力では集合と代数構造の記号、複素数、混在した転送行列・サイト作用素の記号、一般の生成子定義、および可換な行列指数関数の積公式に説明粒度の未解決が残る。",
}, {
  name: "偶セクター転送行列の構成因子の可逆性",
  chapter: "2次元イジングモデル",
  status: "先頭二主張を分割・同期済み、残る一主張が境界候補",
  entryIds: [v1PlusHalfInvertibleEntry.id, vTwoInvertibleEntry.id, vPlusFactorsInvertibleEntry.id],
  input: [
    "偶セクターの半指数行列、第二の転送行列 V_2、および偶セクター転送行列 V^{(+)} の定義",
    "有限複素行列の指数関数の逆行列公式",
    "可逆行列の積と非零スカラー倍の可逆性",
  ],
  output: [
    "偶セクターの半指数行列が可逆であること",
    "第二の転送行列 V_2 が可逆であること",
    ...vPlusFactorsInvertibilityBoundaryCandidates.map(({ output }) => output),
  ],
  boundaryCandidates: vPlusFactorsInvertibilityBoundaryCandidates,
  nextTickUnit: vPlusFactorsInvertibilityNextTickUnit,
  formalizationEvidence: {
    leanFiles: [vPlusFactorsInvertibilityLeanFile, vTwoInvertibilityLeanFile],
    sageMathFile: vPlusFactorsInvertibilitySageMathFile,
    currentStatus: "本文は半指数行列と V_2 の可逆性を独立主張へ分け、Lean の isUnit_V1halfPlus・isUnit_V2 と SageMath の各逆行列積検査へ新ラベルを同期した。V^{(+)} の可逆性は両主張を直接入力とする一主張として残る。",
  },
  mainTheorems: [
    "偶セクターの半指数行列が可逆であること",
    "第二の転送行列 V_2 が可逆であること",
  ],
  boundaryEvidence: "確定済みの正定値性・可逆性とトレース正値性の節に続き、順64は指数行列の逆行列公式だけから半指数行列の可逆性を示す。順65は同じ公式と正のスカラー倍の可逆性から V_2 の可逆性を示す。順66はこの二主張を直接入力として V^{(+)} の可逆性へ進む。隣接する共役写像の線型性は順66を直接入力の一つに持ち、入力集合も共役写像の定義と添字集合へ切り替わる。今回は順64–65だけを分割・形式化同期し、順66は次回一項の境界候補として残す。",
  readabilityStatus: "半指数行列と V_2 の可逆性は、一ブロック一主張としてそれぞれ指数行列の逆行列、正のスカラーと指数行列の積の逆行列だけを用いる形へ分離した。Lean と SageMath の対応も新ラベルへ同期済みで、対象二項は現行の説明粒度検査に合格する。V^{(+)} の可逆性と直後の共役写像の線型性には進まず、次回は V^{(+)} の可逆性一項だけをレビューする。",
}];
const toolEntries = entries.filter((entry) => entry.provisionalFinalChapter === "数学的道具立て");
const groupRules: [string, RegExp][] = [
  ["三角関数の評価・有限和・積分", /^(critical_008|critical_009|critical_010|freeenergy_004)/],
  ["トレース・共役転置・正定値性", /^eigenvalues_of_V_|^maxeig_005|frobenius|exp_conjugation_proof_003/],
  ["可逆行列・線型写像との対応・共役変換", /^transfer_matrix_005|^transfer_matrix_claim_end_|^TV1_hatZ_hatY_011|^TV1_hatZ_hatY_009|^TV1_hatZ_hatY_010|^TV1_hatZ_hatY_definition_pauli_group|exp_conjugation_proof_005|^calculation_formulae_046/],
  ["行列指数関数と交換子計算", /^exp_linear_map_|exp_conjugation_proof_(004|008|010)|^bridge_003|^TV1_hatZ_hatY_004/],
  ["数ベクトル・行列の長さと収束", /^linear_space_general_00(2b|2c|3|3b|3c|3d)/],
  ["クロネッカー積と多因子基底", /^linear_space_general_000|^linear_space_general_001/],
  ["有限行列・Pauli行列・交換子", /^linear_space_general_002_|^linear_space_general_004|^Z_Y_anticommutation_|calc_formulae_00[345]|calculation_formulae_047/],
  ["絶対値・偏角・複素平方根", /^calculation_formulae_03[1-9]|^calculation_formulae_04[0-4]/],
  ["角度・極座標・複素数の積と商", /^calc_formulae_01[1-9]|^calculation_formulae_02[2-9]|^calculation_formulae_030/],
  ["集合記号と複素数の直交座標計算", /set_and_algebra_notation|^calc_formulae_00[6-9]|^calc_formulae_010|^calculation_formulae_045|complex_conjugate/],
  ["実数の平方根・指数関数・双曲線関数", /^calc_formulae_000|^calc_formulae_001|^calc_formulae_002|^calc_formulae_definition_cosh_sinh|^critical_001/],
];
const groupOf = (entry: typeof entries[number]): string => {
  const matches = groupRules.filter(([, pattern]) => pattern.test(entry.id)).map(([name]) => name);
  if (matches.length !== 1) throw new Error(`数学的道具の分類規則一致数が1ではありません: ${entry.id}: ${matches.join(", ")}`);
  return matches[0]!;
};
const groupDescriptions = new Map([
  ["集合記号と複素数の直交座標計算", { input: "既知の自然数・整数・実数の集合と実数の四則演算", output: "集合と演算付き構造の区別、複素数を実数対として計算する規則", reason: "冒頭から記号の所属と演算を曖昧にせず、行列成分の計算へ進むため。" }],
  ["実数の平方根・指数関数・双曲線関数", { input: "非負実数と実数の級数", output: "平方根、指数関数、cosh・sinhの計算公式", reason: "行列成分に現れる係数を初等的な実数計算へ戻すため。" }],
  ["角度・極座標・複素数の積と商", { input: "平面上の実数対と円弧", output: "角度、極座標、複素数の積・逆数・商", reason: "複素固有値の位相を図形と四則演算で追うため。" }],
  ["絶対値・偏角・複素平方根", { input: "複素数の極座標表示", output: "絶対値、偏角、平方根とそれらの積・逆数の公式", reason: "固有値の大きさと平方根の枝を明示して計算するため。" }],
  ["クロネッカー積と多因子基底", { input: "2次の複素行列と2次元数ベクトル", output: "具体的なクロネッカー積、その積・転置・基底", reason: "抽象テンソル積を使わず、大きな行列を小さな行列の成分から組み立てるため。" }],
  ["有限行列・Pauli行列・交換子", { input: "有限複素行列と行列積", output: "分解、共役、交換子・反交換子、Pauli行列の積", reason: "後章の全操作を手で追える有限行列の掛け算へ落とすため。" }],
  ["数ベクトル・行列の長さと収束", { input: "複素行列の成分と有限和", output: "成分から定めるノルム、不等式、成分ごとの収束と完備性", reason: "無限級数を使う箇所でも、各成分の誤差を追える形にするため。" }],
  ["行列指数関数と交換子計算", { input: "有限行列、行列積、ノルム収束", output: "行列指数関数、可換積公式、交換子の反復による共役公式", reason: "転送行列の指数表示を、有限行列の級数と積の計算だけで扱うため。" }],
  ["可逆行列・線型写像との対応・共役変換", { input: "可逆な複素行列、行列単位、数ベクトルの基底", output: "行列と作用の一対一対応、逆行列による共役作用、Pauli/Clifford行列群", reason: "行列の式とベクトルへの作用を同じ成分表で行き来し、対称性を左右から掛ける計算で追うため。" }],
  ["トレース・共役転置・正定値性", { input: "複素行列、共役転置、固有ベクトル", output: "トレース公式、Frobenius内積、エルミート性、正定値性とCauchy–Schwarz評価", reason: "最大固有値と重複度を、成分和と二次式の符号から判定するため。" }],
  ["三角関数の評価・有限和・積分", { input: "連続な実数関数、有限和、初等的な三角関数の不等式", output: "リーマン和の極限、積分の閉形式と上下評価", reason: "有限サイズの行列計算から自由エネルギーと臨界挙動を読み取る最後の計算に必要なため。" }],
]);
const mathematicalToolGroups = [...groupDescriptions].map(([name, description]) => ({
  name, ...description,
  entryIds: toolEntries.filter((entry) => groupOf(entry) === name).sort((a, b) => a.dependencyPlacement!.chapterOrder - b.dependencyPlacement!.chapterOrder).map(({ id }) => id),
}));
const groupedToolIds = mathematicalToolGroups.flatMap(({ entryIds }) => entryIds);
if (groupedToolIds.length !== toolEntries.length || new Set(groupedToolIds).size !== toolEntries.length) {
  throw new Error("数学的道具立ての分類群が全項目を一意に被覆していません");
}
const allDependencyLabels = allBlocks.flatMap(({ block }) => [...collectTargets(block)]);
const dependencySupportNodes = allBlocks.filter(({ block }) => !targetIds.has(block.id)).map(({ file, block }) => ({
  id: block.id, kind: block.kind, title: blockTitle(block), labels: block.labels, sourceFile: file,
  dependsOnLabels: [...collectTargets(block)].sort(),
}));
const inventory = {
  schemaVersion: 3,
  scope: "exact-solution-of-2d-ising-model/structured-latex/content の全 definition・claim・theorem",
  organizingTheme: "高校生でも読める具体的な複素数・行列計算として2次元イジング模型の厳密解を積み上げる",
  withdrawnBoundaryAxes: ["実数解析への脱出を伴う道具／有限複素行列だけで閉じる道具", "可算／非可算"],
  boundaryRule: "章境界は対象の意味がイジング模型に依存するかだけで定め、解析や集合の濃度は章・節境界に使わない。",
  finalChapters,
  classificationStatus: "全項目の分類・説明粒度・ブロック境界を再検証し、章内依存順と数学的道具立ての分類群を確定済み。説明粒度の手動レビューで将来の分割対象とした複合定義は各項目に明記する。",
  entryCount: entries.length,
  chapterEntryCounts: Object.fromEntries(finalChapters.map((chapter) => [chapter, entries.filter((entry) => entry.provisionalFinalChapter === chapter).length])),
  mathematicalToolGroups,
  mathematicalToolSectionBoundaries,
  isingModelSectionBoundaries,
  explanationGranularityReview: {
    reviewedEntryCount: entries.length,
    criterion: "高度な抽象理論を導入せず、複素数と有限行列の具体的な計算を依存先から順に追えること",
    flaggedEntryIds: entries.filter((entry) =>
      entry.explanationGranularityReview.abstractVocabularyMatches.length > 0 || entry.explanationGranularityReview.forwardNavigationMixedIntoStatement || entry.explanationGranularityReview.manualReview !== null
    ).map(({ id }) => id),
  },
  mathematicalToolSemanticContaminationReview: {
    inspectedEntryCount: entries.filter((entry) => entry.provisionalFinalChapter === "数学的道具立て").length,
    contaminatedEntryIds: entries.filter((entry) => entry.provisionalFinalChapter === "数学的道具立て" && entry.classificationEvidence.isingSemanticMatches.length > 0).map(({ id }) => id),
  },
  chapterStructures,
  dependencySupportNodeCount: dependencySupportNodes.length,
  unnamedEntryIds: entries.filter(({ title }) => title === null).map(({ id }) => id),
  unlabeledEntryIds: entries.filter(({ labels }) => labels.length === 0).map(({ id }) => id),
  unresolvedInventoryDependencies: [...new Set(allDependencyLabels)].filter((label) => !labelOwners.has(label)).sort(),
  entries, dependencySupportNodes,
};
mkdirSync(dirname(outputPath), { recursive: true });
writeFileSync(outputPath, `${JSON.stringify(inventory, null, 2)}\n`);
console.log(`wrote ${entries.length} entries to ${outputPath}`);
