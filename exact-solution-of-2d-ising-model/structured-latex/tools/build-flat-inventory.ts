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
  "TV1_hatZ_hatY_015_claim_linearity_of_T",
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
  ["exp_conjugation_proof_010_theorem_matrix_exp_conjugation", "5bdb3ed5cd462b4bcdacbc754ee736c14abf5324e610b208bbd7da8582480874"],
  ["exp_conjugation_proof_008_theorem_exp_ad_series", "c06555b7aacaba911d0f832b2a5a07cbb81e56177f19e2a093be6356648dd95a"],
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
  ["linear_space_general_000b_claim_kronecker_product_rule", "33e23f14fdb3a2b277ed3327fa3edd342512113eb0eb3d327f88992d26a48bf9"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "8a73f81902220cd224baa17d4506c7af2e9e7597bda2e6918da88a3b3c1d23c5"],
  ["linear_space_general_001_theorem_tensor_product_basis", "0b14d498919e0e510b2e50b975d3379db4e963cb1dc5583d6bb429c782a7fd31"],
  ["exp_linear_map_001_theorem_exp_series_pointwise_converges", "7f8878116e4672d93d30e4babcccacab6bb2b8f8423348cbb9ba7e19d78af627"],
  ["exp_linear_map_002_definition_exp_of_endomorphism", "1b90c006155b2b723ad7169ab806c4fff82870687ce2865a7bc677a875134fa2"],
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
  ["linear_space_general_000b_claim_kronecker_product_rule", "33e23f14fdb3a2b277ed3327fa3edd342512113eb0eb3d327f88992d26a48bf9"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "8a73f81902220cd224baa17d4506c7af2e9e7597bda2e6918da88a3b3c1d23c5"],
  ["linear_space_general_001_theorem_tensor_product_basis", "0b14d498919e0e510b2e50b975d3379db4e963cb1dc5583d6bb429c782a7fd31"],
  ["linear_space_general_002_claim_scalar_identity_commutes", "2c83d104299b4e654c7e818045ba213e543e08102fa8dab8be6c54e26b7d830f"],
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
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "2040831405f933942bdff84147045e5feddd899546259e7449c6903c8411de65"],
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
  ["calc_formulae_003_matrix_decomposition", "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "33e23f14fdb3a2b277ed3327fa3edd342512113eb0eb3d327f88992d26a48bf9"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "8a73f81902220cd224baa17d4506c7af2e9e7597bda2e6918da88a3b3c1d23c5"],
  ["TV1_hatZ_hatY_009_definition_invertible_elements", "31432b10d571100575fc2bddf157032908bf0996d21d3f77860b0dc613fd7533"],
]);
const singleFactorAnticommutationSectionEntryIds = [
  "Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site",
] as const;
const singleFactorAnticommutationExpectedInternalDependencies = new Map<string, string[]>([
  ["Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site", []],
]);
const singleFactorAnticommutationExpectedContentSha256 = new Map<string, string>([
  ["Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site", "5fd0477a507f285dd767065c5e1633181bf87ee60a4779771f053a3933da6cf2"],
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
  ["linear_space_general_000b_claim_kronecker_product_rule", "33e23f14fdb3a2b277ed3327fa3edd342512113eb0eb3d327f88992d26a48bf9"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "8a73f81902220cd224baa17d4506c7af2e9e7597bda2e6918da88a3b3c1d23c5"],
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
  ["closing_005_claim_open_chain_spin_sums_positive", "0eb4cabfc0011b5c04adb17c333ee92850938340ad677b90d36c9768d7ea5a6a"],
]);
const openChainSpinSumsExpectedExternalInputEntryIds = [
  "calc_formulae_000b_claim_cosh_sinh_basic_properties",
  "calc_formulae_definition_cosh_sinh",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
  "partition_function_2d_ising_003_definition_transfer_matrix",
].sort();
const openChainSpinSumsExpectedExternalInputContentSha256 = new Map<string, string>([
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", "8eb7e83461c7dd3069ae859b9aa527374c7898d1e6f4609218e4f7caac34c68f"],
  ["calc_formulae_definition_cosh_sinh", "e884934c5a35ebb1daa4e665eb779f623f99cffba33fe779cf01ee52518a6d3a"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "5310027658533830ac1844d325362a6a451df8aad4bd746c7685d92802af5f24"],
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
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "5310027658533830ac1844d325362a6a451df8aad4bd746c7685d92802af5f24"],
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
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "2040831405f933942bdff84147045e5feddd899546259e7449c6903c8411de65"],
  ["bridge_001_definition_config_basis", "c29559e9454e9cb5483e5bd1a1f852995a0904aab977f59d0e209bdbcd28297d"],
  ["bridge_003_claim_exp_of_diagonal", "e088de3055a90fec15c19ec4b9241df47aa9f15313c517efbb9946462b5ed8b4"],
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", "8eb7e83461c7dd3069ae859b9aa527374c7898d1e6f4609218e4f7caac34c68f"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calc_formulae_definition_cosh_sinh", "e884934c5a35ebb1daa4e665eb779f623f99cffba33fe779cf01ee52518a6d3a"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["exp_linear_map_002_definition_exp_of_endomorphism", "1b90c006155b2b723ad7169ab806c4fff82870687ce2865a7bc677a875134fa2"],
  ["linear_space_general_000_definition_kronecker_product", "d67144d5a2fc061d370a8a29846c5cdb963a1b6ce42b0f6b08daee519364bc40"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "33e23f14fdb3a2b277ed3327fa3edd342512113eb0eb3d327f88992d26a48bf9"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "8a73f81902220cd224baa17d4506c7af2e9e7597bda2e6918da88a3b3c1d23c5"],
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
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "2040831405f933942bdff84147045e5feddd899546259e7449c6903c8411de65"],
  ["bridge_001_definition_config_basis", "c29559e9454e9cb5483e5bd1a1f852995a0904aab977f59d0e209bdbcd28297d"],
  ["bridge_002_claim_sigma_z_diagonal_action", "13002ebb9535f89209c2ebfa23358a0f95c1c1b2e7bcb24a08c2b00b87a10232"],
  ["bridge_003_claim_exp_of_diagonal", "e088de3055a90fec15c19ec4b9241df47aa9f15313c517efbb9946462b5ed8b4"],
  ["bridge_004_claim_V1_component_equals_pauli", "542e930937951f970b4795cbc171117a849f0b5b3e6eae1da351f9970c0c8c0b"],
  ["bridge_005_claim_two_by_two_transfer_identity", "7488a4fdc7984a8ad7c60219a39eca26d92d3230df4c5c43d320c7931df8d8ee"],
  ["bridge_006_claim_V2_component_equals_pauli", "02f2eb834d7e16abf67232ac9a868ee14eec22cf56c1a5a34294d71ec51f65c1"],
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", "8eb7e83461c7dd3069ae859b9aa527374c7898d1e6f4609218e4f7caac34c68f"],
  ["calc_formulae_001_sqrt_nonnegative_real", "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["exp_linear_map_000a_claim_real_exp_series_converges", "1065e4f465b1b0b49eae7d16f9d734421f472beec053c3effaff63127eecf077"],
  ["exp_linear_map_001_theorem_exp_series_pointwise_converges", "7f8878116e4672d93d30e4babcccacab6bb2b8f8423348cbb9ba7e19d78af627"],
  ["exp_linear_map_002_definition_exp_of_endomorphism", "1b90c006155b2b723ad7169ab806c4fff82870687ce2865a7bc677a875134fa2"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "5310027658533830ac1844d325362a6a451df8aad4bd746c7685d92802af5f24"],
  ["eigenvalues_of_V_002_claim_trace_properties", "78bd54e0678d6ade8a2e4af5af89866b4bcb64adffcf7ce89c4ca7924dd6f7c1"],
  ["linear_space_general_000_definition_kronecker_product", "d67144d5a2fc061d370a8a29846c5cdb963a1b6ce42b0f6b08daee519364bc40"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "33e23f14fdb3a2b277ed3327fa3edd342512113eb0eb3d327f88992d26a48bf9"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "8a73f81902220cd224baa17d4506c7af2e9e7597bda2e6918da88a3b3c1d23c5"],
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
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", "8eb7e83461c7dd3069ae859b9aa527374c7898d1e6f4609218e4f7caac34c68f"],
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
  ["eigenvalues_of_V_002_claim_trace_properties", "78bd54e0678d6ade8a2e4af5af89866b4bcb64adffcf7ce89c4ca7924dd6f7c1"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "5310027658533830ac1844d325362a6a451df8aad4bd746c7685d92802af5f24"],
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
  ["bridge_003_claim_exp_of_diagonal", "e088de3055a90fec15c19ec4b9241df47aa9f15313c517efbb9946462b5ed8b4"],
  ["bridge_006_claim_V2_component_equals_pauli", "02f2eb834d7e16abf67232ac9a868ee14eec22cf56c1a5a34294d71ec51f65c1"],
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", "8eb7e83461c7dd3069ae859b9aa527374c7898d1e6f4609218e4f7caac34c68f"],
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
  ["linear_space_general_000b_claim_kronecker_product_rule", "33e23f14fdb3a2b277ed3327fa3edd342512113eb0eb3d327f88992d26a48bf9"],
  ["linear_space_general_001_theorem_tensor_product_basis", "0b14d498919e0e510b2e50b975d3379db4e963cb1dc5583d6bb429c782a7fd31"],
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
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "2040831405f933942bdff84147045e5feddd899546259e7449c6903c8411de65"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "33e23f14fdb3a2b277ed3327fa3edd342512113eb0eb3d327f88992d26a48bf9"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "8a73f81902220cd224baa17d4506c7af2e9e7597bda2e6918da88a3b3c1d23c5"],
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
  ["bridge_009_claim_epsilon_projector_properties", "d109dc4db25a9487b161b9c265101260700ec7eba6697fcb0fde07bc728d9100"],
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
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "2040831405f933942bdff84147045e5feddd899546259e7449c6903c8411de65"],
  ["bridge_008_definition_epsilon_projectors", "be5003446b4cb92b2911fb88cee1a7cc85dd13f412c3207866e1f70d987c4890"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "33e23f14fdb3a2b277ed3327fa3edd342512113eb0eb3d327f88992d26a48bf9"],
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
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "2040831405f933942bdff84147045e5feddd899546259e7449c6903c8411de65"],
  ["Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site", "5fd0477a507f285dd767065c5e1633181bf87ee60a4779771f053a3933da6cf2"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["linear_space_general_002c_claim_matrix_norm_triangle_inequality", "3cd28853c071460f14cbe4ac6e63a6a4e9db98e51a6a752f5cfc064d14f0e069"],
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
  ["bridge_011_claim_sector_replacement", "f55b13638a70defb51a39207099313a89419330b8c6ee8937e426261934ef5f3"],
  ["bridge_definition_V1_pm_square_root", "853921ca298ee54b1cbc3b4113a9bb0824da3628442cc110f3a7eb70eba1e3f9"],
  ["bridge_claim_V1_pm_square_root_squares_to_V1_pm", "964ed2c97f8eec0808efee2562dec149a08fe33840a6f6d56b7d6126c5a91d01"],
  ["bridge_010_claim_epsilon_commutes", "225512460e5993591f6025bf01e9757753f1b3fc7d65cb02bfd86ee5a82a1735"],
  ["bridge_claim_epsilon_projectors_commute_with_transfer_matrices", "d473a52b805bf42e07e842e7fb0a007d2b4cc743f73dab53156c46d7354a0e6a"],
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
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "2040831405f933942bdff84147045e5feddd899546259e7449c6903c8411de65"],
  ["bridge_008_definition_epsilon_projectors", "be5003446b4cb92b2911fb88cee1a7cc85dd13f412c3207866e1f70d987c4890"],
  ["bridge_009_claim_epsilon_projector_properties", "d109dc4db25a9487b161b9c265101260700ec7eba6697fcb0fde07bc728d9100"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["exp_linear_map_002_definition_exp_of_endomorphism", "1b90c006155b2b723ad7169ab806c4fff82870687ce2865a7bc677a875134fa2"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "5310027658533830ac1844d325362a6a451df8aad4bd746c7685d92802af5f24"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "33e23f14fdb3a2b277ed3327fa3edd342512113eb0eb3d327f88992d26a48bf9"],
  ["linear_space_general_002_claim_scalar_identity_commutes", "2c83d104299b4e654c7e818045ba213e543e08102fa8dab8be6c54e26b7d830f"],
  ["linear_space_general_003b_claim_matrix_multiplication_continuity", "4997ade583c124391b81653b81abdc322ad7d13b46e84827b6e5814fc31a86f3"],
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
const sectorReplacementExpectedContentSha256 = "f55b13638a70defb51a39207099313a89419330b8c6ee8937e426261934ef5f3";
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
const realSymmetricGeneratorsExpectedContentSha256 = "d0db638eabbd3f67ab3e07165b00550c189e3af89250349e53cb6cc743563422";
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
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "2040831405f933942bdff84147045e5feddd899546259e7449c6903c8411de65"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["eigenvalues_of_V_011_definition_hermitian_positive_definite", "4b1f272661509c47420344ab38051e53285d0f666507a9a3a3333af52a4f6bf1"],
  ["linear_space_general_000_definition_kronecker_product", "d67144d5a2fc061d370a8a29846c5cdb963a1b6ce42b0f6b08daee519364bc40"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "33e23f14fdb3a2b277ed3327fa3edd342512113eb0eb3d327f88992d26a48bf9"],
  ["linear_space_general_000d_claim_kronecker_transpose", "c0014341f8b8968f27acf4793018d15312e7313acad2dccadd439617703c4cd4"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
  ["transfer_matrix_007_definition_V1_pm", "7a63f3a02db439552636cb7cd8ac32f348c82f85830614ed5fc94c80b3698264"],
  ["transfer_matrix_011_definition_H1_H2", "02a14a895094a781e52c134f1e31763509ed2b747896f18cab3c7564c6c226fb"],
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
  ["Z_Y_anticommutation_000a_claim_pauli_matrix_products", "2040831405f933942bdff84147045e5feddd899546259e7449c6903c8411de65"],
  ["bridge_001_definition_config_basis", "c29559e9454e9cb5483e5bd1a1f852995a0904aab977f59d0e209bdbcd28297d"],
  ["bridge_002_claim_sigma_z_diagonal_action", "13002ebb9535f89209c2ebfa23358a0f95c1c1b2e7bcb24a08c2b00b87a10232"],
  ["bridge_009_claim_epsilon_projector_properties", "d109dc4db25a9487b161b9c265101260700ec7eba6697fcb0fde07bc728d9100"],
  ["bridge_010_claim_epsilon_commutes", "225512460e5993591f6025bf01e9757753f1b3fc7d65cb02bfd86ee5a82a1735"],
  ["calc_formulae_003_matrix_decomposition", "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "33e23f14fdb3a2b277ed3327fa3edd342512113eb0eb3d327f88992d26a48bf9"],
  ["partition_function_2d_ising_003_definition_transfer_matrix", "48b09c189776f6550beac7306cbb8ee033259dfc84221059a44ed3c5672f607d"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
  ["transfer_matrix_003_claim_V1_in_Z_Y_epsilon", "81e8943e63a08c66cf386327af850af907b332c366431782bff3f4b1dd7092f2"],
  ["transfer_matrix_011_definition_H1_H2", "02a14a895094a781e52c134f1e31763509ed2b747896f18cab3c7564c6c226fb"],
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
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "5310027658533830ac1844d325362a6a451df8aad4bd746c7685d92802af5f24"],
  ["transfer_matrix_007_definition_V1_pm", "7a63f3a02db439552636cb7cd8ac32f348c82f85830614ed5fc94c80b3698264"],
  ["transfer_matrix_011_definition_H1_H2", "02a14a895094a781e52c134f1e31763509ed2b747896f18cab3c7564c6c226fb"],
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
  ["bridge_003_claim_exp_of_diagonal", "e088de3055a90fec15c19ec4b9241df47aa9f15313c517efbb9946462b5ed8b4"],
  ["bridge_006_claim_V2_component_equals_pauli", "02f2eb834d7e16abf67232ac9a868ee14eec22cf56c1a5a34294d71ec51f65c1"],
  ["bridge_010_claim_epsilon_commutes", "225512460e5993591f6025bf01e9757753f1b3fc7d65cb02bfd86ee5a82a1735"],
  ["calc_formulae_000b_claim_cosh_sinh_basic_properties", "8eb7e83461c7dd3069ae859b9aa527374c7898d1e6f4609218e4f7caac34c68f"],
  ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"],
  ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ["closing_004_claim_H1_plus_in_sigma_z_form", "df178854a0b0ce220da19a1eb0311b2eb72ed64947d617ef661c418d262323f6"],
  ["closing_005_claim_open_chain_endpoint_product_sum", "002ddb1410f5983a61e4df1c0cf886c47a43ca9825c9dc2563aa9bda84029d89"],
  ["closing_005_claim_open_chain_partition_sum", "97a1758b41d17a52343ba1188eecf112d46ba48112797988021d8d20669a19fc"],
  ["closing_005_claim_open_chain_spin_sums_positive", "0eb4cabfc0011b5c04adb17c333ee92850938340ad677b90d36c9768d7ea5a6a"],
  ["closing_005_definition_open_chain_spin_energy", "2062fa60483069fd13042b3bf943fdfaf32a14ae598f523f41b8b97380cc8f8d"],
  ["closing_claim_D0_G_diagonal_action", "12905cb05af762c01ca2a4f2806fce4b410fbacf1ce911a9379ea0ced226980c"],
  ["closing_claim_epsilon_D0_G_pairwise_commute", "54783919677061229c561142a92459a128bc9cc6e25ba1db0a1e1adde2bed343"],
  ["closing_claim_epsilon_G_is_involution", "3abbe537ba7e33208c63d767d66918eb8dd03ec8acc5fda3aea31fa82078bb9a"],
  ["closing_definition_D0_open_chain_operator", "b8dfa77a5b2a5ba4e505e614623f3f6ae1dcf44c6e9838b3c4bbe2f130ad42a4"],
  ["closing_definition_G_boundary_operator", "4705a5620e827e2607b1331c0eb24030b96fc0fd668ce9a405fa55dbdd009d22"],
  ["eigenvalues_of_V_001_definition_trace", "35ae403d96746496fb0fdaa59d0122e38c3fc5129338230666507cb62c07a73d"],
  ["eigenvalues_of_V_002_claim_trace_properties", "78bd54e0678d6ade8a2e4af5af89866b4bcb64adffcf7ce89c4ca7924dd6f7c1"],
  ["evensectorT_definition_V1_plus_square_root", "33659011599514363340a770866a6757ab8b49d6b7259f1c8fc777da7aea773a"],
  ["exp_linear_map_000a_claim_real_exp_series_converges", "1065e4f465b1b0b49eae7d16f9d734421f472beec053c3effaff63127eecf077"],
  ["exp_linear_map_002_definition_exp_of_endomorphism", "1b90c006155b2b723ad7169ab806c4fff82870687ce2865a7bc677a875134fa2"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "5310027658533830ac1844d325362a6a451df8aad4bd746c7685d92802af5f24"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "33e23f14fdb3a2b277ed3327fa3edd342512113eb0eb3d327f88992d26a48bf9"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
  ["transfer_matrix_005_definition_end_isomorphism", "651f3dbd8a1ace2d2c641c9424fb4148011370c9100f9887ab06b9696e18d52a"],
  ["transfer_matrix_007_definition_V1_pm", "7a63f3a02db439552636cb7cd8ac32f348c82f85830614ed5fc94c80b3698264"],
  ["transfer_matrix_011_definition_H1_H2", "02a14a895094a781e52c134f1e31763509ed2b747896f18cab3c7564c6c226fb"],
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
  ["eigenvalues_of_V_011_definition_hermitian_positive_definite", "4b1f272661509c47420344ab38051e53285d0f666507a9a3a3333af52a4f6bf1"],
  ["eigenvalues_of_V_013_claim_exp_hermitian_positive_definite", "73fdb5d24c8cec6a1c637fedee45e0040ef03c5d8e7c13449cc4d8c80bc5f324"],
  ["eigenvalues_of_V_014_claim_iH_is_real_symmetric", "d0db638eabbd3f67ab3e07165b00550c189e3af89250349e53cb6cc743563422"],
  ["evensectorT_definition_V1_plus_square_root", "33659011599514363340a770866a6757ab8b49d6b7259f1c8fc777da7aea773a"],
  ["evensectorT_definition_V_plus", "25224f1a0789bbff2c99b11323319f0e297bd6a0f68c213757097e35957e37ef"],
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "5310027658533830ac1844d325362a6a451df8aad4bd746c7685d92802af5f24"],
  ["exp_linear_map_004_theorem_exp_zero_is_identity", "bb23ba43e403ab11c2c6a41e4356f0228a5880e37b0e2fe4df9a62289696fd53"],
  ["linear_space_general_002_claim_scalar_identity_commutes", "2c83d104299b4e654c7e818045ba213e543e08102fa8dab8be6c54e26b7d830f"],
  ["transfer_matrix_001_definition_symbols", "ec8988f0766c8e6eaa686a03d4aa268bfe139e6ee33449ea604f292ac158cee6"],
  ["transfer_matrix_011_definition_H1_H2", "02a14a895094a781e52c134f1e31763509ed2b747896f18cab3c7564c6c226fb"],
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
const vPlusFactorsInvertibleExpectedDirectDependencies = [
  "TV1_hatZ_hatY_009_definition_invertible_elements",
  "calc_formulae_006_definition_of_cc",
  "evensectorT_claim_V1_plus_half_invertible",
  "evensectorT_claim_V2_invertible",
  "evensectorT_definition_V_plus",
].sort();
const v1PlusHalfInvertibleExpectedContentSha256 = "9673ccc699a872424d8f3464e516dda61983f6cd416d6be7924c63d862a6aafa";
const vTwoInvertibleExpectedContentSha256 = "eabadeb2353bdb7cd8c2ff1014e2c3d6f42e52901fb3cdb657f753382ef97992";
const vPlusFactorsInvertibleExpectedContentSha256 = "bfb1bb937c796f71881bf9bbd1609a6c1338227b8facc90df00b2fc880d4d0f8";
const vPlusFactorsInvertibilityBoundaryCandidates = [] as const;
const vPlusFactorsInvertibilityExpectedBoundaryCandidates = [] as const;
const vPlusFactorsInvertibilityNextTickUnit = [] as const;
const vPlusFactorsInvertibilityExpectedNextTickUnit = [] as const;
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
  `noncomputable def VPlusUnits (M : ℕ) {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) :
    (TensorPow M)ˣ :=
  V1halfUnits M K1 (-1) * V2Units M hs2 K2star * V1halfUnits M K1 (-1)`,
  `/-- **原文 \`V1_plus_half_invertible\`**: \`(V_1^{(+)})^{1/2}\` は可逆。 -/
theorem isUnit_V1halfPlus (K1 : ℂ) : IsUnit (V1half M K1 (-1)) :=`,
  `theorem isUnit_VPlus {s2 : ℝ} (hs2 : 0 < s2) (K1 K2star : ℂ) :
    IsUnit (VPlus M s2 K1 K2star) :=
  ⟨VPlusUnits M hs2 K1 K2star, rfl⟩`,
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
  "TV1_hatZ_hatY_015_claim_linearity_of_T",
  "calc_formulae_006_definition_of_cc",
  "evensectorT_claim_V1_plus_half_invertible",
  "evensector_003_definition_half_integer_modes",
  "evensector_003a_definition_check_index_set",
].sort();
const conjugationLinearityExpectedContentSha256 = "efa1813659a4a355bd87dc8ef865bf4f6628972fe0cd6645ee2a8e011f2b44cc";
const vTwoConjugationLinearityExpectedDirectDependencies = [
  "TV1_hatZ_hatY_015_claim_linearity_of_T",
  "calc_formulae_006_definition_of_cc",
  "evensectorT_claim_V2_invertible",
  "evensector_003_definition_half_integer_modes",
  "evensector_003a_definition_check_index_set",
].sort();
const vTwoConjugationLinearityExpectedContentSha256 = "71fbb554701c8129d764e7dd97ad89c518a1b56850a9aa1a6f789593562ab7e7";
const vPlusCompositeConjugationDefinitionExpectedDirectDependencies = [
  "TV1_hatZ_hatY_011_definition_T_g",
  "calc_formulae_006_definition_of_cc",
  "evensectorT_claim_V1_plus_half_invertible",
  "evensectorT_claim_V2_invertible",
  "evensectorT_definition_V_plus",
].sort();
const vPlusCompositeConjugationEqualityExpectedDirectDependencies = [
  "TV1_hatZ_hatY_009_definition_invertible_elements",
  "calculation_formulae_046_claim_conjugation_is_ring_homomorphism",
  "evensectorT_claim_V1_plus_half_invertible",
  "evensectorT_claim_V2_invertible",
  "evensectorT_definition_T_V_plus",
  "evensectorT_definition_V_plus",
].sort();
const vPlusCompositeConjugationDefinitionExpectedContentSha256 =
  "eb41f2e8ce21a2487c0544276bafbab27df2842396fcd99498cca9e476b28928";
const vPlusCompositeConjugationEqualityExpectedContentSha256 =
  "6e3f79505b6371a79a1a2ca52f478f87e3798089d7df53bd0e6870dcc9a816e7";
const vPlusCompositeConjugationLeanFile = "lean/Ising2D/Part014/Definition001_VPlus.lean";
const conjugationCompositionLeanFile = "lean/Ising2D/Part008/Definition016_TV.lean";
const vPlusCompositeConjugationLeanExpectedSha256 =
  "744ccebc8b077728c9f829a806a7d654e3fdb6c17a0f129ae47f5bac1254e802";
const conjugationCompositionLeanExpectedSha256 =
  "cf55243ca52bdf64af6925d236b360d14a65a621955e12551ea401c01ef4c356";
const vPlusCompositeConjugationSageMathExpectedSha256 =
  "79535651bb6d0883fe55e595e4bb862ca0d1edd6ead959e2ba6cd0253258fbcb";
const vPlusCompositeConjugationSageMathFile =
  "sagemath/check/051_stepwise_identities_of_chapter_Cprime/check_03_014_steps.sage";
const vPlusCompositeConjugationLeanSource = readFileSync(
  join(projectDir, vPlusCompositeConjugationLeanFile),
  "utf8",
);
const conjugationCompositionLeanSource = readFileSync(
  join(projectDir, conjugationCompositionLeanFile),
  "utf8",
);
const vPlusCompositeConjugationSageMathExecutableSource = readFileSync(
  join(projectDir, vPlusCompositeConjugationSageMathFile),
  "utf8",
).split("\n").filter((line) => !line.trimStart().startsWith("#")).join("\n");
for (const [path, source, expectedSha256] of [
  [vPlusCompositeConjugationLeanFile, vPlusCompositeConjugationLeanSource,
    vPlusCompositeConjugationLeanExpectedSha256],
  [conjugationCompositionLeanFile, conjugationCompositionLeanSource,
    conjugationCompositionLeanExpectedSha256],
  [vPlusCompositeConjugationSageMathFile,
    readFileSync(join(projectDir, vPlusCompositeConjugationSageMathFile), "utf8"),
    vPlusCompositeConjugationSageMathExpectedSha256],
] as const) {
  const actualSha256 = createHash("sha256").update(source).digest("hex");
  if (actualSha256 !== expectedSha256) {
    throw new Error(`偶セクターの合成共役写像に対応する形式化本体が変わりました: ${JSON.stringify({
      path, expectedSha256, actualSha256,
    })}`);
  }
}
for (const declarationFragment of [
  "TV (V1halfUnits M K1 (-1)) (V2Units M hs2 K2star)",
  "TVPlus M hs2 K1 K2star x =\n      TConj (V1halfUnits M K1 (-1))\n        (TConj (V2Units M hs2 K2star) (TConj (V1halfUnits M K1 (-1)) x)) := rfl",
  "TVPlus M hs2 K1 K2star = TConj (VPlusUnits M hs2 K1 K2star) :=\n  TV_eq_TConj _ _",
  "rw [TVPlus_eq_TConj hs2, TConj_apply, VPlusUnits_val]",
]) {
  if (!vPlusCompositeConjugationLeanSource.includes(declarationFragment)) {
    throw new Error(`偶セクターの合成共役写像に対応する Lean 宣言が変わりました: ${declarationFragment}`);
  }
}
for (const proofFragment of [
  "theorem TConj_trans (g h : Aˣ) : (TConj h).trans (TConj g) = TConj (g * h) := by",
  "rw [show (g * h)⁻¹ = h⁻¹ * g⁻¹ by simp]",
  "theorem TV_eq_TConj (g1 g2 : Aˣ) : TV g1 g2 = TConj (g1 * g2 * g1) := by\n  rw [TV, TConj_trans, TConj_trans]",
]) {
  if (!conjugationCompositionLeanSource.includes(proofFragment)) {
    throw new Error(`合成共役則に対応する Lean 証明が変わりました: ${proofFragment}`);
  }
}
for (const executionFragment of [
  'S.add("T_V_plus_is_conjugation (1) (gh)(h^{-1}g^{-1}) = I"',
  'S.add("T_V_plus_is_conjugation (2) (h^{-1}g^{-1})(gh) = I"',
  "matrix_units = np.eye(O.d * O.d, dtype=np.complex128).reshape(O.d * O.d, O.d, O.d)",
  "first_composite = act_on_all_matrix_units(\n            Vh, act_on_all_matrix_units(V2, matrix_units, V2i), Vhi)",
  "second_composite = act_on_all_matrix_units(\n            Vh * V2, act_on_all_matrix_units(Vh, matrix_units, Vhi), V2i * Vhi)",
  "triple_composite = act_on_all_matrix_units(\n            Vh,\n            act_on_all_matrix_units(\n                V2, act_on_all_matrix_units(Vh, matrix_units, Vhi), V2i),\n            Vhi,\n        )",
  'S.add("T_V_plus_is_conjugation (5) T_{(V^{(+)})} = T_{V^{(+)}} on all matrix units"',
]) {
  if (!vPlusCompositeConjugationSageMathExecutableSource.includes(executionFragment)) {
    throw new Error(`偶セクターの合成共役写像に対応する SageMath 実検査行が変わりました: ${executionFragment}`);
  }
}
const checkNumberOperatorIdempotentExpectedDirectDependencies = [
  "calc_formulae_006_definition_of_cc",
  "evenfermi_003_claim_anticommutator",
  "evenEigen_001_definition_check_number_operator",
  "evensector_003a_definition_check_index_set",
].sort();
const checkNumberOperatorIdempotentExpectedContentSha256 = "bfddf026ea650ba074480a7ad853fbd8e91f34b87ddb7749f5c96692db7808db";
const genericConjugationLinearityExpectedDirectDependencies = [
  "TV1_hatZ_hatY_009_definition_invertible_elements",
  "TV1_hatZ_hatY_011_definition_T_g",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
].sort();
const genericConjugationLinearityExpectedContentSha256 = "99ac6ebf22a0cc2df0c9ba8afa947765649a68a5937ca171ae13fcfdea571495";
const conjugationLinearityLeanFile = "lean/Ising2D/Part014/Claim005_TActionsOnCheck.lean";
const genericConjugationLinearityLeanFile = "lean/Ising2D/Part008/Definition016_TV.lean";
const genericConjugationLinearitySageMathFile =
  "sagemath/check/200_linearity_of_T/check_01_linearity.sage";
const conjugationLinearitySageMathFile =
  "sagemath/check/051_stepwise_identities_of_chapter_Cprime/check_03_014_steps.sage";
const conjugationLinearityLeanSource = readFileSync(join(projectDir, conjugationLinearityLeanFile), "utf8");
const genericConjugationLinearityLeanSource = readFileSync(
  join(projectDir, genericConjugationLinearityLeanFile),
  "utf8",
);
const genericConjugationLinearitySageMathExecutableSource = readFileSync(
  join(projectDir, genericConjugationLinearitySageMathFile),
  "utf8",
).split("\n").filter((line) => !line.trimStart().startsWith("#")).join("\n");
const conjugationLinearitySageMathExecutableSource = readFileSync(
  join(projectDir, conjugationLinearitySageMathFile),
  "utf8",
).split("\n").filter((line) => !line.trimStart().startsWith("#")).join("\n");
for (const declarationFragment of [
  "theorem linearity_of_T_on_check",
  "theorem linearity_of_T_on_check_from_general",
  "theorem linearity_of_T_V1halfPlus",
  "theorem linearity_of_T_V2",
]) {
  if (!conjugationLinearityLeanSource.includes(declarationFragment)) {
    throw new Error(`共役写像の線型性に対応する偶セクター Lean 宣言が変わりました: ${declarationFragment}`);
  }
}
if (!conjugationLinearityLeanSource.includes(
  "theorem linearity_of_T_V2 (_hM : 2 ≤ M) {s2 : ℝ} (hs2 : 0 < s2)",
) || !conjugationLinearityLeanSource.includes(
  "(K2star : ℂ) (a b : ℂ) (μ : ℤ) (_hμ : CheckIndex M μ)",
)) {
  throw new Error("V_2 による共役写像の線型性に、本文と同じ M と半整数運動量添字の仮定がありません");
}
for (const declarationFragment of ["theorem TConj_linear"]) {
  if (!genericConjugationLinearityLeanSource.includes(declarationFragment)) {
    throw new Error(`共役写像の線型性に対応する一般 Lean 宣言が変わりました: ${declarationFragment}`);
  }
}
if (!genericConjugationLinearitySageMathExecutableSource.includes(
  "rep.truth(right_scalar_compatible == rhs, f\"{prefix}: T_g の定義へ戻す\")",
)) {
  throw new Error("一般の共役写像の線型性に対応する SageMath 実検査行が変わりました");
}
for (const executionFragment of [
  'S.add("linearity_of_T_on_check_Z_Y (V1^{1/2}) T_g(aX+bW) = aT_g(X)+bT_g(W)"',
  'S.add("linearity_of_T_V2 T_g(aX+bW) = aT_g(X)+bT_g(W)"',
]) {
  if (!conjugationLinearitySageMathExecutableSource.includes(executionFragment)) {
    throw new Error(`共役写像の線型性に対応する SageMath 実検査行が変わりました: ${executionFragment}`);
  }
}
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
  ["eigenvalues_of_V_008_claim_joint_eigenspace_decomposition", new Set(["trace_of_idempotent"])],
  ["calc_formulae_004_action_on_matrix_pair", new Set(["mat_mult"])],
  ["maxeig_009_claim_partition_function_sandwich", new Set(["Z_equals_trace_of_W", "trace_power_sandwich"])],
  ["maxeig_008_claim_trace_power_sandwich", new Set(["moment_log_convexity", "psd_cauchy_schwarz"])],
  ["maxeig_007_claim_operator_bound", new Set(["def_matrix_norm", "psd_cauchy_schwarz", "def_rayleigh_sup"])],
  ["maxeig_006_definition_rayleigh_sup", new Set(["def_matrix_norm"])],
  ["maxeig_003_claim_W_is_positive_definite", new Set(["def_symmetrized_transfer_matrix"])],
  ["bridge_011_claim_sector_replacement", new Set(["V1_restriction_to_eigenspaces", "def_end_iso", "epsilon_projector_properties"])],
  ["closing_005_claim_open_chain_spin_sums_positive", new Set(["cosh_sinh_basic_properties"])],
  ["Z_Y_anticommutation_000b_claim_tensor_anticommutation_single_site", new Set(["kronecker_product_rule", "kronecker_multilinear"])],
  ["exp_conjugation_proof_010_theorem_matrix_exp_conjugation", new Set(["theorem_exp_product", "theorem_exp_zero"])],
  ["evensectorT_claim_V1_plus_half_invertible", new Set(["matrix_exp_conjugation"])],
  ["bridge_claim_V1_pm_square_root_squares_to_V1_pm", new Set(["def_V1_pm", "theorem_exp_product"])],
  ["evenEigen_002_claim_check_number_operator_idempotent", new Set([
    "anticommutator_of_check_psi",
    "def_check_number_operator",
  ])],
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
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", new Set(["ad_binomial"])],
  ["exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms", new Set(["def_hermitian_positive_definite", "def_trace"])],
  ["exp_conjugation_proof_003_definition_M_n_C_convergence", new Set(["def_hermitian_positive_definite", "def_trace"])],
  ["transfer_matrix_001_definition_symbols", new Set(["pauli_matrix_products"])],
  // 行列の積の定義は成分が複素数であることを前提にする。複素数の定義は本文では後ろに置かれているが、
  // 依存順では先行する（提示順と依存順が食い違う箇所であり、案内ではなく前提である）。
  ["calc_formulae_003_matrix_decomposition", new Set(["definition_of_cc"])],
]);
const manualGranularityReviewById = new Map<string, string>([
  ["exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "LLMによる検証: 行列積・複素演算・実数包含・非負平方根と、二項係数の定義およびPascalの関係式を示す反復交換子の準備への参照を補った。可換な冪と二項展開、有限添字集合の比較と剰余評価、二つの因子が変わる積の収束を一項に含む。Pascalの計算は参照先に存在し、必要な補題としての分離と適用行の参照が未整備である。有限和の展開・添字全単射・両箇所の同時代入、実数の平方根比較と極限法則、成分演算法則への接続と各行参照を未解決に記録する。零次と零のノルム、N=0で空となる添字範囲は本文にある規約を保ち、前提補完と分割後に依存と閉包を再判定する。"],
  ["bridge_003_claim_exp_of_diagonal", "LLMによる検証: 行列積・複素演算・実数包含・非負平方根への参照を補った。複素成分d_kに非負実数の指数級数の定理を適用しており、その定理だけでは複素数の指数e^{d_k}の定義と収束を与えない。この定義・証明の接続は未完である。非対角成分について「左側が常に0」は差の絶対値を指すなら不正確で、部分和の非対角成分が0であることと極限からの結論を区別する必要がある。成分冪の定義と帰納法、有限線型結合と非負平方比較、同時適用と各行参照の分割も未解決であり、零成分と零次を保って補完後に依存と閉包を再判定する。"],
  ["exp_linear_map_002_definition_exp_of_endomorphism", "LLMによる検証: 行列積と実数係数の包含への参照を補った。行列の冪と指数、線型写像の反復と指数の定義が同居する。冪の再帰は本項に実在するが先行する収束証明より前への提示が必要である。実行列と複素行列の成分演算の接続、入力の実数完備性と極限法則、定義群の分割と各行参照が未解決であり、零次と零の引数を保ち、補完後に依存と閉包を再判定する。"],
  ["eigenvalues_of_V_013_claim_exp_hermitian_positive_definite", "LLMによる検証: 指数定義・可換指数積・零行列指数と、成分計算で使う共役・ノルム・絶対値・実数包含・トレースへの欠落参照を補った。指数の正定値性と合同変換・正の定数倍・トレースの四主張が同居する。矩形行列への共役転置の定義と積公式の適用範囲は未整備であり、片側の逆元積だけから可逆性を結論する段階、可逆行列が非零ベクトルを非零へ送る根拠、複素数と正の実数の包含の区別、共役転置の対合性と有限和・冪の帰納、同時適用と各行参照が未解決である。定義と証明の前提を補完し分割した後に依存と閉包を再判定する。"],

  ["exp_linear_map_000b_claim_matrix_exp_series_converges", "LLMによる検証: 行列積と実数係数の包含への参照を補った。部分和・上界の定義と収束・評価の二主張、冪の評価の帰納法が同居する。行列冪の再帰は後続の指数定義に存在し、収束証明の前へ分離する必要がある。零次と正次数の分離は本文に明示済みである。上限から単調列収束への前提、有限回の三角不等式、N=0で正次数の和が空となる場合への適用説明、同時適用と各行参照が未解決であり、零行列と零次の項を保って補完・分割後に依存と閉包を再判定する。"],
  ["exp_linear_map_001_theorem_exp_series_pointwise_converges", "LLMによる検証: 行列積・非負平方根・実数係数の包含への参照を補った。作用と成分の収束、線型写像の評価・反復・級数収束・極限の線型性の六群の主張に、行列単位・上界・写像と反復の定義が同居する。行列の冪の再帰の提示順、有限和への線型性の帰納、添字写像の全単射の根拠、実数列の単調収束と極限法則、同時適用と各行参照が未解決である。零の上界と零次の反復を保持し、前提補完と分割後に依存と閉包を再判定する。"],

  ["linear_space_general_003d_claim_matrix_completeness", "LLMによる検証: Cauchy列の定義、完備性、絶対収束判定と級数のノルム評価が同居する。成分のCauchy列から行列の極限を構成する証明は存在するが、実数のCauchy完備性と極限法則の前提、有限回の三角不等式の帰納、N>Mから全添字への場合分けと各行参照の説明が未解決である。前提補完と分割後に依存と閉包を再判定する。"],
  ["linear_space_general_003b_claim_matrix_multiplication_continuity", "LLMによる検証: 行列列の所属とノルム・行列積・劣乗法性の参照を補った。主張は右因子を固定した乗算の連続性に限る。分配則を成分計算へ接続する根拠、非負性と実数列の定数倍・挟み撃ちの極限法則、各行参照が未解決である。前提補完と分割後に依存と閉包を再判定する。"],
  ["linear_space_general_003c_claim_matrix_norm_vector_bound", "LLMによる検証: 行列積・ノルム基本性質の零の絶対値・劣乗法性への欠落参照を補った。数ベクトルを第一列に置いた行列のノルムと数ベクトルのノルムを対応させる計算は存在する。行列と数ベクトルの積への定義適用、零の列を有限和から除く計算、各行参照が未解決である。n=1の第二列以降が空の範囲を保持し、前提補完と分割後に依存と閉包を再判定する。"],

  ["linear_space_general_003_claim_matrix_norm_submultiplicativity", "LLMによる検証: 行列積と非負平方根の参照を補った。三角不等式と有限列のCauchy–Schwarzを使う成分評価から平方和の評価へ進む。実行列の成分積と複素行列として定めた積の接続、有限和の分解・添字変更・平方根の性質の同時適用と各行参照が未解決である。有限和の三角不等式の帰納法は現存し、前提補完と分割後に依存と閉包を再判定する。"],
  ["linear_space_general_002c_claim_matrix_norm_triangle_inequality", "LLMによる検証: 四主張と非負平方の比較・包含写像の和と積の計算・有限列のCauchy--Schwarzの補題が同居する。有限和の零の議論、実数列の極限法則、数ベクトルの同様計算、二箇所同時適用・複数法則の同時適用と各行参照が未解決である。極限一意性の証明、包含写像の和と積の計算、Cauchy--Schwarzの零の場合の分岐は存在し、欠落とは扱わない。前提補完と分割後に依存と閉包を再判定する。"],
  ["exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix", "LLMによる検証: 行列積の欠落参照を補った。内積定義から使うのは行列空間の表記だけであり、内積の値や性質は使わない。交換子写像・反復の再帰・正則性・共役写像の定義と逆行列一意性の証明が同居する。行列の和・差・単位行列、積の結合律と単位元の法則を具体的成分計算へ接続する根拠、各行参照が未解決であり、前提補完と分割後に依存と閉包を再判定する。"],
  ["exp_conjugation_proof_003_definition_M_n_C_convergence", "LLMによる検証: 内積の式に使う行列積の参照と後続の性質への案内を訂正した。行列空間の表記、二変数関数の定義、その関数が内積の性質を満たすという後続主張、既出ノルムとの一致への接続を分ける必要がある。共役転置とノルムの入力に残る未整備の定義と説明は解消済みとは扱わず、前提補完と分割後に依存と閉包を再判定する。"],
  ["eigenvalues_of_V_012_claim_star_is_norm_preserving", "LLMによる検証: 複素共役の和・積保存を行列共役へ誤参照していた箇所を、既存のFrobenius内積の性質の証明冒頭へ訂正し、その後へ依存順を移した。スカラーと行列列の所属、共役転置・複素共役・行列積・複素演算・絶対値の参照を補った。積と共役線型性、ノルム保存と極限保存の分割、有限和への帰納、第二式の同様計算、絶対値の成分式へ共役を代入する計算、添字の範囲、二箇所同時適用と各行参照が未解決である。前提補完と分割後に依存と閉包を再判定する。"],
  ["exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms", "LLMによる検証: 証明冒頭には複素共役の和・積保存の成分計算が実在する。成分表示と五群の性質、その前提となる複素数の補題の分割、包含写像の和・積・逆元保存と単射性の根拠への接続、非負実数の像の平方根と実数ノルムの所属を区別する説明、同時代入・複数法則の同時適用と各行参照が未解決である。零の場合を保ち、前提補完と分割後に依存と閉包を再判定する。"],

  ["linear_space_general_002b_definition_matrix_norm", "LLMによる検証: 実数の包含写像の参照を補った。数ベクトルと行列のノルム、列の収束と極限、無限級数の記法の定義が同居する。実数列の収束・極限法則と成分の差・有限和の前提が未整備である。極限の一意性は後続のノルムの基本性質で証明しているが、定義時点ではその証明への接続が未提示であり、級数の値の一意性への接続も含め補完と分割後に依存と閉包を再判定する。絶対値の定義とその入力に残る未完も解消済みとは扱わない。"],
  ["linear_space_general_002_claim_scalar_identity_commutes", "LLMによる検証: 任意の体という記述を複素行列へ具体化し、行列積・交換子・成分の複素演算法則の参照を補った。成分ごとの和・スカラー倍・単位行列の定義と積の法則、二箇所への同時適用の分離、各行参照が未解決であり、前提補完と分割後に依存と閉包を再判定する。"],
  ["linear_space_general_001_theorem_tensor_product_basis", "LLMによる検証: 生成に関する包含の向きを逆に述べた説明を訂正した。三主張と次元・行列単位等の定義の分割、有限次元の生成族の元数の下限という未証明の一般命題を具体的複素行列へ接続する根拠、有限展開の帰納法、数ベクトルの場合の同様計算と各行参照が未解決である。前提補完と分割後に依存と閉包を再判定する。"],
  ["linear_space_general_000d_claim_kronecker_transpose", "LLMによる検証: 転置の定義とクロネッカー積の転置公式が同居しており、定義と主張への分割が未解決である。任意のM≥1の各サイズでの転置の定義の適用、定義を使う各行の参照を明示し、分割後に依存と閉包を再判定する。"],
  ["linear_space_general_000b_claim_kronecker_product_rule", "LLMによる検証: 行列積と複素数の演算法則の参照を補った。三主張と多重添字和の補題が同居し、有限和の帰納法、添字変更、二箇所の定義代入、可換律と結合律の同時適用、各行参照の分離が未解決である。M=1と空和・空積の規約を保ち、分割後に依存と閉包を再判定する。"],
  ["linear_space_general_000c_claim_kronecker_multilinear", "LLMによる検証: 複素数の演算法則の参照を補った。行列と数ベクトルの主張およびスカラー倍の特例の分割、成分ごとの和・スカラー倍の定義、積の並べ替えと分配の分離、数ベクトルの同様計算の展開と各行参照が未解決である。M=1の空積を保持し、前提補完と分割後に依存と閉包を再判定する。"],
  ["linear_space_general_000_definition_kronecker_product", "LLMによる検証: 添字集合の元数、写像の値域と全単射、数ベクトルと行列の二定義が同居する。有限集合の議論と有限和の法則、同時代入と複数演算の分離、各行参照が未解決である。M=1と単射証明の末尾の空和を保ち、前提補完と分割後に依存と閉包を再判定する。"],
  ["exp_linear_map_004_theorem_exp_zero_is_identity", "LLMによる検証: 行列指数の定義への欠落参照を補い依存順を修正した。行列サイズと成分の所属、正整数冪の計算、収束級数の初項分離とスカラー倍の前提、各行参照が未解決である。"],
  ["freeenergy_004_theorem_riemann_sum_to_integral", "LLMによる検証: イジング固有の導入を外し、一様連続性と積分の基本性質を一般形の外部前提として明示した。それらの本文内の証明、連続度の上限の存在、誤差評価と極限の主張分割、各行参照と複数演算の分離が未解決である。前提補完後に依存と閉包を再判定する。"],
  ["exp_linear_map_000a_claim_real_exp_series_converges", "LLMによる検証: 部分和・極限・剰余の定義と三主張が同居する。Archimedesの原理、等比和、上限から単調列収束と極限が上限になる根拠、極限の差の法則と各行参照が未提示である。零引数もa^0=1の規約で含め、前提補完と分割後に依存と閉包を再判定する。"],
  ["eigenvalues_of_V_011_definition_hermitian_positive_definite", "LLMによる検証: 共役転置・エルミート・正定値・実対称を一項に束ねている。正方行列で定めた共役転置を列ベクトルへ使う長方形への拡張、実対称の等式と正の実数を実数包含から説明する段、通常転置の記号導入、定義分割が未解決であり、補完後に依存と閉包を再判定する。"],
  ["exp_conjugation_proof_004_theorem_ad_binomial", "LLMによる検証: 交換子と二項係数の定義、符号の処理、Pascalの法則、帰納証明が同居している。正整数冪の定義と行列演算法則の根拠、符号の帰納法の展開、複数の分配律・結合律・スカラーの可換性の同時適用と二箇所への代入、各行参照と主張分割が未解決である。"],
  ["eigenvalues_of_V_002_claim_trace_properties", "LLMによる検証: 四主張の分割、線型性の成分計算と有限和の順序交換を正当化する帰納法、和の交換と複素積の交換を同時適用する段の分離、各行参照が未解決である。"],
  ["eigenvalues_of_V_003_claim_trace_of_idempotent", "LLMによる検証: 像・核の部分空間性、基底の存在と個数、直和から基底を連結する根拠、基底変換行列の可逆性と表現行列の式が未提示である。零次元の像または核を含め、一般語彙を具体的複素行列の計算へ接続する前提不足であり、説明粒度だけの不足としない。直和分解とトレースの主張分割、各行参照と前提補完後に依存と閉包を再判定する。"],
  ["critical_009_claim_closed_form_log_integral", "LLMによる検証: 三つの積分・対数評価の分割、対数の定義と法則、平方根の積商法則、合成微分の分解と各行参照が未解決である。積分の基本定理等を一般形で切り出す必要があり、解析前提の補完後に分類・依存・配置を再判定する。"],
  ["critical_010_claim_sine_integral_two_sided", "LLMによる検証: 積分の定義可能性と両側評価の分割、c0の正値性とBの数値根拠、複数の不等式と演算の分解・各行参照が未解決である。p=0の分岐を維持し、正のpだけで分母を評価する。有界差を定数差と述べた表現は訂正した。積分の一般形の前提と入力の未完事項を補った後に分類・依存・配置を再判定する。"],
  ["critical_008_claim_elementary_sine_bounds", "LLMによる検証: 主張の半角は現行sin/cosの定義域内だが、証明のt≥0全域での使用は定義域を超える。微分公式・零での値・π²の数値区間の根拠と複数不等式の分割が未解決である。R3/R4の積分の性質をイジング導入注記から一般形へ切り出す必要があり、補完後に分類・依存・配置を再判定する。"],
  ["critical_001_claim_cosh_addition_and_half_angle", "LLMによる検証: 五群の主張とarcsinhの定義を同居させ、指数対数の前提、微分規則と各行参照、同様計算の省略が残る。R3/R4の積分の性質はイジング固有の導入注記に混在しており、一般形の解析事実として切り出す必要がある。注記全体を直接入力へ加えず、補完後に分類・依存・配置を再判定する。"],
  ["calculation_formulae_047_claim_commutator_via_anticommutators", "LLMによる検証: 交換子と反交換子の二定義と恒等式を同居させている。結合律・分配則の根拠参照、同時の括弧外しと二箇所への定義代入、零の挿入の演算分解が未解決である。定義と主張を分割した後に依存と閉包を再判定する。"],
  ["calculation_formulae_046_claim_conjugation_is_ring_homomorphism", "LLMによる検証: 乗法性・単位性・合成則と積の逆元公式を一項へ束ねている。加法保存は先行の行列共役にあるが、環準同型という題への接続説明は本項にない。行列の結合律・単位元・逆元一意性の根拠と各適用行の参照が未解決であり、分割後に配置を再判定する。"],
  ["calculation_formulae_044_claim_reciprocal_of_sqrt", "LLMによる検証: 未完の平方根定義と逆数平方根の証明への依存が残る。参照先の準備から非零性を取り出す説明、各行参照と二重負号の根拠が未解決である。"],
  ["calculation_formulae_045_theorem_euler_formula_cos_sin", "LLMによる検証: 現行sin/cosは主値区間のみであり全実数上の定義が不足する。複素指数の意味付け、Euler公式自体の導出、偶奇性が未整備で、定義と証明の未完である。二等式の分割と各行参照も残る。必要な定義と公式の追加後に依存と配置を再判定する。"],
  ["calculation_formulae_041_claim_sqrt_squared_is_original", "LLMによる検証: 未完の平方根定義・極座標展開と同型性を入力にするため証明完成とは扱わない。展開式を二箇所へ同時適用する段と実数の和の計算の省略、各適用行の参照が未解決である。"],
  ["calculation_formulae_042_claim_square_of_sqrt", "LLMによる検証: 交換条件と二乗復元を合流させる場合分けだが、両入力に定義・証明の未完が及ぶ。各適用行のラベル、二重負号と積の符号の根拠の明示が未解決である。"],
  ["calculation_formulae_043_claim_sqrt_of_reciprocal", "LLMによる検証: 未完の平方根定義と交換条件・二乗復元・逆数の偏角を使うため証明完成とは扱わない。sqrt(z)の非零性とsqrt(1)=1の計算を一項へ束ね、arctan(0)=0・sin(0)=0・cos(0)=1の根拠の導出、各行参照、同時代入と複数演算の分解が未解決である。"],
  ["calculation_formulae_039_claim_sqrt_expansion_via_polar", "LLMによる検証: 代表元独立性と半径零・正の展開を一項へ束ねている。入力の平方根写像と逆方向写像が定義未完であり、本項も完成とは扱わない。二条件の同時代入、複数演算の混在、各行ラベル不足、主張分割が未解決である。"],
  ["calculation_formulae_040_claim_sqrt_commutativity_condition", "LLMによる検証: 未完の平方根写像・同型性と未整備の三角関数加法定理・π移動公式に依存し、証明は未完である。r_iとθ_iの所属と選び方を導入せずに使い、零の場合ではn_1をn_iの導入より先に使う。非負平方根の積法則の証明、複数演算の分解、同様の計算の省略、適用行の参照も未解決である。"],
  ["calculation_formulae_038_definition_sqrt_of_complex_number", "LLMによる検証: 半角は[0,π)に入り、現行sin/cosの主値区間を超える。逆方向写像の定義が未完であるため平方根写像の定義自体も未完であり、説明粒度だけの不足とは扱わない。定義域の補完と合成写像の妥当性の説明後に依存と閉包を再判定する。"],
  ["calculation_formulae_036_claim_arg_of_reciprocal", "LLMによる検証: 逆数の定義に非零仮定が必要である。未完の同型性を使う逆写像の積・単位元保存から逆元保存を導いており、証明完成とは扱わない。一般論の具体計算への展開、各行のラベルと複数の実数演算の分解が未解決である。"],
  ["calculation_formulae_035_claim_arg_of_square", "LLMによる検証: 零の場合を分けているので非零仮定は不要である。一方、未完の同型性を使う積保存に依存するため証明完成とは扱わない。逆写像の一般論の具体化、各適用行の参照、複数演算を一段にまとめた箇所の展開が未解決である。"],
  ["calculation_formulae_034_claim_range_of_args_when_product_arg_is_pi", "LLMによる検証: 未完の同型性に依存する積の偏角公式を入力に使うため、本文完成とは扱わない。場合分けの固定整数の説明は明示されているが、複数の実数演算の同時適用と各行のラベル不足は未解決である。"],
  ["calculation_formulae_033_claim_arg_of_quotient", "LLMによる検証: 未完の同型性を入力として逆写像の積保存と単位元保存を使うため、証明は未完の入力に依存する。準同型の逆写像という一般論を具体計算へ展開すること、逆元保存の適用行の参照と実数演算の分解が未解決である。"],
  ["calculation_formulae_031_definition_abs_arg", "LLMによる検証: 絶対値と偏角の二定義を一項へ束ねている。写像・射影・角度切断への参照を補ったが、二定義への分割と合成写像の値域の説明は未解決である。"],
  ["calculation_formulae_031b_claim_abs_basic_properties", "LLMによる検証: 六つの性質に平方比較・Lagrange恒等式・二成分の不等式が同居し、第一射影の代表元独立性もここで初めて示す。主張分割と妥当性の提示順、各適用行の参照、複数演算の同時適用が未解決である。加法を体の項で定めたとする文は、先行の複素数定義が既に加法を持つ現状に合わせる必要がある。成分計算は逆方向写像と未完の同型性を使わない。"],
  ["calculation_formulae_032_claim_arg_of_product", "LLMによる検証: 未完の同型性から逆写像の積保存を使うため、この証明も未完の入力に依存している。抽象的な準同型の逆写像の議論を具体計算へ展開することと、各適用行の参照、複数演算の同時適用が未解決である。"],
  ["calculation_formulae_028_definition_phi_cartesian", "LLMによる検証: 正弦・余弦の現行定義域は主値区間のみであり、任意の角度を代入する写像定義は未完である。全実数上への拡張、周期性、半径零と正を分けた代表元独立性が不足する。説明粒度だけの問題とは扱わず、定義追加後に内部依存と節の閉包を再判定する。"],
  ["calculation_formulae_029_claim_isomorphism_of_phi_cartesian", "LLMによる検証: 全実数上の三角関数、加法定理、周期性、π移動公式が未整備であり、積保存の証明は未完である。一方向の合成が恒等であることだけでは単射性は導けず、全単射の証明も未完である。極座標側の加法を定義していないため、体として同型という原稿TODOは現状の目標にできない。積保存と全単射の主張分割、定義・補題追加後に内部依存と閉包を再判定する。"],
  ["calculation_formulae_030_definition_first_and_second_projections", "LLMによる検証: 半径と角度同値類への二つの射影を一項に束ねている。半径零と正の場合を分けた代表元独立性の説明と二定義の分割が未解決である。"],
  ["calculation_formulae_024_claim_multiplicative_group_of_complex_numbers", "LLMによる検証: 非零複素数の乗法群と商の記法を一項へ束ね、分配律と結合律を同時適用して同じ定理と説明する段、一般集合 S の逆元一意性、適用行のラベル不足がある。複素数の成分計算への統一と主張分割は未解決である。"],
  ["calculation_formulae_025_claim_complex_numbers_form_a_field", "LLMによる検証: 加法の諸性質、分配律、単位元の相違、乗法逆元を一項に束ね、複数演算をまとめた段と行末ラベル不足がある。成分加法を未定義扱いした旧説明は現行の定義に合わせたが、本文の主張分割と各段の展開は未解決である。"],
  ["calculation_formulae_022_definition_operations_on_polar_representation", "LLMによる検証: 代表元から演算を定めた際の代表元独立性は後続の乗法群の主張で初めて示している。定義と妥当性の提示の整備が未解決である。"],
  ["calculation_formulae_023_claim_multiplicative_group_of_polar_representation", "LLMによる検証: モノイド性・非零部分の群・逆元公式を一項に束ね、一般集合 S の逆元一意性を挿入し、各適用行のラベルが不足する。半径と角度の対の具体的計算への統一と主張の分割は未解決である。"],
  ["calc_formulae_015_claim_cos_arctan_sin_arctan", "LLMによる検証: 逆正接の正弦と余弦の二等式を一項に束ね、適用行ごとの定義ラベルと平方根の商の根拠が不足している。構造だけを確定し、主張の分割と一ステップ一定理の説明は未解決とする。"],
  ["calc_formulae_012_definition_arc_length", "LLMによる検証: 円弧長の存在一意性を外部文献の命題番号だけで指定し、その条件と内容を本文内で説明していない。構造だけを確定し、外部文献の内容の本文内説明は未解決とする。"],
  ["calc_formulae_012b_claim_radial_normalization_exists_unique", "LLMによる検証: 正規化の存在一意性の証明は平方根と単位円の根拠を適用行ごとのラベルで引かず、実数の四則として複数の演算を一行へまとめている。節配置だけを確定し、本文の一ステップ一定理への展開は未解決である。"],
  ["calc_formulae_016_definition_angle_equivalence_class", "LLMによる検証: 商集合を定める前提となる反射性・対称性・推移性について、整数 0・-n・n+m を用いる根拠の説明が未整備である。節構造だけを確定し本文完成とは扱わない。"],
  ["calc_formulae_019_definition_polar_equivalence_class", "LLMによる検証: 半径零と正の場合を分けた反射性・対称性・推移性の説明、および同値類から商集合を作る説明が未整備である。外部入力の角度同値関係にも同じ不足がある。節構造だけを確定し本文完成とは扱わない。"],
  ["calc_formulae_014b_claim_arcsin_bijection", "円弧長に関する外部命題の証明を本文内の一ステップ一定理へ展開する余地がある。分類境界と依存順は確定している。"],
  ["transfer_matrix_001_definition_symbols", "二次・多因子の単位行列、サイトごとの三つの Pauli 行列、V1・V2、Jordan–Wigner 行列、全スピン反転行列、双対結合定数、双曲線関数の略記という独立した定義を一ブロックへ束ねている。Pauli行列、cosh・sinh、その正値性は先行項を明示参照したが、tanh と実対数には独立した先行定義がなく、双対関係の後続証明は本項へ依存するため参照できない。分割後に節境界と依存順を再判定する必要がある。"],
  ["transfer_matrix_011_definition_H1_H2", "一般の生成子 H1^{(±)} と H2 の二定義に加え、既存の V1^{(±)} と V2 の指数表示を同じブロックへ束ねている。今回確定する節では外部入力として扱い、将来一ブロック一定義へ分割した後に依存順と節境界を再判定する必要がある。"],
]);
const futureBlockSplitRecommendedById = new Set([
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_011_definition_H1_H2",
]);
const presentationPredecessorEntryIdsById = new Map<string, string[]>([
  // 分割で切り出した二項は、依存関係だけなら章のずっと手前へ移せるが、本文の並びは
  // 分割前と同じ位置に保つ（読む順序を変えないため）。
  ["maxeig_010a_definition_sector_rayleigh_sup", ["maxeig_009_claim_partition_function_sandwich"]],
  ["maxeig_010b_claim_epsilon_commutes_with_W", ["maxeig_010a_definition_sector_rayleigh_sup"]],
  ["closing_definition_D0_open_chain_operator", ["evensectorT_definition_H1_plus"]],
  ["closing_definition_G_boundary_operator", ["closing_definition_D0_open_chain_operator"]],
  ["closing_claim_D0_G_diagonal_action", ["closing_004_claim_H1_plus_in_sigma_z_form"]],
  ["closing_claim_epsilon_D0_G_pairwise_commute", ["closing_claim_D0_G_diagonal_action"]],
  ["evensectorT_claim_V1_plus_half_invertible", ["evenEigen_claim_V_plus_inverse_positive_and_traces"]],
  ["evensectorT_claim_V2_invertible", ["evensectorT_claim_V1_plus_half_invertible"]],
  ["evensectorT_claim_V_plus_factors_invertible", ["evensectorT_claim_V2_invertible"]],
  ["evensectorT_006_claim_linearity_of_T", ["evensectorT_claim_V_plus_factors_invertible"]],
  ["evensectorT_006a_claim_linearity_of_T_V2", ["evensectorT_006_claim_linearity_of_T"]],
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
  "linear_space_general_000_definition_kronecker_product",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "linear_space_general_000c_claim_kronecker_multilinear",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "bridge_003_claim_exp_of_diagonal",
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
const genericConjugationLinearityEntry = entries.find((entry) =>
  entry.id === "TV1_hatZ_hatY_015_claim_linearity_of_T")!;
const conjugationLinearityEntry = entries.find((entry) =>
  entry.id === "evensectorT_006_claim_linearity_of_T")!;
const vTwoConjugationLinearityEntry = entries.find((entry) =>
  entry.id === "evensectorT_006a_claim_linearity_of_T_V2")!;
const vPlusCompositeConjugationDefinitionEntry = entries.find((entry) =>
  entry.id === "evensectorT_definition_T_V_plus")!;
const vPlusCompositeConjugationEqualityEntry = entries.find((entry) =>
  entry.id === "evensectorT_claim_T_V_plus_is_conjugation")!;
const positiveDefiniteWEntry = entries.find((entry) =>
  entry.id === "maxeig_003_claim_W_is_positive_definite")!;
const checkNumberOperatorIdempotentEntry = entries.find((entry) =>
  entry.id === "evenEigen_002_claim_check_number_operator_idempotent")!;
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
  || vTwoConjugationLinearityEntry.dependencyPlacement!.chapterOrder !== 68
  || vPlusInvertibleEntry.kind !== "claim"
  || vPlusInversePositiveDefiniteEntry.kind !== "claim"
  || traceVPlusPositiveEntry.kind !== "claim"
  || vPlusInversePositiveAndTracesEntry.kind !== "claim"
  || v1PlusHalfInvertibleEntry.kind !== "claim"
  || vTwoInvertibleEntry.kind !== "claim"
  || vPlusFactorsInvertibleEntry.kind !== "claim"
  || genericConjugationLinearityEntry.kind !== "claim"
  || conjugationLinearityEntry.kind !== "claim"
  || vTwoConjugationLinearityEntry.kind !== "claim"
  || checkNumberOperatorIdempotentEntry.kind !== "claim"
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
  || JSON.stringify([...vPlusFactorsInvertibleEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(vPlusFactorsInvertibleExpectedDirectDependencies)
  || JSON.stringify([...conjugationLinearityEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(conjugationLinearityExpectedDirectDependencies)
  || JSON.stringify([...vTwoConjugationLinearityEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(vTwoConjugationLinearityExpectedDirectDependencies)
  || JSON.stringify([...genericConjugationLinearityEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(genericConjugationLinearityExpectedDirectDependencies)
  || v1PlusHalfInvertibleEntry.explanationGranularityReview.inspectedContentSha256
    !== v1PlusHalfInvertibleExpectedContentSha256
  || vTwoInvertibleEntry.explanationGranularityReview.inspectedContentSha256
    !== vTwoInvertibleExpectedContentSha256
  || vPlusFactorsInvertibleEntry.explanationGranularityReview.inspectedContentSha256
    !== vPlusFactorsInvertibleExpectedContentSha256
  || conjugationLinearityEntry.explanationGranularityReview.inspectedContentSha256
    !== conjugationLinearityExpectedContentSha256
  || vTwoConjugationLinearityEntry.explanationGranularityReview.inspectedContentSha256
    !== vTwoConjugationLinearityExpectedContentSha256
  || JSON.stringify([...checkNumberOperatorIdempotentEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(checkNumberOperatorIdempotentExpectedDirectDependencies)
  || checkNumberOperatorIdempotentEntry.explanationGranularityReview.inspectedContentSha256
    !== checkNumberOperatorIdempotentExpectedContentSha256
  || genericConjugationLinearityEntry.explanationGranularityReview.inspectedContentSha256
    !== genericConjugationLinearityExpectedContentSha256
  || vPlusPositiveDefiniteSection.sectionEntries.some((entry) =>
    entry.dependsOnEntryIds.includes(vPlusFactorsInvertibleEntry.id))
  || vPlusPositiveDefiniteSection.sectionEntries.some((entry) =>
    vPlusFactorsInvertibleEntry.dependsOnEntryIds.includes(entry.id))
  || !conjugationLinearityEntry.dependsOnEntryIds.includes(v1PlusHalfInvertibleEntry.id)
  || !conjugationLinearityEntry.dependsOnEntryIds.includes(genericConjugationLinearityEntry.id)
  || !vTwoConjugationLinearityEntry.dependsOnEntryIds.includes(genericConjugationLinearityEntry.id)
  || !vTwoConjugationLinearityEntry.dependsOnEntryIds.includes(vTwoInvertibleEntry.id)
  || vTwoConjugationLinearityEntry.dependsOnEntryIds.includes(v1PlusHalfInvertibleEntry.id)
  || vPlusPositiveDefiniteSection.sectionEntries.some((entry) =>
    conjugationLinearityEntry.dependsOnEntryIds.includes(entry.id))
  || vPlusFactorsInvertibleEntry.dependsOnEntryIds.includes(conjugationLinearityEntry.id)
  || vPlusInvertibleEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || vPlusInversePositiveDefiniteEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || traceVPlusPositiveEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || vPlusInversePositiveAndTracesEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || v1PlusHalfInvertibleEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || vTwoInvertibleEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || vTwoConjugationLinearityEntry.explanationGranularityReview.status !== "自動検査で主題に適合") {
  throw new Error(`偶セクター転送行列の正定値性・可逆性・残余候補、構成因子の可逆性、共役写像の線型性の節境界が変わりました: ${JSON.stringify({
    orders: [...vPlusPositiveDefiniteSection.sectionEntries, v1PlusHalfInvertibleEntry,
      vTwoInvertibleEntry, vPlusFactorsInvertibleEntry, conjugationLinearityEntry,
      vTwoConjugationLinearityEntry]
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
  "TV1_hatZ_hatY_015_claim_linearity_of_T",
  "evensector_003_definition_half_integer_modes",
  "evensector_003a_definition_check_index_set",
].sort())
  || JSON.stringify(inputsDroppedAfterVPlusFactorsInvertibility.sort()) !== JSON.stringify([
    "TV1_hatZ_hatY_009_definition_invertible_elements",
    "evensectorT_claim_V2_invertible",
    "evensectorT_definition_V_plus",
  ].sort())
  || vPlusFactorsInvertibleEntry.explanationGranularityReview.status
    !== "自動検査で主題に適合"
  || conjugationLinearityEntry.explanationGranularityReview.status
    !== "自動検査で主題に適合") {
  throw new Error(`構成因子の可逆性から共役写像の線型性への入力集合が変わりました: ${JSON.stringify({
    added: inputsAddedForConjugationLinearity,
    dropped: inputsDroppedAfterVPlusFactorsInvertibility,
  })}`);
}
const conjugationLinearityInputSet = new Set(conjugationLinearityEntry.dependsOnEntryIds);
const inputsAddedForVTwoConjugationLinearity = vTwoConjugationLinearityEntry.dependsOnEntryIds
  .filter((id) => !conjugationLinearityInputSet.has(id));
const inputsDroppedAfterConjugationLinearity = conjugationLinearityEntry.dependsOnEntryIds
  .filter((id) => !vTwoConjugationLinearityEntry.dependsOnEntryIds.includes(id));
if (JSON.stringify(inputsAddedForVTwoConjugationLinearity.sort()) !== JSON.stringify([
  "evensectorT_claim_V2_invertible",
].sort())
  || JSON.stringify(inputsDroppedAfterConjugationLinearity.sort()) !== JSON.stringify([
    "evensectorT_claim_V1_plus_half_invertible",
  ].sort())) {
  throw new Error(`半指数行列から V_2 の共役写像の線型性への入力集合が変わりました: ${JSON.stringify({
    added: inputsAddedForVTwoConjugationLinearity,
    dropped: inputsDroppedAfterConjugationLinearity,
  })}`);
}
const vPlusCompositeConjugationSectionEntryIds = [
  vPlusCompositeConjugationDefinitionEntry.id,
  vPlusCompositeConjugationEqualityEntry.id,
];
const vPlusCompositeConjugationSectionIdSet = new Set(vPlusCompositeConjugationSectionEntryIds);
const vPlusCompositeConjugationExternalInputEntryIds = [...new Set(
  [vPlusCompositeConjugationDefinitionEntry, vPlusCompositeConjugationEqualityEntry]
    .flatMap((entry) => entry.dependsOnEntryIds)
    .filter((id) => !vPlusCompositeConjugationSectionIdSet.has(id)),
)].sort((a, b) => order.get(a)!.chapterOrder - order.get(b)!.chapterOrder);
if (vPlusCompositeConjugationDefinitionEntry.dependencyPlacement!.chapterOrder !== 69
  || vPlusCompositeConjugationEqualityEntry.dependencyPlacement!.chapterOrder !== 70
  || positiveDefiniteWEntry.dependencyPlacement!.chapterOrder !== 71
  || vPlusCompositeConjugationDefinitionEntry.provisionalFinalChapter !== "2次元イジングモデル"
  || vPlusCompositeConjugationEqualityEntry.provisionalFinalChapter !== "2次元イジングモデル"
  || positiveDefiniteWEntry.provisionalFinalChapter !== "2次元イジングモデル"
  || vPlusCompositeConjugationDefinitionEntry.kind !== "definition"
  || vPlusCompositeConjugationEqualityEntry.kind !== "claim"
  || JSON.stringify([...vPlusCompositeConjugationDefinitionEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(vPlusCompositeConjugationDefinitionExpectedDirectDependencies)
  || JSON.stringify([...vPlusCompositeConjugationEqualityEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(vPlusCompositeConjugationEqualityExpectedDirectDependencies)
  || vPlusCompositeConjugationDefinitionEntry.explanationGranularityReview.inspectedContentSha256
    !== vPlusCompositeConjugationDefinitionExpectedContentSha256
  || vPlusCompositeConjugationEqualityEntry.explanationGranularityReview.inspectedContentSha256
    !== vPlusCompositeConjugationEqualityExpectedContentSha256
  || vPlusCompositeConjugationDefinitionEntry.explanationGranularityReview.status
    !== "自動検査で主題に適合"
  || vPlusCompositeConjugationEqualityEntry.explanationGranularityReview.status
    !== "自動検査で主題に適合"
  || !vPlusCompositeConjugationEqualityEntry.dependsOnEntryIds
    .includes(vPlusCompositeConjugationDefinitionEntry.id)
  || vPlusCompositeConjugationDefinitionEntry.dependsOnEntryIds
    .includes(vPlusCompositeConjugationEqualityEntry.id)
  || positiveDefiniteWEntry.dependsOnEntryIds.some((id) =>
    vPlusCompositeConjugationSectionIdSet.has(id))
  || [vPlusCompositeConjugationDefinitionEntry, vPlusCompositeConjugationEqualityEntry]
    .some((entry) => entry.dependsOnEntryIds.includes(positiveDefiniteWEntry.id))) {
  throw new Error(`偶セクターの合成共役写像の二項節が変わりました: ${JSON.stringify({
    ordersAndChapters: [vPlusCompositeConjugationDefinitionEntry, vPlusCompositeConjugationEqualityEntry,
      positiveDefiniteWEntry].map((entry) => [entry.id, entry.dependencyPlacement?.chapterOrder,
        entry.provisionalFinalChapter]),
    definitionDependencies: vPlusCompositeConjugationDefinitionEntry.dependsOnEntryIds,
    equalityDependencies: vPlusCompositeConjugationEqualityEntry.dependsOnEntryIds,
    nextDependencies: positiveDefiniteWEntry.dependsOnEntryIds,
    contentSha256: [vPlusCompositeConjugationDefinitionEntry,
      vPlusCompositeConjugationEqualityEntry]
      .map((entry) => [entry.id, entry.explanationGranularityReview.inspectedContentSha256]),
  })}`);
}
const vPlusCompositeConjugationInputSet = new Set(vPlusCompositeConjugationExternalInputEntryIds);
const inputsAddedForPositiveDefiniteW = positiveDefiniteWEntry.dependsOnEntryIds
  .filter((id) => !vPlusCompositeConjugationInputSet.has(id));
const inputsDroppedAfterVPlusCompositeConjugation = vPlusCompositeConjugationExternalInputEntryIds
  .filter((id) => !positiveDefiniteWEntry.dependsOnEntryIds.includes(id));
if (JSON.stringify(inputsAddedForPositiveDefiniteW.sort()) !== JSON.stringify([
  "eigenvalues_of_V_011_definition_hermitian_positive_definite",
  "eigenvalues_of_V_012_claim_star_is_norm_preserving",
  "eigenvalues_of_V_013_claim_exp_hermitian_positive_definite",
  "eigenvalues_of_V_014_claim_iH_is_real_symmetric",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "maxeig_001_definition_transfer_matrix_square_root",
  "maxeig_001a_definition_symmetrized_transfer_matrix",
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_011_definition_H1_H2",
].sort())
  || JSON.stringify(inputsDroppedAfterVPlusCompositeConjugation.sort()) !== JSON.stringify([
    "TV1_hatZ_hatY_009_definition_invertible_elements",
    "TV1_hatZ_hatY_011_definition_T_g",
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_046_claim_conjugation_is_ring_homomorphism",
    "evensectorT_claim_V1_plus_half_invertible",
    "evensectorT_claim_V2_invertible",
    "evensectorT_definition_V_plus",
  ].sort())) {
  throw new Error(`偶セクターの合成共役写像から正定値行列 W への入力集合が変わりました: ${JSON.stringify({
    added: inputsAddedForPositiveDefiniteW,
    dropped: inputsDroppedAfterVPlusCompositeConjugation,
  })}`);
}
const rayleighSupEntry = entries.find((entry) =>
  entry.id === "maxeig_006_definition_rayleigh_sup")!;
const positiveDefiniteWExpectedDirectDependencies = [
  "eigenvalues_of_V_011_definition_hermitian_positive_definite",
  "eigenvalues_of_V_012_claim_star_is_norm_preserving",
  "eigenvalues_of_V_013_claim_exp_hermitian_positive_definite",
  "eigenvalues_of_V_014_claim_iH_is_real_symmetric",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "maxeig_001_definition_transfer_matrix_square_root",
  "maxeig_001a_definition_symmetrized_transfer_matrix",
  "transfer_matrix_001_definition_symbols",
  "transfer_matrix_011_definition_H1_H2",
].sort();
// 順72（Rayleigh 上限）で新しく入る入力。ここで単位球面上の上限という実数固有の道具へ移るため、
// 順71 の後で節を閉じる。
const rayleighSupNewInputEntryIds = ["linear_space_general_002b_definition_matrix_norm"].sort();
if (positiveDefiniteWEntry.kind !== "claim"
  || rayleighSupEntry.dependencyPlacement!.chapterOrder !== 72
  || rayleighSupEntry.provisionalFinalChapter !== "2次元イジングモデル"
  || JSON.stringify([...positiveDefiniteWEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(positiveDefiniteWExpectedDirectDependencies)
  || positiveDefiniteWEntry.explanationGranularityReview.inspectedContentSha256
    !== "2cbfb2d79ed95a09699d8d990efb810a203709788487d03dbd74d570ec4155e0"
  || positiveDefiniteWEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || !rayleighSupEntry.dependsOnEntryIds.includes(positiveDefiniteWEntry.id)
  || positiveDefiniteWEntry.dependsOnEntryIds.includes(rayleighSupEntry.id)
  || JSON.stringify(rayleighSupEntry.dependsOnEntryIds
    .filter((id) => !positiveDefiniteWEntry.dependsOnEntryIds.includes(id)
      && id !== positiveDefiniteWEntry.id
      && id !== "calculation_formulae_definition_set_and_algebra_notation").sort())
    !== JSON.stringify(rayleighSupNewInputEntryIds)) {
  throw new Error(`正定値行列 W の一項節が変わりました: ${JSON.stringify({
    order: positiveDefiniteWEntry.dependencyPlacement?.chapterOrder,
    kind: positiveDefiniteWEntry.kind,
    dependencies: positiveDefiniteWEntry.dependsOnEntryIds,
    contentSha256: positiveDefiniteWEntry.explanationGranularityReview.inspectedContentSha256,
    rayleighDependencies: rayleighSupEntry.dependsOnEntryIds,
  })}`);
}
const operatorBoundEntry = entries.find((entry) =>
  entry.id === "maxeig_007_claim_operator_bound")!;
const rayleighSupExpectedDirectDependencies = [
  "calculation_formulae_definition_set_and_algebra_notation",
  "linear_space_general_002b_definition_matrix_norm",
  "maxeig_003_claim_W_is_positive_definite",
].sort();
if (rayleighSupEntry.kind !== "definition"
  || operatorBoundEntry.dependencyPlacement!.chapterOrder !== 73
  || operatorBoundEntry.provisionalFinalChapter !== "2次元イジングモデル"
  || JSON.stringify([...rayleighSupEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(rayleighSupExpectedDirectDependencies)
  || rayleighSupEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || !operatorBoundEntry.dependsOnEntryIds.includes(rayleighSupEntry.id)
  || rayleighSupEntry.dependsOnEntryIds.includes(operatorBoundEntry.id)
  || !operatorBoundEntry.dependsOnEntryIds.includes("maxeig_005_claim_psd_cauchy_schwarz")
  || rayleighSupEntry.dependsOnEntryIds.includes("maxeig_005_claim_psd_cauchy_schwarz")) {
  throw new Error(`Rayleigh 上限の一項節が変わりました: ${JSON.stringify({
    order: rayleighSupEntry.dependencyPlacement?.chapterOrder,
    kind: rayleighSupEntry.kind,
    dependencies: rayleighSupEntry.dependsOnEntryIds,
    operatorBoundDependencies: operatorBoundEntry.dependsOnEntryIds,
  })}`);
}
const tracePowerUpperBoundEntry = entries.find((entry) =>
  entry.id === "maxeig_008a_claim_trace_power_upper_bound")!;
const momentLogConvexityEntry = entries.find((entry) =>
  entry.id === "maxeig_008b_claim_moment_log_convexity")!;
const tracePowerSandwichEntry = entries.find((entry) =>
  entry.id === "maxeig_008_claim_trace_power_sandwich")!;
const operatorBoundExpectedDirectDependencies = [
  "calculation_formulae_definition_set_and_algebra_notation",
  "linear_space_general_002b_definition_matrix_norm",
  "maxeig_003_claim_W_is_positive_definite",
  "maxeig_005_claim_psd_cauchy_schwarz",
  "maxeig_006_definition_rayleigh_sup",
].sort();
if (operatorBoundEntry.kind !== "claim"
  || tracePowerUpperBoundEntry.dependencyPlacement!.chapterOrder !== 74
  || tracePowerUpperBoundEntry.provisionalFinalChapter !== "2次元イジングモデル"
  || JSON.stringify([...operatorBoundEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(operatorBoundExpectedDirectDependencies)
  || operatorBoundEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || !tracePowerUpperBoundEntry.dependsOnEntryIds.includes(operatorBoundEntry.id)
  || operatorBoundEntry.dependsOnEntryIds.includes(tracePowerUpperBoundEntry.id)) {
  throw new Error(`作用素評価の一項節が変わりました: ${JSON.stringify({
    order: operatorBoundEntry.dependencyPlacement?.chapterOrder,
    kind: operatorBoundEntry.kind,
    dependencies: operatorBoundEntry.dependsOnEntryIds,
    traceUpperBoundDependencies: tracePowerUpperBoundEntry.dependsOnEntryIds,
  })}`);
}
const tracePowerUpperBoundExpectedDirectDependencies = [
  "calculation_formulae_definition_set_and_algebra_notation",
  "maxeig_003_claim_W_is_positive_definite",
  "maxeig_006_definition_rayleigh_sup",
  "maxeig_007_claim_operator_bound",
].sort();
const momentLogConvexityExpectedDirectDependencies = [
  "calculation_formulae_definition_set_and_algebra_notation",
  "maxeig_001a_definition_symmetrized_transfer_matrix",
  "maxeig_003_claim_W_is_positive_definite",
  "maxeig_005_claim_psd_cauchy_schwarz",
].sort();
if (tracePowerUpperBoundEntry.kind !== "claim"
  || momentLogConvexityEntry.kind !== "claim"
  || momentLogConvexityEntry.dependencyPlacement!.chapterOrder !== 75
  || tracePowerSandwichEntry.dependencyPlacement!.chapterOrder !== 76
  || momentLogConvexityEntry.provisionalFinalChapter !== "2次元イジングモデル"
  || JSON.stringify([...tracePowerUpperBoundEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(tracePowerUpperBoundExpectedDirectDependencies)
  || JSON.stringify([...momentLogConvexityEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(momentLogConvexityExpectedDirectDependencies)
  || momentLogConvexityEntry.dependsOnEntryIds.includes(tracePowerUpperBoundEntry.id)
  || tracePowerUpperBoundEntry.dependsOnEntryIds.includes(momentLogConvexityEntry.id)
  || !tracePowerSandwichEntry.dependsOnEntryIds.includes(tracePowerUpperBoundEntry.id)
  || !tracePowerSandwichEntry.dependsOnEntryIds.includes(momentLogConvexityEntry.id)) {
  throw new Error(`トレースの挟み込みの分割が変わりました: ${JSON.stringify({
    orders: [tracePowerUpperBoundEntry, momentLogConvexityEntry, tracePowerSandwichEntry]
      .map((entry) => [entry.id, entry.dependencyPlacement?.chapterOrder]),
    upperBoundDependencies: tracePowerUpperBoundEntry.dependsOnEntryIds,
    logConvexityDependencies: momentLogConvexityEntry.dependsOnEntryIds,
    sandwichDependencies: tracePowerSandwichEntry.dependsOnEntryIds,
  })}`);
}
const partitionFunctionSandwichEntry = entries.find((entry) =>
  entry.id === "maxeig_009_claim_partition_function_sandwich")!;
const tracePowerSandwichExpectedDirectDependencies = [
  "calculation_formulae_definition_set_and_algebra_notation",
  "maxeig_005_claim_psd_cauchy_schwarz",
  "maxeig_006_definition_rayleigh_sup",
  "maxeig_008a_claim_trace_power_upper_bound",
  "maxeig_008b_claim_moment_log_convexity",
].sort();
if (tracePowerSandwichEntry.kind !== "claim"
  || JSON.stringify([...tracePowerSandwichEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(tracePowerSandwichExpectedDirectDependencies)
  || tracePowerSandwichEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || partitionFunctionSandwichEntry.dependencyPlacement!.chapterOrder
    !== tracePowerSandwichEntry.dependencyPlacement!.chapterOrder + 1
  || !partitionFunctionSandwichEntry.dependsOnEntryIds.includes(tracePowerSandwichEntry.id)
  || !partitionFunctionSandwichEntry.dependsOnEntryIds.includes("maxeig_002_claim_Z_equals_trace_of_W")
  || tracePowerSandwichEntry.dependsOnEntryIds.includes(partitionFunctionSandwichEntry.id)) {
  throw new Error(`トレースの挟み込み本体の一項節が変わりました: ${JSON.stringify({
    order: tracePowerSandwichEntry.dependencyPlacement?.chapterOrder,
    dependencies: tracePowerSandwichEntry.dependsOnEntryIds,
    partitionFunctionSandwichOrder: partitionFunctionSandwichEntry.dependencyPlacement?.chapterOrder,
    partitionFunctionSandwichDependencies: partitionFunctionSandwichEntry.dependsOnEntryIds,
  })}`);
}
const partitionFunctionSandwichExpectedDirectDependencies = [
  "bridge_007_claim_partition_function_in_pauli_form",
  "calculation_formulae_definition_set_and_algebra_notation",
  "maxeig_002_claim_Z_equals_trace_of_W",
  "maxeig_008_claim_trace_power_sandwich",
].sort();
if (partitionFunctionSandwichEntry.kind !== "claim"
  || partitionFunctionSandwichEntry.dependencyPlacement!.chapterOrder !== 77
  || JSON.stringify([...partitionFunctionSandwichEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(partitionFunctionSandwichExpectedDirectDependencies)
  || partitionFunctionSandwichEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || entries.filter((entry) => entry.dependsOnEntryIds.includes(partitionFunctionSandwichEntry.id))
    .some((entry) => entry.dependencyPlacement!.chapterOrder <= 77)) {
  throw new Error(`分配関数の挟み撃ちの一項節が変わりました: ${JSON.stringify({
    order: partitionFunctionSandwichEntry.dependencyPlacement?.chapterOrder,
    dependencies: partitionFunctionSandwichEntry.dependsOnEntryIds,
  })}`);
}
const sectorRayleighSupEntry = entries.find((entry) =>
  entry.id === "maxeig_010a_definition_sector_rayleigh_sup")!;
const epsilonCommutesWithWEntry = entries.find((entry) =>
  entry.id === "maxeig_010b_claim_epsilon_commutes_with_W")!;
const sectorDecompositionEntry = entries.find((entry) =>
  entry.id === "maxeig_010_claim_sector_decomposition_of_c")!;
const sectorRayleighSupExpectedDirectDependencies = [
  "Z_Y_anticommutation_000a_claim_pauli_matrix_products",
  "bridge_008_definition_epsilon_projectors",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "linear_space_general_000_definition_kronecker_product",
  "linear_space_general_000b_claim_kronecker_product_rule",
  "maxeig_006_definition_rayleigh_sup",
  "transfer_matrix_004_definition_eigenspaces_of_epsilon",
].sort();
const epsilonCommutesWithWExpectedDirectDependencies = [
  "bridge_010_claim_epsilon_commutes",
  "maxeig_001a_definition_symmetrized_transfer_matrix",
  "transfer_matrix_004_definition_eigenspaces_of_epsilon",
].sort();
if (sectorRayleighSupEntry.kind !== "definition"
  || epsilonCommutesWithWEntry.kind !== "claim"
  || sectorRayleighSupEntry.dependencyPlacement!.chapterOrder !== 79
  || epsilonCommutesWithWEntry.dependencyPlacement!.chapterOrder !== 80
  || JSON.stringify([...sectorRayleighSupEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(sectorRayleighSupExpectedDirectDependencies)
  || JSON.stringify([...epsilonCommutesWithWEntry.dependsOnEntryIds].sort())
    !== JSON.stringify(epsilonCommutesWithWExpectedDirectDependencies)
  || sectorRayleighSupEntry.dependsOnEntryIds.includes(epsilonCommutesWithWEntry.id)
  || epsilonCommutesWithWEntry.dependsOnEntryIds.includes(sectorRayleighSupEntry.id)
  || !sectorDecompositionEntry.dependsOnEntryIds.includes(sectorRayleighSupEntry.id)
  || !sectorDecompositionEntry.dependsOnEntryIds.includes(epsilonCommutesWithWEntry.id)) {
  throw new Error(`セクター上限の定義と可換性の二項節が変わりました: ${JSON.stringify({
    orders: [sectorRayleighSupEntry, epsilonCommutesWithWEntry, sectorDecompositionEntry]
      .map((entry) => [entry.id, entry.dependencyPlacement?.chapterOrder]),
    sectorRayleighSupDependencies: sectorRayleighSupEntry.dependsOnEntryIds,
    epsilonCommutesDependencies: epsilonCommutesWithWEntry.dependsOnEntryIds,
    sectorDecompositionDependencies: sectorDecompositionEntry.dependsOnEntryIds,
  })}`);
}
const setAndAlgebraNotationEntry = entries.find((entry) =>
  entry.id === "calculation_formulae_definition_set_and_algebra_notation")!;
const complexNumberDefinitionEntry = entries.find((entry) =>
  entry.id === "calc_formulae_006_definition_of_cc")!;
const matrixDecompositionEntry = entries.find((entry) =>
  entry.id === "calc_formulae_003_matrix_decomposition")!;
if (setAndAlgebraNotationEntry.kind !== "definition"
  || complexNumberDefinitionEntry.kind !== "definition"
  || setAndAlgebraNotationEntry.provisionalFinalChapter !== "数学的道具立て"
  || complexNumberDefinitionEntry.provisionalFinalChapter !== "数学的道具立て"
  || setAndAlgebraNotationEntry.dependencyPlacement!.chapterOrder !== 1
  || complexNumberDefinitionEntry.dependencyPlacement!.chapterOrder !== 2
  || matrixDecompositionEntry.dependencyPlacement!.chapterOrder !== 3
  || setAndAlgebraNotationEntry.dependsOnEntryIds.length !== 0
  || JSON.stringify([...complexNumberDefinitionEntry.dependsOnEntryIds].sort())
    !== JSON.stringify([setAndAlgebraNotationEntry.id])
  || JSON.stringify([...matrixDecompositionEntry.dependsOnEntryIds].sort())
    !== JSON.stringify([complexNumberDefinitionEntry.id, setAndAlgebraNotationEntry.id].sort())
  // 二項の前方参照は「後続への案内」として判定済みで、意味的前提ではない
  || complexNumberDefinitionEntry.forwardStatementReferenceLabelsUsedAsPrerequisites.length !== 0
  || setAndAlgebraNotationEntry.forwardStatementReferenceLabelsUsedAsPrerequisites.length !== 0) {
  throw new Error(`数学的道具立ての冒頭二項節が変わりました: ${JSON.stringify({
    orders: [setAndAlgebraNotationEntry, complexNumberDefinitionEntry, matrixDecompositionEntry]
      .map((entry) => [entry.id, entry.dependencyPlacement?.chapterOrder]),
    notationDependencies: setAndAlgebraNotationEntry.dependsOnEntryIds,
    complexNumberDependencies: complexNumberDefinitionEntry.dependsOnEntryIds,
    matrixDecompositionDependencies: matrixDecompositionEntry.dependsOnEntryIds,
  })}`);
}
const columnwiseActionEntry = entries.find((entry) =>
  entry.id === "calc_formulae_004_action_on_matrix_pair")!;
const matrixConjugationEntry = entries.find((entry) =>
  entry.id === "calc_formulae_005_matrix_conjugation")!;
if (matrixDecompositionEntry.kind !== "definition"
  || columnwiseActionEntry.kind !== "theorem"
  || columnwiseActionEntry.dependencyPlacement!.chapterOrder !== 4
  || matrixConjugationEntry.dependencyPlacement!.chapterOrder !== 5
  || !columnwiseActionEntry.dependsOnEntryIds.includes(matrixDecompositionEntry.id)
  || matrixDecompositionEntry.dependsOnEntryIds.includes(columnwiseActionEntry.id)
  || matrixConjugationEntry.dependsOnEntryIds.includes(columnwiseActionEntry.id)
  // 行列の積の定義は本文の20箇所以上から根拠として引かれる。引用先がこのラベルであり続けること。
  || !matrixDecompositionEntry.labels.includes("mat_mult")) {
  throw new Error(`行列の積の定義と列ごとの作用の二項節が変わりました: ${JSON.stringify({
    orders: [matrixDecompositionEntry, columnwiseActionEntry, matrixConjugationEntry]
      .map((entry) => [entry.id, entry.dependencyPlacement?.chapterOrder, entry.kind]),
    columnwiseDependencies: columnwiseActionEntry.dependsOnEntryIds,
    conjugationDependencies: matrixConjugationEntry.dependsOnEntryIds,
  })}`);
}
const inclusionRealToComplexEntry = entries.find((entry) =>
  entry.id === "calc_formulae_007_inclusion_rr_to_cc")!;
if (matrixConjugationEntry.kind !== "theorem"
  || matrixConjugationEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || JSON.stringify([...matrixConjugationEntry.dependsOnEntryIds].sort())
    !== JSON.stringify([complexNumberDefinitionEntry.id])
  || inclusionRealToComplexEntry.dependencyPlacement!.chapterOrder !== 6
  || inclusionRealToComplexEntry.dependsOnEntryIds.includes(matrixConjugationEntry.id)
  || matrixConjugationEntry.dependsOnEntryIds.includes(inclusionRealToComplexEntry.id)) {
  throw new Error(`可逆行列による共役写像の一項節が変わりました: ${JSON.stringify({
    order: matrixConjugationEntry.dependencyPlacement?.chapterOrder,
    kind: matrixConjugationEntry.kind,
    granularity: matrixConjugationEntry.explanationGranularityReview.status,
    dependencies: matrixConjugationEntry.dependsOnEntryIds,
    inclusionOrder: inclusionRealToComplexEntry.dependencyPlacement?.chapterOrder,
  })}`);
}
const complexNumberBasicDefinitionEntryIds = [
  "calc_formulae_007_inclusion_rr_to_cc",
  "calc_formulae_008_multiply_by_minus_one",
  "calc_formulae_009_sqrt_minus_one",
  "calc_formulae_010_definition_real_imag_parts_of_cc",
];
const complexNumberBasicDefinitionEntries = complexNumberBasicDefinitionEntryIds.map((id) => {
  const entry = entries.find((candidate) => candidate.id === id);
  if (entry === undefined) throw new Error(`複素数に付随する定義の節に必要な項目がありません: ${id}`);
  return entry;
});
const unitCircleEntry = entries.find((entry) =>
  entry.id === "calc_formulae_011_definition_unit_circle")!;
const complexNumberBasicDefinitionIdSet = new Set(complexNumberBasicDefinitionEntryIds);
if (complexNumberBasicDefinitionEntries.some((entry, index) =>
  entry.kind !== "definition"
  || entry.provisionalFinalChapter !== "数学的道具立て"
  || entry.dependencyPlacement!.chapterOrder !== 6 + index
  || entry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || !entry.dependsOnEntryIds.includes(complexNumberDefinitionEntry.id)
  // 四項は互いに独立で、複素数の定義と記号の規約だけを引く
  || entry.dependsOnEntryIds.some((id) => complexNumberBasicDefinitionIdSet.has(id)))
  || unitCircleEntry.dependencyPlacement!.chapterOrder !== 10
  || unitCircleEntry.dependsOnEntryIds.some((id) => complexNumberBasicDefinitionIdSet.has(id))) {
  throw new Error(`複素数に付随する定義の節が変わりました: ${JSON.stringify({
    orders: complexNumberBasicDefinitionEntries.map((entry) =>
      [entry.id, entry.dependencyPlacement?.chapterOrder, entry.kind]),
    dependencies: complexNumberBasicDefinitionEntries.map((entry) => entry.dependsOnEntryIds),
    unitCircleOrder: unitCircleEntry.dependencyPlacement?.chapterOrder,
    unitCircleDependencies: unitCircleEntry.dependsOnEntryIds,
  })}`);
}
const arcLengthEntry = entries.find((entry) =>
  entry.id === "calc_formulae_012_definition_arc_length")!;
const angleEquivalenceEntry = entries.find((entry) =>
  entry.id === "calc_formulae_016_definition_angle_equivalence_class")!;
if (unitCircleEntry.kind !== "definition"
  || arcLengthEntry.kind !== "definition"
  || arcLengthEntry.dependencyPlacement!.chapterOrder !== 11
  || angleEquivalenceEntry.dependencyPlacement!.chapterOrder !== 12
  || JSON.stringify([...unitCircleEntry.dependsOnEntryIds].sort())
    !== JSON.stringify([complexNumberDefinitionEntry.id])
  || JSON.stringify([...arcLengthEntry.dependsOnEntryIds].sort())
    !== JSON.stringify([unitCircleEntry.id])
  || unitCircleEntry.explanationGranularityReview.status !== "自動検査で主題に適合"
  || arcLengthEntry.explanationGranularityReview.status !== "具体的な行列計算への展開またはブロック分割を要する"
  // 直後の角度表現の枝は、単位円にも円弧にも依存しない別の出発点である
  || angleEquivalenceEntry.dependsOnEntryIds.includes(unitCircleEntry.id)
  || angleEquivalenceEntry.dependsOnEntryIds.includes(arcLengthEntry.id)) {
  throw new Error(`単位円と円弧の二項節が変わりました: ${JSON.stringify({
    orders: [unitCircleEntry, arcLengthEntry, angleEquivalenceEntry]
      .map((entry) => [entry.id, entry.dependencyPlacement?.chapterOrder, entry.kind]),
    unitCircleDependencies: unitCircleEntry.dependsOnEntryIds,
    arcLengthDependencies: arcLengthEntry.dependsOnEntryIds,
    angleEquivalenceDependencies: angleEquivalenceEntry.dependsOnEntryIds,
  })}`);
}
const angleRepresentationEntryIds = [
  "calc_formulae_016_definition_angle_equivalence_class",
  "calc_formulae_016b_claim_angle_section_existence_uniqueness",
  "calc_formulae_017_definition_section_of_angle_representation",
  "calc_formulae_018_definition_angle_representation_of_rr",
];
const angleRepresentationEntries = angleRepresentationEntryIds.map((id) => {
  const entry = entries.find((candidate) => candidate.id === id);
  if (entry === undefined) throw new Error(`角度表現の節に必要な項目がありません: ${id}`);
  return entry;
});
const angleRepresentationIdSet = new Set(angleRepresentationEntryIds);
const polarEquivalenceEntry = entries.find((entry) =>
  entry.id === "calc_formulae_019_definition_polar_equivalence_class")!;
const angleRepresentationOfRealsEntry = angleRepresentationEntries[3]!;
if (angleRepresentationEntries.some((entry, index) =>
  entry.provisionalFinalChapter !== "数学的道具立て"
  || entry.dependencyPlacement!.chapterOrder !== 12 + index
  || entry.explanationGranularityReview.status !== (index === 0
    ? "具体的な行列計算への展開またはブロック分割を要する" : "自動検査で主題に適合"))
  // 角度表現の定義は、同値関係と切断の両方を実際に前提として引く
  || !angleRepresentationOfRealsEntry.dependsOnEntryIds.includes(angleRepresentationEntryIds[0]!)
  || !angleRepresentationOfRealsEntry.dependsOnEntryIds.includes(angleRepresentationEntryIds[2]!)
  || polarEquivalenceEntry.dependencyPlacement!.chapterOrder !== 16
  || JSON.stringify(polarEquivalenceEntry.dependsOnEntryIds.filter((id) => angleRepresentationIdSet.has(id)))
    !== JSON.stringify([angleRepresentationEntryIds[0]])) {
  throw new Error(`角度表現の節が変わりました: ${JSON.stringify({
    orders: angleRepresentationEntries.map((entry) =>
      [entry.id, entry.dependencyPlacement?.chapterOrder, entry.kind]),
    angleRepresentationDependencies: angleRepresentationOfRealsEntry.dependsOnEntryIds,
    polarOrder: polarEquivalenceEntry.dependencyPlacement?.chapterOrder,
    polarDependencies: polarEquivalenceEntry.dependsOnEntryIds,
  })}`);
}
const hyperbolicEntryIds = [
  "calc_formulae_definition_cosh_sinh",
  "calc_formulae_000_cosh_sinh_product",
  "calc_formulae_000b_claim_cosh_sinh_basic_properties",
];
const squareRootEntryIds = [
  "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
  "calc_formulae_001_sqrt_nonnegative_real",
  "calc_formulae_002_negative_number_to_sqrt",
];
const findToolEntry = (id: string) => {
  const entry = entries.find((candidate) => candidate.id === id);
  if (entry === undefined) throw new Error(`道具章の節に必要な項目がありません: ${id}`);
  return entry;
};
const hyperbolicEntries = hyperbolicEntryIds.map(findToolEntry);
const squareRootEntries = squareRootEntryIds.map(findToolEntry);
const radialNormalizationEntry = findToolEntry("calc_formulae_012b_claim_radial_normalization_exists_unique");
if (hyperbolicEntries.some((entry, index) =>
  entry.provisionalFinalChapter !== "数学的道具立て"
  || entry.dependencyPlacement!.chapterOrder !== 17 + index
  || entry.explanationGranularityReview.status !== "自動検査で主題に適合")
  // 掛け算の定理と基本性質は、どちらも定義だけを引き、互いに依存しない
  || hyperbolicEntries[1]!.dependsOnEntryIds.includes(hyperbolicEntries[2]!.id)
  || hyperbolicEntries[2]!.dependsOnEntryIds.includes(hyperbolicEntries[1]!.id)
  || !hyperbolicEntries[1]!.dependsOnEntryIds.includes(hyperbolicEntries[0]!.id)
  || !hyperbolicEntries[2]!.dependsOnEntryIds.includes(hyperbolicEntries[0]!.id)) {
  throw new Error(`双曲線関数の節が変わりました: ${JSON.stringify({
    orders: hyperbolicEntries.map((entry) => [entry.id, entry.dependencyPlacement?.chapterOrder]),
    dependencies: hyperbolicEntries.map((entry) => entry.dependsOnEntryIds),
  })}`);
}
if (squareRootEntries.some((entry, index) =>
  entry.provisionalFinalChapter !== "数学的道具立て"
  || entry.dependencyPlacement!.chapterOrder !== 20 + index
  || entry.explanationGranularityReview.status !== "自動検査で主題に適合")
  // 存在と一意性 → 平方根の定義 → 負数への拡張、という一方向の鎖
  || !squareRootEntries[1]!.dependsOnEntryIds.includes(squareRootEntries[0]!.id)
  || !squareRootEntries[2]!.dependsOnEntryIds.includes(squareRootEntries[1]!.id)
  || squareRootEntries[0]!.dependsOnEntryIds.includes(squareRootEntries[1]!.id)
  // 存在と一意性は双曲線関数の基本性質を実際に使う
  || !squareRootEntries[0]!.dependsOnEntryIds.includes(hyperbolicEntries[2]!.id)
  || radialNormalizationEntry.dependencyPlacement!.chapterOrder !== 23
  || !radialNormalizationEntry.dependsOnEntryIds.includes(squareRootEntries[1]!.id)) {
  throw new Error(`非負実数の平方根の節が変わりました: ${JSON.stringify({
    orders: squareRootEntries.map((entry) => [entry.id, entry.dependencyPlacement?.chapterOrder]),
    dependencies: squareRootEntries.map((entry) => entry.dependsOnEntryIds),
    radialNormalizationOrder: radialNormalizationEntry.dependencyPlacement?.chapterOrder,
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
    entries.find((entry) => entry.id === id)!.explanationGranularityReview.status ===
      (id === "bridge_003_claim_exp_of_diagonal" ? "具体的な行列計算への展開またはブロック分割を要する" : "自動検査で主題に適合"))
  || epsilonProjectorDefinitionSection.sectionEntries[0]!.explanationGranularityReview.status !== "自動検査で主題に適合"
  ) {
  throw new Error("章内依存順16–29と対称化転送行列の全成分正値性の外部入力の説明粒度判定が変わりました");
}
const polarEquivalenceSection = validateReviewedSection(
  "極座標表現の同値類", "数学的道具立て", [polarEquivalenceEntry.id],
  new Map([[polarEquivalenceEntry.id, []]]),
  new Map([[polarEquivalenceEntry.id, "db5e61c9e6e2f4aef9faa5b5154b7f7e4651951f655d44193a92caf541c654a6"]]),
  ["calc_formulae_016_definition_angle_equivalence_class", "calculation_formulae_definition_set_and_algebra_notation"],
  new Map([
    ["calc_formulae_016_definition_angle_equivalence_class", "f5300fd54e60f601a4db6afe271b4f3c72ef16ff4baf25f5e3d03488a2f5286d"],
    ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"],
  ]), [polarEquivalenceEntry.id],
);
// プログラミングによる検証: 直後の双曲線関数は角度・半径の同一視を入力に取らない。
if (polarEquivalenceEntry.kind !== "definition"
  || polarEquivalenceEntry.explanationGranularityReview.status !== "具体的な行列計算への展開またはブロック分割を要する"
  || hyperbolicEntries[0]!.dependencyPlacement!.chapterOrder !== polarEquivalenceEntry.dependencyPlacement!.chapterOrder + 1
  || JSON.stringify([...hyperbolicEntries[0]!.dependsOnEntryIds].sort()) !== JSON.stringify(["calculation_formulae_definition_set_and_algebra_notation"])
  || hyperbolicEntries[0]!.explanationGranularityReview.inspectedContentSha256 !== "e884934c5a35ebb1daa4e665eb779f623f99cffba33fe779cf01ee52518a6d3a") {
  throw new Error("極座標の同値類から双曲線関数への入力切り替わりが変わりました");
}
const radialNormalizationSectionEntryIds = ["calc_formulae_012b_claim_radial_normalization_exists_unique", "calc_formulae_013_definition_map_cc_to_c_unit"];
const radialNormalizationSection = validateReviewedSection(
  "非零実数対の単位円への正規化", "数学的道具立て", radialNormalizationSectionEntryIds,
  new Map([["calc_formulae_012b_claim_radial_normalization_exists_unique", []], ["calc_formulae_013_definition_map_cc_to_c_unit", ["calc_formulae_012b_claim_radial_normalization_exists_unique"]]]),
  new Map([["calc_formulae_012b_claim_radial_normalization_exists_unique", "9caaed727e3cc6211199fcabb9aac1d890013f0199037ab571fcd3dd5a6e8cd3"], ["calc_formulae_013_definition_map_cc_to_c_unit", "2a9a710aa09edac48ef85c2fdc3d9a033b615f80a815264dceb2773a031e77ce"]]),
  ["calc_formulae_001_sqrt_nonnegative_real", "calc_formulae_006_definition_of_cc", "calc_formulae_011_definition_unit_circle", "calculation_formulae_definition_set_and_algebra_notation"],
  new Map([["calc_formulae_001_sqrt_nonnegative_real", "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"], ["calc_formulae_006_definition_of_cc", "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"], ["calc_formulae_011_definition_unit_circle", "0f0fa73628443bdff271ad3b3dfe9ec8ab947902b46503d6a5822b6925177765"], ["calculation_formulae_definition_set_and_algebra_notation", "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"]]),
  ["calc_formulae_013_definition_map_cc_to_c_unit"],
);
const radialNormalizationBoundaryDependencies = new Map<string, string[]>([["calc_formulae_012b_claim_radial_normalization_exists_unique", ["calc_formulae_001_sqrt_nonnegative_real", "calc_formulae_011_definition_unit_circle", "calculation_formulae_definition_set_and_algebra_notation"]], ["calc_formulae_013_definition_map_cc_to_c_unit", ["calc_formulae_006_definition_of_cc", "calc_formulae_011_definition_unit_circle", "calc_formulae_012b_claim_radial_normalization_exists_unique"]], ["calc_formulae_014_definition_inverse_trig_functions", ["calc_formulae_001_sqrt_nonnegative_real", "calc_formulae_006_definition_of_cc", "calc_formulae_011_definition_unit_circle", "calc_formulae_012_definition_arc_length", "calculation_formulae_definition_set_and_algebra_notation"]]]);
for (const [id, expected] of radialNormalizationBoundaryDependencies) {
  if (JSON.stringify(findToolEntry(id).dependsOnEntryIds) !== JSON.stringify(expected)) {
    throw new Error(`単位円への正規化の境界の直接依存が変わりました: ${id}`);
  }
}
const radialNormalizationNextEntry = findToolEntry("calc_formulae_014_definition_inverse_trig_functions");
if (arcLengthEntry.explanationGranularityReview.inspectedContentSha256 !== "f6df94720c8d99c3fc6bf1618a9a348cc682b41ffe02275f8d3abe80c878d9b9"
  || radialNormalizationNextEntry.dependencyPlacement!.chapterOrder !== radialNormalizationSection.sectionEntries[1]!.dependencyPlacement!.chapterOrder + 1
  || radialNormalizationNextEntry.explanationGranularityReview.inspectedContentSha256 !== "b3a21e2102af9b25c3ba9f787c8f037b17e6e688071689a00df1c6a1aea3fca3"
  || radialNormalizationSection.sectionEntries[0]!.kind !== "claim"
  || radialNormalizationSection.sectionEntries[1]!.kind !== "definition"
  || radialNormalizationSection.sectionEntries[0]!.explanationGranularityReview.manualReview === null) {
  throw new Error("単位円への正規化の主張・定義・直後の逆正弦の境界が変わりました");
}
const inverseTrigonometricSectionEntryIds = [
  "calc_formulae_014_definition_inverse_trig_functions",
  "calc_formulae_014b_claim_arcsin_bijection",
  "calc_formulae_014c_claim_arctan_argument_in_unit_interval",
  "calc_formulae_014c_definition_sin",
  "calc_formulae_014d_definition_arctan",
  "calc_formulae_014e_definition_cos",
  "calc_formulae_015_claim_cos_arctan_sin_arctan"
];
const inverseTrigonometricSection = validateReviewedSection(
  "逆正弦から定める正弦・余弦と逆正接", "数学的道具立て", inverseTrigonometricSectionEntryIds,
  new Map([
  [
    "calc_formulae_014_definition_inverse_trig_functions",
    []
  ],
  [
    "calc_formulae_014b_claim_arcsin_bijection",
    [
      "calc_formulae_014_definition_inverse_trig_functions"
    ]
  ],
  [
    "calc_formulae_014c_claim_arctan_argument_in_unit_interval",
    []
  ],
  [
    "calc_formulae_014c_definition_sin",
    [
      "calc_formulae_014_definition_inverse_trig_functions",
      "calc_formulae_014b_claim_arcsin_bijection"
    ]
  ],
  [
    "calc_formulae_014d_definition_arctan",
    [
      "calc_formulae_014_definition_inverse_trig_functions",
      "calc_formulae_014c_claim_arctan_argument_in_unit_interval"
    ]
  ],
  [
    "calc_formulae_014e_definition_cos",
    [
      "calc_formulae_014c_definition_sin"
    ]
  ],
  [
    "calc_formulae_015_claim_cos_arctan_sin_arctan",
    [
      "calc_formulae_014c_claim_arctan_argument_in_unit_interval",
      "calc_formulae_014c_definition_sin",
      "calc_formulae_014d_definition_arctan",
      "calc_formulae_014e_definition_cos"
    ]
  ]
]),
  new Map([
  [
    "calc_formulae_014_definition_inverse_trig_functions",
    "b3a21e2102af9b25c3ba9f787c8f037b17e6e688071689a00df1c6a1aea3fca3"
  ],
  [
    "calc_formulae_014b_claim_arcsin_bijection",
    "2a7bfb0570e3135f4eb879131abe4e889a9fe8fe580eddc05ec5f6d093fc06f1"
  ],
  [
    "calc_formulae_014c_claim_arctan_argument_in_unit_interval",
    "91239d3958a1bcb5f6a55c5feb68940b12dc41c6d5ecf61c8880ca94cb2476f4"
  ],
  [
    "calc_formulae_014c_definition_sin",
    "6a8ea2317a4ee4a034fe63a9f7371bb06cc429b38cc136c4059b9b1c28983b54"
  ],
  [
    "calc_formulae_014d_definition_arctan",
    "d7d6ac6e18ecfbb96c7bc7ebe9b89c874e6004df8b114a08b95b9c4568d140a2"
  ],
  [
    "calc_formulae_014e_definition_cos",
    "cf32ed2ef717d12941d16958599fccde9b93fe4dc82a7a97b5e4188e35960205"
  ],
  [
    "calc_formulae_015_claim_cos_arctan_sin_arctan",
    "d0e4541754801f6a861911aca135cd1a6d91df5f45cad07fefc2acdbb68b9306"
  ]
]),
  [
  "calc_formulae_001_sqrt_nonnegative_real",
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_011_definition_unit_circle",
  "calc_formulae_012_definition_arc_length",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_001_sqrt_nonnegative_real",
    "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_011_definition_unit_circle",
    "0f0fa73628443bdff271ad3b3dfe9ec8ab947902b46503d6a5822b6925177765"
  ],
  [
    "calc_formulae_012_definition_arc_length",
    "f6df94720c8d99c3fc6bf1618a9a348cc682b41ffe02275f8d3abe80c878d9b9"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "calc_formulae_015_claim_cos_arctan_sin_arctan"
],
);
const inverseTrigonometricSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_011_definition_unit_circle",
    "kind": "definition",
    "sha256": "0f0fa73628443bdff271ad3b3dfe9ec8ab947902b46503d6a5822b6925177765",
    "dependencies": [
      "calc_formulae_006_definition_of_cc"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_012_definition_arc_length",
    "kind": "definition",
    "sha256": "f6df94720c8d99c3fc6bf1618a9a348cc682b41ffe02275f8d3abe80c878d9b9",
    "dependencies": [
      "calc_formulae_011_definition_unit_circle"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_014_definition_inverse_trig_functions",
    "kind": "definition",
    "sha256": "b3a21e2102af9b25c3ba9f787c8f037b17e6e688071689a00df1c6a1aea3fca3",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_011_definition_unit_circle",
      "calc_formulae_012_definition_arc_length",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014b_claim_arcsin_bijection",
    "kind": "claim",
    "sha256": "2a7bfb0570e3135f4eb879131abe4e889a9fe8fe580eddc05ec5f6d093fc06f1",
    "dependencies": [
      "calc_formulae_014_definition_inverse_trig_functions"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_014c_claim_arctan_argument_in_unit_interval",
    "kind": "claim",
    "sha256": "91239d3958a1bcb5f6a55c5feb68940b12dc41c6d5ecf61c8880ca94cb2476f4",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014c_definition_sin",
    "kind": "definition",
    "sha256": "6a8ea2317a4ee4a034fe63a9f7371bb06cc429b38cc136c4059b9b1c28983b54",
    "dependencies": [
      "calc_formulae_014_definition_inverse_trig_functions",
      "calc_formulae_014b_claim_arcsin_bijection"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014d_definition_arctan",
    "kind": "definition",
    "sha256": "d7d6ac6e18ecfbb96c7bc7ebe9b89c874e6004df8b114a08b95b9c4568d140a2",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_014_definition_inverse_trig_functions",
      "calc_formulae_014c_claim_arctan_argument_in_unit_interval",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014e_definition_cos",
    "kind": "definition",
    "sha256": "cf32ed2ef717d12941d16958599fccde9b93fe4dc82a7a97b5e4188e35960205",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_014c_definition_sin",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_015_claim_cos_arctan_sin_arctan",
    "kind": "claim",
    "sha256": "d0e4541754801f6a861911aca135cd1a6d91df5f45cad07fefc2acdbb68b9306",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_014c_claim_arctan_argument_in_unit_interval",
      "calc_formulae_014c_definition_sin",
      "calc_formulae_014d_definition_arctan",
      "calc_formulae_014e_definition_cos",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_019_definition_polar_equivalence_class",
    "kind": "definition",
    "sha256": "db5e61c9e6e2f4aef9faa5b5154b7f7e4651951f655d44193a92caf541c654a6",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_022_definition_operations_on_polar_representation",
    "kind": "definition",
    "sha256": "8efabc0086375dc9fe3f922cbdf1bce1a60adc3c194feb3b7c6668e5cfca94ba",
    "dependencies": [
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of inverseTrigonometricSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`逆正弦から定める正弦・余弦と逆正接の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("calculation_formulae_022_definition_operations_on_polar_representation").dependencyPlacement!.chapterOrder
  !== inverseTrigonometricSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("逆正弦から定める正弦・余弦と逆正接の直後の項目が変わりました");
}
const polarMultiplicationSectionEntryIds = [
  "calculation_formulae_022_definition_operations_on_polar_representation",
  "calculation_formulae_023_claim_multiplicative_group_of_polar_representation"
];
const polarMultiplicationSection = validateReviewedSection(
  "極座標の同値類の積と逆元", "数学的道具立て", polarMultiplicationSectionEntryIds,
  new Map([
  [
    "calculation_formulae_022_definition_operations_on_polar_representation",
    []
  ],
  [
    "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
    [
      "calculation_formulae_022_definition_operations_on_polar_representation"
    ]
  ]
]),
  new Map([
  [
    "calculation_formulae_022_definition_operations_on_polar_representation",
    "8efabc0086375dc9fe3f922cbdf1bce1a60adc3c194feb3b7c6668e5cfca94ba"
  ],
  [
    "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
    "a2f0942eaca2c3852591ec022bfb793463a32d510110f579e43ad76da7b5bd51"
  ]
]),
  [
  "calc_formulae_016_definition_angle_equivalence_class",
  "calc_formulae_019_definition_polar_equivalence_class",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_016_definition_angle_equivalence_class",
    "f5300fd54e60f601a4db6afe271b4f3c72ef16ff4baf25f5e3d03488a2f5286d"
  ],
  [
    "calc_formulae_019_definition_polar_equivalence_class",
    "db5e61c9e6e2f4aef9faa5b5154b7f7e4651951f655d44193a92caf541c654a6"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "calculation_formulae_023_claim_multiplicative_group_of_polar_representation"
],
);
const polarMultiplicationSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_007_inclusion_rr_to_cc",
    "kind": "definition",
    "sha256": "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_016_definition_angle_equivalence_class",
    "kind": "definition",
    "sha256": "f5300fd54e60f601a4db6afe271b4f3c72ef16ff4baf25f5e3d03488a2f5286d",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_019_definition_polar_equivalence_class",
    "kind": "definition",
    "sha256": "db5e61c9e6e2f4aef9faa5b5154b7f7e4651951f655d44193a92caf541c654a6",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_022_definition_operations_on_polar_representation",
    "kind": "definition",
    "sha256": "8efabc0086375dc9fe3f922cbdf1bce1a60adc3c194feb3b7c6668e5cfca94ba",
    "dependencies": [
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
    "kind": "claim",
    "sha256": "a2f0942eaca2c3852591ec022bfb793463a32d510110f579e43ad76da7b5bd51",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "kind": "claim",
    "sha256": "bd4b1ebeede09bd6ebe666ce9e6007c3399351f81939f0a1e89dbe4ef2ec82a7",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of polarMultiplicationSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`極座標の同値類の積と逆元の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("calculation_formulae_024_claim_multiplicative_group_of_complex_numbers").dependencyPlacement!.chapterOrder
  !== polarMultiplicationSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("極座標の同値類の積と逆元の直後の項目が変わりました");
}
const complexFieldSectionEntryIds = [
  "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
  "calculation_formulae_025_claim_complex_numbers_form_a_field"
];
const complexFieldSection = validateReviewedSection(
  "複素数の逆元と四則演算の性質", "数学的道具立て", complexFieldSectionEntryIds,
  new Map([
  [
    "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    []
  ],
  [
    "calculation_formulae_025_claim_complex_numbers_form_a_field",
    [
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers"
    ]
  ]
]),
  new Map([
  [
    "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "bd4b1ebeede09bd6ebe666ce9e6007c3399351f81939f0a1e89dbe4ef2ec82a7"
  ],
  [
    "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6"
  ]
]),
  [
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_007_inclusion_rr_to_cc",
  "calc_formulae_008_multiply_by_minus_one",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_007_inclusion_rr_to_cc",
    "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647"
  ],
  [
    "calc_formulae_008_multiply_by_minus_one",
    "40554c5b165be91970ade721cd63dcef585c555302fe0ff68642327b66571844"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "calculation_formulae_025_claim_complex_numbers_form_a_field"
],
);
const complexFieldSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_007_inclusion_rr_to_cc",
    "kind": "definition",
    "sha256": "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_008_multiply_by_minus_one",
    "kind": "definition",
    "sha256": "40554c5b165be91970ade721cd63dcef585c555302fe0ff68642327b66571844",
    "dependencies": [
      "calc_formulae_006_definition_of_cc"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014d_definition_arctan",
    "kind": "definition",
    "sha256": "d7d6ac6e18ecfbb96c7bc7ebe9b89c874e6004df8b114a08b95b9c4568d140a2",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_014_definition_inverse_trig_functions",
      "calc_formulae_014c_claim_arctan_argument_in_unit_interval",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_019_definition_polar_equivalence_class",
    "kind": "definition",
    "sha256": "db5e61c9e6e2f4aef9faa5b5154b7f7e4651951f655d44193a92caf541c654a6",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "kind": "claim",
    "sha256": "bd4b1ebeede09bd6ebe666ce9e6007c3399351f81939f0a1e89dbe4ef2ec82a7",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "kind": "claim",
    "sha256": "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_008_multiply_by_minus_one",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_027_definition_phi_polar",
    "kind": "definition",
    "sha256": "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014d_definition_arctan",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of complexFieldSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`複素数の逆元と四則演算の性質の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("calculation_formulae_027_definition_phi_polar").dependencyPlacement!.chapterOrder
  !== complexFieldSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("複素数の逆元と四則演算の性質の直後の項目が変わりました");
}
const polarCartesianSectionEntryIds = [
  "calculation_formulae_027_definition_phi_polar",
  "calculation_formulae_028_definition_phi_cartesian",
  "calculation_formulae_029_claim_isomorphism_of_phi_cartesian"
];
const polarCartesianSection = validateReviewedSection(
  "複素数と極座標同値類の対応と積保存", "数学的道具立て", polarCartesianSectionEntryIds,
  new Map([
  [
    "calculation_formulae_027_definition_phi_polar",
    []
  ],
  [
    "calculation_formulae_028_definition_phi_cartesian",
    []
  ],
  [
    "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    [
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian"
    ]
  ]
]),
  new Map([
  [
    "calculation_formulae_027_definition_phi_polar",
    "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861"
  ],
  [
    "calculation_formulae_028_definition_phi_cartesian",
    "5bfd7f4af7609a728b0960ddee5f7d2c63845c8de77f97466d69b2e20ed85530"
  ],
  [
    "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "aae6d06271cd77cac45e78e72bb077fdc036c5988f52cab3223337fb568d0ff5"
  ]
]),
  [
  "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
  "calc_formulae_001_sqrt_nonnegative_real",
  "calc_formulae_002_negative_number_to_sqrt",
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_014c_definition_sin",
  "calc_formulae_014d_definition_arctan",
  "calc_formulae_014e_definition_cos",
  "calc_formulae_015_claim_cos_arctan_sin_arctan",
  "calc_formulae_016_definition_angle_equivalence_class",
  "calc_formulae_019_definition_polar_equivalence_class",
  "calculation_formulae_022_definition_operations_on_polar_representation",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
    "033d11e3fe1d5dbc219e0e546223246eb3e2f18bc094506a1ac9f4764477f3f0"
  ],
  [
    "calc_formulae_001_sqrt_nonnegative_real",
    "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"
  ],
  [
    "calc_formulae_002_negative_number_to_sqrt",
    "265d0520de8b0e717f0cec445cd8186b82647f7b3394ff1271e94ca6e39a8557"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_014c_definition_sin",
    "6a8ea2317a4ee4a034fe63a9f7371bb06cc429b38cc136c4059b9b1c28983b54"
  ],
  [
    "calc_formulae_014d_definition_arctan",
    "d7d6ac6e18ecfbb96c7bc7ebe9b89c874e6004df8b114a08b95b9c4568d140a2"
  ],
  [
    "calc_formulae_014e_definition_cos",
    "cf32ed2ef717d12941d16958599fccde9b93fe4dc82a7a97b5e4188e35960205"
  ],
  [
    "calc_formulae_015_claim_cos_arctan_sin_arctan",
    "d0e4541754801f6a861911aca135cd1a6d91df5f45cad07fefc2acdbb68b9306"
  ],
  [
    "calc_formulae_016_definition_angle_equivalence_class",
    "f5300fd54e60f601a4db6afe271b4f3c72ef16ff4baf25f5e3d03488a2f5286d"
  ],
  [
    "calc_formulae_019_definition_polar_equivalence_class",
    "db5e61c9e6e2f4aef9faa5b5154b7f7e4651951f655d44193a92caf541c654a6"
  ],
  [
    "calculation_formulae_022_definition_operations_on_polar_representation",
    "8efabc0086375dc9fe3f922cbdf1bce1a60adc3c194feb3b7c6668e5cfca94ba"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "calculation_formulae_029_claim_isomorphism_of_phi_cartesian"
],
);
const polarCartesianSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
    "kind": "claim",
    "sha256": "033d11e3fe1d5dbc219e0e546223246eb3e2f18bc094506a1ac9f4764477f3f0",
    "dependencies": [
      "calc_formulae_000b_claim_cosh_sinh_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_002_negative_number_to_sqrt",
    "kind": "theorem",
    "sha256": "265d0520de8b0e717f0cec445cd8186b82647f7b3394ff1271e94ca6e39a8557",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calc_formulae_001_sqrt_nonnegative_real",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_014c_definition_sin",
    "kind": "definition",
    "sha256": "6a8ea2317a4ee4a034fe63a9f7371bb06cc429b38cc136c4059b9b1c28983b54",
    "dependencies": [
      "calc_formulae_014_definition_inverse_trig_functions",
      "calc_formulae_014b_claim_arcsin_bijection"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014d_definition_arctan",
    "kind": "definition",
    "sha256": "d7d6ac6e18ecfbb96c7bc7ebe9b89c874e6004df8b114a08b95b9c4568d140a2",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_014_definition_inverse_trig_functions",
      "calc_formulae_014c_claim_arctan_argument_in_unit_interval",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014e_definition_cos",
    "kind": "definition",
    "sha256": "cf32ed2ef717d12941d16958599fccde9b93fe4dc82a7a97b5e4188e35960205",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_014c_definition_sin",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_015_claim_cos_arctan_sin_arctan",
    "kind": "claim",
    "sha256": "d0e4541754801f6a861911aca135cd1a6d91df5f45cad07fefc2acdbb68b9306",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_014c_claim_arctan_argument_in_unit_interval",
      "calc_formulae_014c_definition_sin",
      "calc_formulae_014d_definition_arctan",
      "calc_formulae_014e_definition_cos",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_016_definition_angle_equivalence_class",
    "kind": "definition",
    "sha256": "f5300fd54e60f601a4db6afe271b4f3c72ef16ff4baf25f5e3d03488a2f5286d",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_019_definition_polar_equivalence_class",
    "kind": "definition",
    "sha256": "db5e61c9e6e2f4aef9faa5b5154b7f7e4651951f655d44193a92caf541c654a6",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_022_definition_operations_on_polar_representation",
    "kind": "definition",
    "sha256": "8efabc0086375dc9fe3f922cbdf1bce1a60adc3c194feb3b7c6668e5cfca94ba",
    "dependencies": [
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_027_definition_phi_polar",
    "kind": "definition",
    "sha256": "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014d_definition_arctan",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_028_definition_phi_cartesian",
    "kind": "definition",
    "sha256": "5bfd7f4af7609a728b0960ddee5f7d2c63845c8de77f97466d69b2e20ed85530",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014c_definition_sin",
      "calc_formulae_014e_definition_cos",
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "kind": "claim",
    "sha256": "aae6d06271cd77cac45e78e72bb077fdc036c5988f52cab3223337fb568d0ff5",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_002_negative_number_to_sqrt",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_015_claim_cos_arctan_sin_arctan",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_030_definition_first_and_second_projections",
    "kind": "definition",
    "sha256": "2076ae1c62bb677aef8f13d1ca7a46147e8d652e035e981d861c3389aa7fee68",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of polarCartesianSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`複素数と極座標同値類の対応と積保存の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("calculation_formulae_030_definition_first_and_second_projections").dependencyPlacement!.chapterOrder
  !== polarCartesianSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("複素数と極座標同値類の対応と積保存の直後の項目が変わりました");
}
const absoluteValueSectionEntryIds = [
  "calculation_formulae_030_definition_first_and_second_projections",
  "calculation_formulae_031_definition_abs_arg",
  "calculation_formulae_031b_claim_abs_basic_properties"
];
const absoluteValueSection = validateReviewedSection(
  "半径と偏角の取り出しと絶対値の性質", "数学的道具立て", absoluteValueSectionEntryIds,
  new Map([
  [
    "calculation_formulae_030_definition_first_and_second_projections",
    []
  ],
  [
    "calculation_formulae_031_definition_abs_arg",
    [
      "calculation_formulae_030_definition_first_and_second_projections"
    ]
  ],
  [
    "calculation_formulae_031b_claim_abs_basic_properties",
    [
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg"
    ]
  ]
]),
  new Map([
  [
    "calculation_formulae_030_definition_first_and_second_projections",
    "2076ae1c62bb677aef8f13d1ca7a46147e8d652e035e981d861c3389aa7fee68"
  ],
  [
    "calculation_formulae_031_definition_abs_arg",
    "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb"
  ],
  [
    "calculation_formulae_031b_claim_abs_basic_properties",
    "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e"
  ]
]),
  [
  "calc_formulae_001_sqrt_nonnegative_real",
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_007_inclusion_rr_to_cc",
  "calc_formulae_016_definition_angle_equivalence_class",
  "calc_formulae_017_definition_section_of_angle_representation",
  "calc_formulae_019_definition_polar_equivalence_class",
  "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
  "calculation_formulae_025_claim_complex_numbers_form_a_field",
  "calculation_formulae_027_definition_phi_polar",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_001_sqrt_nonnegative_real",
    "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_007_inclusion_rr_to_cc",
    "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647"
  ],
  [
    "calc_formulae_016_definition_angle_equivalence_class",
    "f5300fd54e60f601a4db6afe271b4f3c72ef16ff4baf25f5e3d03488a2f5286d"
  ],
  [
    "calc_formulae_017_definition_section_of_angle_representation",
    "eaf728ec8f49c83d0648b474a7922b4d8b061641dd12d7df2c43efe057cbb02b"
  ],
  [
    "calc_formulae_019_definition_polar_equivalence_class",
    "db5e61c9e6e2f4aef9faa5b5154b7f7e4651951f655d44193a92caf541c654a6"
  ],
  [
    "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "bd4b1ebeede09bd6ebe666ce9e6007c3399351f81939f0a1e89dbe4ef2ec82a7"
  ],
  [
    "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6"
  ],
  [
    "calculation_formulae_027_definition_phi_polar",
    "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "calculation_formulae_031b_claim_abs_basic_properties"
],
);
const absoluteValueSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_007_inclusion_rr_to_cc",
    "kind": "definition",
    "sha256": "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_016_definition_angle_equivalence_class",
    "kind": "definition",
    "sha256": "f5300fd54e60f601a4db6afe271b4f3c72ef16ff4baf25f5e3d03488a2f5286d",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "kind": "claim",
    "sha256": "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_017_definition_section_of_angle_representation",
    "kind": "definition",
    "sha256": "eaf728ec8f49c83d0648b474a7922b4d8b061641dd12d7df2c43efe057cbb02b",
    "dependencies": [
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_019_definition_polar_equivalence_class",
    "kind": "definition",
    "sha256": "db5e61c9e6e2f4aef9faa5b5154b7f7e4651951f655d44193a92caf541c654a6",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_022_definition_operations_on_polar_representation",
    "kind": "definition",
    "sha256": "8efabc0086375dc9fe3f922cbdf1bce1a60adc3c194feb3b7c6668e5cfca94ba",
    "dependencies": [
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "kind": "claim",
    "sha256": "bd4b1ebeede09bd6ebe666ce9e6007c3399351f81939f0a1e89dbe4ef2ec82a7",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "kind": "claim",
    "sha256": "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_008_multiply_by_minus_one",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_027_definition_phi_polar",
    "kind": "definition",
    "sha256": "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014d_definition_arctan",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "kind": "claim",
    "sha256": "aae6d06271cd77cac45e78e72bb077fdc036c5988f52cab3223337fb568d0ff5",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_002_negative_number_to_sqrt",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_015_claim_cos_arctan_sin_arctan",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_030_definition_first_and_second_projections",
    "kind": "definition",
    "sha256": "2076ae1c62bb677aef8f13d1ca7a46147e8d652e035e981d861c3389aa7fee68",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031_definition_abs_arg",
    "kind": "definition",
    "sha256": "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031b_claim_abs_basic_properties",
    "kind": "claim",
    "sha256": "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_032_claim_arg_of_product",
    "kind": "claim",
    "sha256": "8829d38e305c87923b41d5169b2d691ca57da503641f3dba603be84a64f8d3ef",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of absoluteValueSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`半径と偏角の取り出しと絶対値の性質の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("calculation_formulae_032_claim_arg_of_product").dependencyPlacement!.chapterOrder
  !== absoluteValueSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("半径と偏角の取り出しと絶対値の性質の直後の項目が変わりました");
}
const argumentProductSectionEntryIds = [
  "calculation_formulae_032_claim_arg_of_product"
];
const argumentProductSection = validateReviewedSection(
  "積の偏角と角度の和の切断", "数学的道具立て", argumentProductSectionEntryIds,
  new Map([
  [
    "calculation_formulae_032_claim_arg_of_product",
    []
  ]
]),
  new Map([
  [
    "calculation_formulae_032_claim_arg_of_product",
    "8829d38e305c87923b41d5169b2d691ca57da503641f3dba603be84a64f8d3ef"
  ]
]),
  [
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_016b_claim_angle_section_existence_uniqueness",
  "calc_formulae_017_definition_section_of_angle_representation",
  "calculation_formulae_022_definition_operations_on_polar_representation",
  "calculation_formulae_027_definition_phi_polar",
  "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
  "calculation_formulae_030_definition_first_and_second_projections",
  "calculation_formulae_031_definition_abs_arg",
  "calculation_formulae_031b_claim_abs_basic_properties",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843"
  ],
  [
    "calc_formulae_017_definition_section_of_angle_representation",
    "eaf728ec8f49c83d0648b474a7922b4d8b061641dd12d7df2c43efe057cbb02b"
  ],
  [
    "calculation_formulae_022_definition_operations_on_polar_representation",
    "8efabc0086375dc9fe3f922cbdf1bce1a60adc3c194feb3b7c6668e5cfca94ba"
  ],
  [
    "calculation_formulae_027_definition_phi_polar",
    "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861"
  ],
  [
    "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "aae6d06271cd77cac45e78e72bb077fdc036c5988f52cab3223337fb568d0ff5"
  ],
  [
    "calculation_formulae_030_definition_first_and_second_projections",
    "2076ae1c62bb677aef8f13d1ca7a46147e8d652e035e981d861c3389aa7fee68"
  ],
  [
    "calculation_formulae_031_definition_abs_arg",
    "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb"
  ],
  [
    "calculation_formulae_031b_claim_abs_basic_properties",
    "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "calculation_formulae_032_claim_arg_of_product"
],
);
const argumentProductSectionBoundarySnapshot = [
  {
    "id": "calculation_formulae_034_claim_range_of_args_when_product_arg_is_pi",
    "kind": "claim",
    "sha256": "627745f1f36c282b04d179c4ed5c998d27cfc96bb1d71c34cfb83c1c96e10cf8",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_032_claim_arg_of_product",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "kind": "claim",
    "sha256": "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_017_definition_section_of_angle_representation",
    "kind": "definition",
    "sha256": "eaf728ec8f49c83d0648b474a7922b4d8b061641dd12d7df2c43efe057cbb02b",
    "dependencies": [
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_022_definition_operations_on_polar_representation",
    "kind": "definition",
    "sha256": "8efabc0086375dc9fe3f922cbdf1bce1a60adc3c194feb3b7c6668e5cfca94ba",
    "dependencies": [
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
    "kind": "claim",
    "sha256": "a2f0942eaca2c3852591ec022bfb793463a32d510110f579e43ad76da7b5bd51",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "kind": "claim",
    "sha256": "bd4b1ebeede09bd6ebe666ce9e6007c3399351f81939f0a1e89dbe4ef2ec82a7",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_027_definition_phi_polar",
    "kind": "definition",
    "sha256": "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014d_definition_arctan",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "kind": "claim",
    "sha256": "aae6d06271cd77cac45e78e72bb077fdc036c5988f52cab3223337fb568d0ff5",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_002_negative_number_to_sqrt",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_015_claim_cos_arctan_sin_arctan",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_030_definition_first_and_second_projections",
    "kind": "definition",
    "sha256": "2076ae1c62bb677aef8f13d1ca7a46147e8d652e035e981d861c3389aa7fee68",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031_definition_abs_arg",
    "kind": "definition",
    "sha256": "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031b_claim_abs_basic_properties",
    "kind": "claim",
    "sha256": "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_032_claim_arg_of_product",
    "kind": "claim",
    "sha256": "8829d38e305c87923b41d5169b2d691ca57da503641f3dba603be84a64f8d3ef",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_033_claim_arg_of_quotient",
    "kind": "claim",
    "sha256": "5591e815aa4cb99d23312ab8d5a6a01da04350908742435be888b0c3eb87c616",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of argumentProductSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`積の偏角と角度の和の切断の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("calculation_formulae_033_claim_arg_of_quotient").dependencyPlacement!.chapterOrder
  !== argumentProductSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("積の偏角と角度の和の切断の直後の項目が変わりました");
}
if (findToolEntry("calculation_formulae_034_claim_range_of_args_when_product_arg_is_pi").dependencyPlacement!.chapterOrder
  !== findToolEntry("calculation_formulae_033_claim_arg_of_quotient").dependencyPlacement!.chapterOrder + 1) {
  throw new Error("積の偏角を再利用するπ条件の相対順が変わりました");
}
const argumentQuotientSectionEntryIds = [
  "calculation_formulae_033_claim_arg_of_quotient"
];
const argumentQuotientSection = validateReviewedSection(
  "商の偏角と角度の差の切断", "数学的道具立て", argumentQuotientSectionEntryIds,
  new Map([
  [
    "calculation_formulae_033_claim_arg_of_quotient",
    []
  ]
]),
  new Map([
  [
    "calculation_formulae_033_claim_arg_of_quotient",
    "5591e815aa4cb99d23312ab8d5a6a01da04350908742435be888b0c3eb87c616"
  ]
]),
  [
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_016b_claim_angle_section_existence_uniqueness",
  "calc_formulae_017_definition_section_of_angle_representation",
  "calculation_formulae_022_definition_operations_on_polar_representation",
  "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
  "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
  "calculation_formulae_027_definition_phi_polar",
  "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
  "calculation_formulae_030_definition_first_and_second_projections",
  "calculation_formulae_031_definition_abs_arg",
  "calculation_formulae_031b_claim_abs_basic_properties",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843"
  ],
  [
    "calc_formulae_017_definition_section_of_angle_representation",
    "eaf728ec8f49c83d0648b474a7922b4d8b061641dd12d7df2c43efe057cbb02b"
  ],
  [
    "calculation_formulae_022_definition_operations_on_polar_representation",
    "8efabc0086375dc9fe3f922cbdf1bce1a60adc3c194feb3b7c6668e5cfca94ba"
  ],
  [
    "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
    "a2f0942eaca2c3852591ec022bfb793463a32d510110f579e43ad76da7b5bd51"
  ],
  [
    "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "bd4b1ebeede09bd6ebe666ce9e6007c3399351f81939f0a1e89dbe4ef2ec82a7"
  ],
  [
    "calculation_formulae_027_definition_phi_polar",
    "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861"
  ],
  [
    "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "aae6d06271cd77cac45e78e72bb077fdc036c5988f52cab3223337fb568d0ff5"
  ],
  [
    "calculation_formulae_030_definition_first_and_second_projections",
    "2076ae1c62bb677aef8f13d1ca7a46147e8d652e035e981d861c3389aa7fee68"
  ],
  [
    "calculation_formulae_031_definition_abs_arg",
    "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb"
  ],
  [
    "calculation_formulae_031b_claim_abs_basic_properties",
    "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "calculation_formulae_033_claim_arg_of_quotient"
],
);
const argumentQuotientSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "kind": "claim",
    "sha256": "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_017_definition_section_of_angle_representation",
    "kind": "definition",
    "sha256": "eaf728ec8f49c83d0648b474a7922b4d8b061641dd12d7df2c43efe057cbb02b",
    "dependencies": [
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_022_definition_operations_on_polar_representation",
    "kind": "definition",
    "sha256": "8efabc0086375dc9fe3f922cbdf1bce1a60adc3c194feb3b7c6668e5cfca94ba",
    "dependencies": [
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
    "kind": "claim",
    "sha256": "a2f0942eaca2c3852591ec022bfb793463a32d510110f579e43ad76da7b5bd51",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "kind": "claim",
    "sha256": "bd4b1ebeede09bd6ebe666ce9e6007c3399351f81939f0a1e89dbe4ef2ec82a7",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_027_definition_phi_polar",
    "kind": "definition",
    "sha256": "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014d_definition_arctan",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "kind": "claim",
    "sha256": "aae6d06271cd77cac45e78e72bb077fdc036c5988f52cab3223337fb568d0ff5",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_002_negative_number_to_sqrt",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_015_claim_cos_arctan_sin_arctan",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_030_definition_first_and_second_projections",
    "kind": "definition",
    "sha256": "2076ae1c62bb677aef8f13d1ca7a46147e8d652e035e981d861c3389aa7fee68",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031_definition_abs_arg",
    "kind": "definition",
    "sha256": "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031b_claim_abs_basic_properties",
    "kind": "claim",
    "sha256": "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_032_claim_arg_of_product",
    "kind": "claim",
    "sha256": "8829d38e305c87923b41d5169b2d691ca57da503641f3dba603be84a64f8d3ef",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_033_claim_arg_of_quotient",
    "kind": "claim",
    "sha256": "5591e815aa4cb99d23312ab8d5a6a01da04350908742435be888b0c3eb87c616",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_034_claim_range_of_args_when_product_arg_is_pi",
    "kind": "claim",
    "sha256": "627745f1f36c282b04d179c4ed5c998d27cfc96bb1d71c34cfb83c1c96e10cf8",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_032_claim_arg_of_product",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of argumentQuotientSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`商の偏角と角度の差の切断の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("calculation_formulae_034_claim_range_of_args_when_product_arg_is_pi").dependencyPlacement!.chapterOrder
  !== argumentQuotientSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("商の偏角と角度の差の切断の直後の項目が変わりました");
}
const argumentPiSectionEntryIds = [
  "calculation_formulae_034_claim_range_of_args_when_product_arg_is_pi"
];
const argumentPiSection = validateReviewedSection(
  "積の偏角がπになるときの偏角の和", "数学的道具立て", argumentPiSectionEntryIds,
  new Map([
  [
    "calculation_formulae_034_claim_range_of_args_when_product_arg_is_pi",
    []
  ]
]),
  new Map([
  [
    "calculation_formulae_034_claim_range_of_args_when_product_arg_is_pi",
    "627745f1f36c282b04d179c4ed5c998d27cfc96bb1d71c34cfb83c1c96e10cf8"
  ]
]),
  [
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_016b_claim_angle_section_existence_uniqueness",
  "calculation_formulae_027_definition_phi_polar",
  "calculation_formulae_031_definition_abs_arg",
  "calculation_formulae_031b_claim_abs_basic_properties",
  "calculation_formulae_032_claim_arg_of_product",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843"
  ],
  [
    "calculation_formulae_027_definition_phi_polar",
    "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861"
  ],
  [
    "calculation_formulae_031_definition_abs_arg",
    "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb"
  ],
  [
    "calculation_formulae_031b_claim_abs_basic_properties",
    "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e"
  ],
  [
    "calculation_formulae_032_claim_arg_of_product",
    "8829d38e305c87923b41d5169b2d691ca57da503641f3dba603be84a64f8d3ef"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "calculation_formulae_034_claim_range_of_args_when_product_arg_is_pi"
],
);
const argumentPiSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "kind": "claim",
    "sha256": "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_017_definition_section_of_angle_representation",
    "kind": "definition",
    "sha256": "eaf728ec8f49c83d0648b474a7922b4d8b061641dd12d7df2c43efe057cbb02b",
    "dependencies": [
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_022_definition_operations_on_polar_representation",
    "kind": "definition",
    "sha256": "8efabc0086375dc9fe3f922cbdf1bce1a60adc3c194feb3b7c6668e5cfca94ba",
    "dependencies": [
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_027_definition_phi_polar",
    "kind": "definition",
    "sha256": "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014d_definition_arctan",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "kind": "claim",
    "sha256": "aae6d06271cd77cac45e78e72bb077fdc036c5988f52cab3223337fb568d0ff5",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_002_negative_number_to_sqrt",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_015_claim_cos_arctan_sin_arctan",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_030_definition_first_and_second_projections",
    "kind": "definition",
    "sha256": "2076ae1c62bb677aef8f13d1ca7a46147e8d652e035e981d861c3389aa7fee68",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031_definition_abs_arg",
    "kind": "definition",
    "sha256": "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031b_claim_abs_basic_properties",
    "kind": "claim",
    "sha256": "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_032_claim_arg_of_product",
    "kind": "claim",
    "sha256": "8829d38e305c87923b41d5169b2d691ca57da503641f3dba603be84a64f8d3ef",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_034_claim_range_of_args_when_product_arg_is_pi",
    "kind": "claim",
    "sha256": "627745f1f36c282b04d179c4ed5c998d27cfc96bb1d71c34cfb83c1c96e10cf8",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_032_claim_arg_of_product",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_035_claim_arg_of_square",
    "kind": "claim",
    "sha256": "5c4e01ef25641e782fc11f048ba69c2bb63eda0b0c91758a3ca1f44a1bdc3a2d",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of argumentPiSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`積の偏角がπになるときの偏角の和の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("calculation_formulae_035_claim_arg_of_square").dependencyPlacement!.chapterOrder
  !== argumentPiSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("積の偏角がπになるときの偏角の和の直後の項目が変わりました");
}
const argumentSquareSectionEntryIds = [
  "calculation_formulae_035_claim_arg_of_square"
];
const argumentSquareSection = validateReviewedSection(
  "自乗の偏角と二倍の角度の切断", "数学的道具立て", argumentSquareSectionEntryIds,
  new Map([
  [
    "calculation_formulae_035_claim_arg_of_square",
    []
  ]
]),
  new Map([
  [
    "calculation_formulae_035_claim_arg_of_square",
    "5c4e01ef25641e782fc11f048ba69c2bb63eda0b0c91758a3ca1f44a1bdc3a2d"
  ]
]),
  [
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_016b_claim_angle_section_existence_uniqueness",
  "calc_formulae_017_definition_section_of_angle_representation",
  "calculation_formulae_022_definition_operations_on_polar_representation",
  "calculation_formulae_027_definition_phi_polar",
  "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
  "calculation_formulae_030_definition_first_and_second_projections",
  "calculation_formulae_031_definition_abs_arg",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843"
  ],
  [
    "calc_formulae_017_definition_section_of_angle_representation",
    "eaf728ec8f49c83d0648b474a7922b4d8b061641dd12d7df2c43efe057cbb02b"
  ],
  [
    "calculation_formulae_022_definition_operations_on_polar_representation",
    "8efabc0086375dc9fe3f922cbdf1bce1a60adc3c194feb3b7c6668e5cfca94ba"
  ],
  [
    "calculation_formulae_027_definition_phi_polar",
    "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861"
  ],
  [
    "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "aae6d06271cd77cac45e78e72bb077fdc036c5988f52cab3223337fb568d0ff5"
  ],
  [
    "calculation_formulae_030_definition_first_and_second_projections",
    "2076ae1c62bb677aef8f13d1ca7a46147e8d652e035e981d861c3389aa7fee68"
  ],
  [
    "calculation_formulae_031_definition_abs_arg",
    "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "calculation_formulae_035_claim_arg_of_square"
],
);
const argumentSquareSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "kind": "claim",
    "sha256": "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_017_definition_section_of_angle_representation",
    "kind": "definition",
    "sha256": "eaf728ec8f49c83d0648b474a7922b4d8b061641dd12d7df2c43efe057cbb02b",
    "dependencies": [
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_022_definition_operations_on_polar_representation",
    "kind": "definition",
    "sha256": "8efabc0086375dc9fe3f922cbdf1bce1a60adc3c194feb3b7c6668e5cfca94ba",
    "dependencies": [
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
    "kind": "claim",
    "sha256": "a2f0942eaca2c3852591ec022bfb793463a32d510110f579e43ad76da7b5bd51",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "kind": "claim",
    "sha256": "bd4b1ebeede09bd6ebe666ce9e6007c3399351f81939f0a1e89dbe4ef2ec82a7",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_027_definition_phi_polar",
    "kind": "definition",
    "sha256": "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014d_definition_arctan",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "kind": "claim",
    "sha256": "aae6d06271cd77cac45e78e72bb077fdc036c5988f52cab3223337fb568d0ff5",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_002_negative_number_to_sqrt",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_015_claim_cos_arctan_sin_arctan",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_030_definition_first_and_second_projections",
    "kind": "definition",
    "sha256": "2076ae1c62bb677aef8f13d1ca7a46147e8d652e035e981d861c3389aa7fee68",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031_definition_abs_arg",
    "kind": "definition",
    "sha256": "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031b_claim_abs_basic_properties",
    "kind": "claim",
    "sha256": "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_035_claim_arg_of_square",
    "kind": "claim",
    "sha256": "5c4e01ef25641e782fc11f048ba69c2bb63eda0b0c91758a3ca1f44a1bdc3a2d",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_036_claim_arg_of_reciprocal",
    "kind": "claim",
    "sha256": "21508055a501558c3ce349b1b00bf697a78d1e34258e17924eb8291c63124fb6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of argumentSquareSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`自乗の偏角と二倍の角度の切断の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("calculation_formulae_036_claim_arg_of_reciprocal").dependencyPlacement!.chapterOrder
  !== argumentSquareSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("自乗の偏角と二倍の角度の切断の直後の項目が変わりました");
}
const argumentReciprocalSectionEntryIds = [
  "calculation_formulae_036_claim_arg_of_reciprocal"
];
const argumentReciprocalSection = validateReviewedSection(
  "逆数の偏角と負の角度の切断", "数学的道具立て", argumentReciprocalSectionEntryIds,
  new Map([
  [
    "calculation_formulae_036_claim_arg_of_reciprocal",
    []
  ]
]),
  new Map([
  [
    "calculation_formulae_036_claim_arg_of_reciprocal",
    "21508055a501558c3ce349b1b00bf697a78d1e34258e17924eb8291c63124fb6"
  ]
]),
  [
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_016b_claim_angle_section_existence_uniqueness",
  "calc_formulae_017_definition_section_of_angle_representation",
  "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
  "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
  "calculation_formulae_027_definition_phi_polar",
  "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
  "calculation_formulae_030_definition_first_and_second_projections",
  "calculation_formulae_031_definition_abs_arg",
  "calculation_formulae_031b_claim_abs_basic_properties",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843"
  ],
  [
    "calc_formulae_017_definition_section_of_angle_representation",
    "eaf728ec8f49c83d0648b474a7922b4d8b061641dd12d7df2c43efe057cbb02b"
  ],
  [
    "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
    "a2f0942eaca2c3852591ec022bfb793463a32d510110f579e43ad76da7b5bd51"
  ],
  [
    "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "bd4b1ebeede09bd6ebe666ce9e6007c3399351f81939f0a1e89dbe4ef2ec82a7"
  ],
  [
    "calculation_formulae_027_definition_phi_polar",
    "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861"
  ],
  [
    "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "aae6d06271cd77cac45e78e72bb077fdc036c5988f52cab3223337fb568d0ff5"
  ],
  [
    "calculation_formulae_030_definition_first_and_second_projections",
    "2076ae1c62bb677aef8f13d1ca7a46147e8d652e035e981d861c3389aa7fee68"
  ],
  [
    "calculation_formulae_031_definition_abs_arg",
    "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb"
  ],
  [
    "calculation_formulae_031b_claim_abs_basic_properties",
    "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "calculation_formulae_036_claim_arg_of_reciprocal"
],
);
const argumentReciprocalSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "kind": "claim",
    "sha256": "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_017_definition_section_of_angle_representation",
    "kind": "definition",
    "sha256": "eaf728ec8f49c83d0648b474a7922b4d8b061641dd12d7df2c43efe057cbb02b",
    "dependencies": [
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_019_definition_polar_equivalence_class",
    "kind": "definition",
    "sha256": "db5e61c9e6e2f4aef9faa5b5154b7f7e4651951f655d44193a92caf541c654a6",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
    "kind": "claim",
    "sha256": "a2f0942eaca2c3852591ec022bfb793463a32d510110f579e43ad76da7b5bd51",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "kind": "claim",
    "sha256": "bd4b1ebeede09bd6ebe666ce9e6007c3399351f81939f0a1e89dbe4ef2ec82a7",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_027_definition_phi_polar",
    "kind": "definition",
    "sha256": "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014d_definition_arctan",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_028_definition_phi_cartesian",
    "kind": "definition",
    "sha256": "5bfd7f4af7609a728b0960ddee5f7d2c63845c8de77f97466d69b2e20ed85530",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014c_definition_sin",
      "calc_formulae_014e_definition_cos",
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "kind": "claim",
    "sha256": "aae6d06271cd77cac45e78e72bb077fdc036c5988f52cab3223337fb568d0ff5",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_002_negative_number_to_sqrt",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_015_claim_cos_arctan_sin_arctan",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_030_definition_first_and_second_projections",
    "kind": "definition",
    "sha256": "2076ae1c62bb677aef8f13d1ca7a46147e8d652e035e981d861c3389aa7fee68",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031_definition_abs_arg",
    "kind": "definition",
    "sha256": "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031b_claim_abs_basic_properties",
    "kind": "claim",
    "sha256": "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_036_claim_arg_of_reciprocal",
    "kind": "claim",
    "sha256": "21508055a501558c3ce349b1b00bf697a78d1e34258e17924eb8291c63124fb6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_038_definition_sqrt_of_complex_number",
    "kind": "definition",
    "sha256": "806ac234b95ab3b4d315129507d997df85bebf837b3af0cf02472743d26450f1",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of argumentReciprocalSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`逆数の偏角と負の角度の切断の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("calculation_formulae_038_definition_sqrt_of_complex_number").dependencyPlacement!.chapterOrder
  !== argumentReciprocalSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("逆数の偏角と負の角度の切断の直後の項目が変わりました");
}
const squareRootPolarSectionEntryIds = [
  "calculation_formulae_038_definition_sqrt_of_complex_number",
  "calculation_formulae_039_claim_sqrt_expansion_via_polar"
];
const squareRootPolarSection = validateReviewedSection(
  "複素平方根の定義と極座標による展開", "数学的道具立て", squareRootPolarSectionEntryIds,
  new Map([
  [
    "calculation_formulae_038_definition_sqrt_of_complex_number",
    []
  ],
  [
    "calculation_formulae_039_claim_sqrt_expansion_via_polar",
    [
      "calculation_formulae_038_definition_sqrt_of_complex_number"
    ]
  ]
]),
  new Map([
  [
    "calculation_formulae_038_definition_sqrt_of_complex_number",
    "806ac234b95ab3b4d315129507d997df85bebf837b3af0cf02472743d26450f1"
  ],
  [
    "calculation_formulae_039_claim_sqrt_expansion_via_polar",
    "bd0961eeb851b9237a207b05aeb8d123988c8399d0fee5a6d2740454fe284ca9"
  ]
]),
  [
  "calc_formulae_001_sqrt_nonnegative_real",
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_016_definition_angle_equivalence_class",
  "calc_formulae_016b_claim_angle_section_existence_uniqueness",
  "calc_formulae_017_definition_section_of_angle_representation",
  "calc_formulae_019_definition_polar_equivalence_class",
  "calculation_formulae_027_definition_phi_polar",
  "calculation_formulae_028_definition_phi_cartesian",
  "calculation_formulae_030_definition_first_and_second_projections",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_001_sqrt_nonnegative_real",
    "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_016_definition_angle_equivalence_class",
    "f5300fd54e60f601a4db6afe271b4f3c72ef16ff4baf25f5e3d03488a2f5286d"
  ],
  [
    "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843"
  ],
  [
    "calc_formulae_017_definition_section_of_angle_representation",
    "eaf728ec8f49c83d0648b474a7922b4d8b061641dd12d7df2c43efe057cbb02b"
  ],
  [
    "calc_formulae_019_definition_polar_equivalence_class",
    "db5e61c9e6e2f4aef9faa5b5154b7f7e4651951f655d44193a92caf541c654a6"
  ],
  [
    "calculation_formulae_027_definition_phi_polar",
    "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861"
  ],
  [
    "calculation_formulae_028_definition_phi_cartesian",
    "5bfd7f4af7609a728b0960ddee5f7d2c63845c8de77f97466d69b2e20ed85530"
  ],
  [
    "calculation_formulae_030_definition_first_and_second_projections",
    "2076ae1c62bb677aef8f13d1ca7a46147e8d652e035e981d861c3389aa7fee68"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "calculation_formulae_039_claim_sqrt_expansion_via_polar"
],
);
const squareRootPolarSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_016_definition_angle_equivalence_class",
    "kind": "definition",
    "sha256": "f5300fd54e60f601a4db6afe271b4f3c72ef16ff4baf25f5e3d03488a2f5286d",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "kind": "claim",
    "sha256": "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_017_definition_section_of_angle_representation",
    "kind": "definition",
    "sha256": "eaf728ec8f49c83d0648b474a7922b4d8b061641dd12d7df2c43efe057cbb02b",
    "dependencies": [
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_019_definition_polar_equivalence_class",
    "kind": "definition",
    "sha256": "db5e61c9e6e2f4aef9faa5b5154b7f7e4651951f655d44193a92caf541c654a6",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_022_definition_operations_on_polar_representation",
    "kind": "definition",
    "sha256": "8efabc0086375dc9fe3f922cbdf1bce1a60adc3c194feb3b7c6668e5cfca94ba",
    "dependencies": [
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_027_definition_phi_polar",
    "kind": "definition",
    "sha256": "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014d_definition_arctan",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_028_definition_phi_cartesian",
    "kind": "definition",
    "sha256": "5bfd7f4af7609a728b0960ddee5f7d2c63845c8de77f97466d69b2e20ed85530",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014c_definition_sin",
      "calc_formulae_014e_definition_cos",
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "kind": "claim",
    "sha256": "aae6d06271cd77cac45e78e72bb077fdc036c5988f52cab3223337fb568d0ff5",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_002_negative_number_to_sqrt",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_015_claim_cos_arctan_sin_arctan",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_030_definition_first_and_second_projections",
    "kind": "definition",
    "sha256": "2076ae1c62bb677aef8f13d1ca7a46147e8d652e035e981d861c3389aa7fee68",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031_definition_abs_arg",
    "kind": "definition",
    "sha256": "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_038_definition_sqrt_of_complex_number",
    "kind": "definition",
    "sha256": "806ac234b95ab3b4d315129507d997df85bebf837b3af0cf02472743d26450f1",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_039_claim_sqrt_expansion_via_polar",
    "kind": "claim",
    "sha256": "bd0961eeb851b9237a207b05aeb8d123988c8399d0fee5a6d2740454fe284ca9",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_038_definition_sqrt_of_complex_number",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_040_claim_sqrt_commutativity_condition",
    "kind": "claim",
    "sha256": "e3b8c3cbe29792cf8a0a8c1d2d125e646a2afb0332ff50f0ae5b98948e0eab02",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_038_definition_sqrt_of_complex_number",
      "calculation_formulae_039_claim_sqrt_expansion_via_polar",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of squareRootPolarSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`複素平方根の定義と極座標による展開の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("calculation_formulae_040_claim_sqrt_commutativity_condition").dependencyPlacement!.chapterOrder
  !== squareRootPolarSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("複素平方根の定義と極座標による展開の直後の項目が変わりました");
}
const squareRootProductSectionEntryIds = [
  "calculation_formulae_040_claim_sqrt_commutativity_condition",
  "calculation_formulae_041_claim_sqrt_squared_is_original",
  "calculation_formulae_042_claim_square_of_sqrt"
];
const squareRootProductSection = validateReviewedSection(
  "平方根の積と自乗の平方根の符号", "数学的道具立て", squareRootProductSectionEntryIds,
  new Map([
  [
    "calculation_formulae_040_claim_sqrt_commutativity_condition",
    []
  ],
  [
    "calculation_formulae_041_claim_sqrt_squared_is_original",
    []
  ],
  [
    "calculation_formulae_042_claim_square_of_sqrt",
    [
      "calculation_formulae_040_claim_sqrt_commutativity_condition",
      "calculation_formulae_041_claim_sqrt_squared_is_original"
    ]
  ]
]),
  new Map([
  [
    "calculation_formulae_040_claim_sqrt_commutativity_condition",
    "e3b8c3cbe29792cf8a0a8c1d2d125e646a2afb0332ff50f0ae5b98948e0eab02"
  ],
  [
    "calculation_formulae_041_claim_sqrt_squared_is_original",
    "00655d83f9cc055406052def05c1812ab4bc06a485f66b79f65c634fba0b65c7"
  ],
  [
    "calculation_formulae_042_claim_square_of_sqrt",
    "1b11ebe29e388f67c5112888800a081fe0a43dea28f90dc5e711455e9b49d873"
  ]
]),
  [
  "calc_formulae_001_sqrt_nonnegative_real",
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_016b_claim_angle_section_existence_uniqueness",
  "calc_formulae_017_definition_section_of_angle_representation",
  "calc_formulae_019_definition_polar_equivalence_class",
  "calculation_formulae_022_definition_operations_on_polar_representation",
  "calculation_formulae_027_definition_phi_polar",
  "calculation_formulae_028_definition_phi_cartesian",
  "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
  "calculation_formulae_030_definition_first_and_second_projections",
  "calculation_formulae_031_definition_abs_arg",
  "calculation_formulae_038_definition_sqrt_of_complex_number",
  "calculation_formulae_039_claim_sqrt_expansion_via_polar",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_001_sqrt_nonnegative_real",
    "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843"
  ],
  [
    "calc_formulae_017_definition_section_of_angle_representation",
    "eaf728ec8f49c83d0648b474a7922b4d8b061641dd12d7df2c43efe057cbb02b"
  ],
  [
    "calc_formulae_019_definition_polar_equivalence_class",
    "db5e61c9e6e2f4aef9faa5b5154b7f7e4651951f655d44193a92caf541c654a6"
  ],
  [
    "calculation_formulae_022_definition_operations_on_polar_representation",
    "8efabc0086375dc9fe3f922cbdf1bce1a60adc3c194feb3b7c6668e5cfca94ba"
  ],
  [
    "calculation_formulae_027_definition_phi_polar",
    "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861"
  ],
  [
    "calculation_formulae_028_definition_phi_cartesian",
    "5bfd7f4af7609a728b0960ddee5f7d2c63845c8de77f97466d69b2e20ed85530"
  ],
  [
    "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "aae6d06271cd77cac45e78e72bb077fdc036c5988f52cab3223337fb568d0ff5"
  ],
  [
    "calculation_formulae_030_definition_first_and_second_projections",
    "2076ae1c62bb677aef8f13d1ca7a46147e8d652e035e981d861c3389aa7fee68"
  ],
  [
    "calculation_formulae_031_definition_abs_arg",
    "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb"
  ],
  [
    "calculation_formulae_038_definition_sqrt_of_complex_number",
    "806ac234b95ab3b4d315129507d997df85bebf837b3af0cf02472743d26450f1"
  ],
  [
    "calculation_formulae_039_claim_sqrt_expansion_via_polar",
    "bd0961eeb851b9237a207b05aeb8d123988c8399d0fee5a6d2740454fe284ca9"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "calculation_formulae_042_claim_square_of_sqrt"
],
);
const squareRootProductSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_007_inclusion_rr_to_cc",
    "kind": "definition",
    "sha256": "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014c_definition_sin",
    "kind": "definition",
    "sha256": "6a8ea2317a4ee4a034fe63a9f7371bb06cc429b38cc136c4059b9b1c28983b54",
    "dependencies": [
      "calc_formulae_014_definition_inverse_trig_functions",
      "calc_formulae_014b_claim_arcsin_bijection"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014d_definition_arctan",
    "kind": "definition",
    "sha256": "d7d6ac6e18ecfbb96c7bc7ebe9b89c874e6004df8b114a08b95b9c4568d140a2",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_014_definition_inverse_trig_functions",
      "calc_formulae_014c_claim_arctan_argument_in_unit_interval",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014e_definition_cos",
    "kind": "definition",
    "sha256": "cf32ed2ef717d12941d16958599fccde9b93fe4dc82a7a97b5e4188e35960205",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_014c_definition_sin",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "kind": "claim",
    "sha256": "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_017_definition_section_of_angle_representation",
    "kind": "definition",
    "sha256": "eaf728ec8f49c83d0648b474a7922b4d8b061641dd12d7df2c43efe057cbb02b",
    "dependencies": [
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_019_definition_polar_equivalence_class",
    "kind": "definition",
    "sha256": "db5e61c9e6e2f4aef9faa5b5154b7f7e4651951f655d44193a92caf541c654a6",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_022_definition_operations_on_polar_representation",
    "kind": "definition",
    "sha256": "8efabc0086375dc9fe3f922cbdf1bce1a60adc3c194feb3b7c6668e5cfca94ba",
    "dependencies": [
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "kind": "claim",
    "sha256": "bd4b1ebeede09bd6ebe666ce9e6007c3399351f81939f0a1e89dbe4ef2ec82a7",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_027_definition_phi_polar",
    "kind": "definition",
    "sha256": "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014d_definition_arctan",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_028_definition_phi_cartesian",
    "kind": "definition",
    "sha256": "5bfd7f4af7609a728b0960ddee5f7d2c63845c8de77f97466d69b2e20ed85530",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014c_definition_sin",
      "calc_formulae_014e_definition_cos",
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "kind": "claim",
    "sha256": "aae6d06271cd77cac45e78e72bb077fdc036c5988f52cab3223337fb568d0ff5",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_002_negative_number_to_sqrt",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_015_claim_cos_arctan_sin_arctan",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_030_definition_first_and_second_projections",
    "kind": "definition",
    "sha256": "2076ae1c62bb677aef8f13d1ca7a46147e8d652e035e981d861c3389aa7fee68",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031_definition_abs_arg",
    "kind": "definition",
    "sha256": "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_036_claim_arg_of_reciprocal",
    "kind": "claim",
    "sha256": "21508055a501558c3ce349b1b00bf697a78d1e34258e17924eb8291c63124fb6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_038_definition_sqrt_of_complex_number",
    "kind": "definition",
    "sha256": "806ac234b95ab3b4d315129507d997df85bebf837b3af0cf02472743d26450f1",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_039_claim_sqrt_expansion_via_polar",
    "kind": "claim",
    "sha256": "bd0961eeb851b9237a207b05aeb8d123988c8399d0fee5a6d2740454fe284ca9",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_038_definition_sqrt_of_complex_number",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_040_claim_sqrt_commutativity_condition",
    "kind": "claim",
    "sha256": "e3b8c3cbe29792cf8a0a8c1d2d125e646a2afb0332ff50f0ae5b98948e0eab02",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_038_definition_sqrt_of_complex_number",
      "calculation_formulae_039_claim_sqrt_expansion_via_polar",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_041_claim_sqrt_squared_is_original",
    "kind": "claim",
    "sha256": "00655d83f9cc055406052def05c1812ab4bc06a485f66b79f65c634fba0b65c7",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_039_claim_sqrt_expansion_via_polar",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_042_claim_square_of_sqrt",
    "kind": "claim",
    "sha256": "1b11ebe29e388f67c5112888800a081fe0a43dea28f90dc5e711455e9b49d873",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_040_claim_sqrt_commutativity_condition",
      "calculation_formulae_041_claim_sqrt_squared_is_original",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_043_claim_sqrt_of_reciprocal",
    "kind": "claim",
    "sha256": "3a8d21819fa5e7e054513060e418c1cfc6b77b44428e1c8ceab1aa7fc9d318de",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_014c_definition_sin",
      "calc_formulae_014d_definition_arctan",
      "calc_formulae_014e_definition_cos",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_036_claim_arg_of_reciprocal",
      "calculation_formulae_038_definition_sqrt_of_complex_number",
      "calculation_formulae_039_claim_sqrt_expansion_via_polar",
      "calculation_formulae_040_claim_sqrt_commutativity_condition",
      "calculation_formulae_041_claim_sqrt_squared_is_original",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of squareRootProductSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`平方根の積と自乗の平方根の符号の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("calculation_formulae_043_claim_sqrt_of_reciprocal").dependencyPlacement!.chapterOrder
  !== squareRootProductSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("平方根の積と自乗の平方根の符号の直後の項目が変わりました");
}
const squareRootReciprocalSectionEntryIds = [
  "calculation_formulae_043_claim_sqrt_of_reciprocal",
  "calculation_formulae_044_claim_reciprocal_of_sqrt"
];
const squareRootReciprocalSection = validateReviewedSection(
  "逆数の平方根と平方根の逆元", "数学的道具立て", squareRootReciprocalSectionEntryIds,
  new Map([
  [
    "calculation_formulae_043_claim_sqrt_of_reciprocal",
    []
  ],
  [
    "calculation_formulae_044_claim_reciprocal_of_sqrt",
    [
      "calculation_formulae_043_claim_sqrt_of_reciprocal"
    ]
  ]
]),
  new Map([
  [
    "calculation_formulae_043_claim_sqrt_of_reciprocal",
    "3a8d21819fa5e7e054513060e418c1cfc6b77b44428e1c8ceab1aa7fc9d318de"
  ],
  [
    "calculation_formulae_044_claim_reciprocal_of_sqrt",
    "e4434859bed3bbcf8bfaa006afbedb93c4eb574d5f9f32b710751e6234ce7ad7"
  ]
]),
  [
  "calc_formulae_001_sqrt_nonnegative_real",
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_007_inclusion_rr_to_cc",
  "calc_formulae_014c_definition_sin",
  "calc_formulae_014d_definition_arctan",
  "calc_formulae_014e_definition_cos",
  "calc_formulae_016b_claim_angle_section_existence_uniqueness",
  "calc_formulae_019_definition_polar_equivalence_class",
  "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
  "calculation_formulae_027_definition_phi_polar",
  "calculation_formulae_028_definition_phi_cartesian",
  "calculation_formulae_031_definition_abs_arg",
  "calculation_formulae_036_claim_arg_of_reciprocal",
  "calculation_formulae_038_definition_sqrt_of_complex_number",
  "calculation_formulae_039_claim_sqrt_expansion_via_polar",
  "calculation_formulae_040_claim_sqrt_commutativity_condition",
  "calculation_formulae_041_claim_sqrt_squared_is_original",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_001_sqrt_nonnegative_real",
    "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_007_inclusion_rr_to_cc",
    "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647"
  ],
  [
    "calc_formulae_014c_definition_sin",
    "6a8ea2317a4ee4a034fe63a9f7371bb06cc429b38cc136c4059b9b1c28983b54"
  ],
  [
    "calc_formulae_014d_definition_arctan",
    "d7d6ac6e18ecfbb96c7bc7ebe9b89c874e6004df8b114a08b95b9c4568d140a2"
  ],
  [
    "calc_formulae_014e_definition_cos",
    "cf32ed2ef717d12941d16958599fccde9b93fe4dc82a7a97b5e4188e35960205"
  ],
  [
    "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843"
  ],
  [
    "calc_formulae_019_definition_polar_equivalence_class",
    "db5e61c9e6e2f4aef9faa5b5154b7f7e4651951f655d44193a92caf541c654a6"
  ],
  [
    "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "bd4b1ebeede09bd6ebe666ce9e6007c3399351f81939f0a1e89dbe4ef2ec82a7"
  ],
  [
    "calculation_formulae_027_definition_phi_polar",
    "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861"
  ],
  [
    "calculation_formulae_028_definition_phi_cartesian",
    "5bfd7f4af7609a728b0960ddee5f7d2c63845c8de77f97466d69b2e20ed85530"
  ],
  [
    "calculation_formulae_031_definition_abs_arg",
    "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb"
  ],
  [
    "calculation_formulae_036_claim_arg_of_reciprocal",
    "21508055a501558c3ce349b1b00bf697a78d1e34258e17924eb8291c63124fb6"
  ],
  [
    "calculation_formulae_038_definition_sqrt_of_complex_number",
    "806ac234b95ab3b4d315129507d997df85bebf837b3af0cf02472743d26450f1"
  ],
  [
    "calculation_formulae_039_claim_sqrt_expansion_via_polar",
    "bd0961eeb851b9237a207b05aeb8d123988c8399d0fee5a6d2740454fe284ca9"
  ],
  [
    "calculation_formulae_040_claim_sqrt_commutativity_condition",
    "e3b8c3cbe29792cf8a0a8c1d2d125e646a2afb0332ff50f0ae5b98948e0eab02"
  ],
  [
    "calculation_formulae_041_claim_sqrt_squared_is_original",
    "00655d83f9cc055406052def05c1812ab4bc06a485f66b79f65c634fba0b65c7"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "calculation_formulae_044_claim_reciprocal_of_sqrt"
],
);
const squareRootReciprocalSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_007_inclusion_rr_to_cc",
    "kind": "definition",
    "sha256": "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014c_definition_sin",
    "kind": "definition",
    "sha256": "6a8ea2317a4ee4a034fe63a9f7371bb06cc429b38cc136c4059b9b1c28983b54",
    "dependencies": [
      "calc_formulae_014_definition_inverse_trig_functions",
      "calc_formulae_014b_claim_arcsin_bijection"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014d_definition_arctan",
    "kind": "definition",
    "sha256": "d7d6ac6e18ecfbb96c7bc7ebe9b89c874e6004df8b114a08b95b9c4568d140a2",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_014_definition_inverse_trig_functions",
      "calc_formulae_014c_claim_arctan_argument_in_unit_interval",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014e_definition_cos",
    "kind": "definition",
    "sha256": "cf32ed2ef717d12941d16958599fccde9b93fe4dc82a7a97b5e4188e35960205",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_014c_definition_sin",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "kind": "claim",
    "sha256": "872f1af8eb8b84e0cfddfb30aeedfee8ccd4d131838f9875853cbd54ed5a5843",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_019_definition_polar_equivalence_class",
    "kind": "definition",
    "sha256": "db5e61c9e6e2f4aef9faa5b5154b7f7e4651951f655d44193a92caf541c654a6",
    "dependencies": [
      "calc_formulae_016_definition_angle_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "kind": "claim",
    "sha256": "bd4b1ebeede09bd6ebe666ce9e6007c3399351f81939f0a1e89dbe4ef2ec82a7",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_027_definition_phi_polar",
    "kind": "definition",
    "sha256": "c142596ab62d7fd79c40acdffa6a4fe01eb59ace120f96ee2f99cd04084cb861",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014d_definition_arctan",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_028_definition_phi_cartesian",
    "kind": "definition",
    "sha256": "5bfd7f4af7609a728b0960ddee5f7d2c63845c8de77f97466d69b2e20ed85530",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014c_definition_sin",
      "calc_formulae_014e_definition_cos",
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031_definition_abs_arg",
    "kind": "definition",
    "sha256": "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_036_claim_arg_of_reciprocal",
    "kind": "claim",
    "sha256": "21508055a501558c3ce349b1b00bf697a78d1e34258e17924eb8291c63124fb6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_038_definition_sqrt_of_complex_number",
    "kind": "definition",
    "sha256": "806ac234b95ab3b4d315129507d997df85bebf837b3af0cf02472743d26450f1",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_039_claim_sqrt_expansion_via_polar",
    "kind": "claim",
    "sha256": "bd0961eeb851b9237a207b05aeb8d123988c8399d0fee5a6d2740454fe284ca9",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016_definition_angle_equivalence_class",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_038_definition_sqrt_of_complex_number",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_040_claim_sqrt_commutativity_condition",
    "kind": "claim",
    "sha256": "e3b8c3cbe29792cf8a0a8c1d2d125e646a2afb0332ff50f0ae5b98948e0eab02",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_038_definition_sqrt_of_complex_number",
      "calculation_formulae_039_claim_sqrt_expansion_via_polar",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_041_claim_sqrt_squared_is_original",
    "kind": "claim",
    "sha256": "00655d83f9cc055406052def05c1812ab4bc06a485f66b79f65c634fba0b65c7",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_022_definition_operations_on_polar_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
      "calculation_formulae_039_claim_sqrt_expansion_via_polar",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_043_claim_sqrt_of_reciprocal",
    "kind": "claim",
    "sha256": "3a8d21819fa5e7e054513060e418c1cfc6b77b44428e1c8ceab1aa7fc9d318de",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_014c_definition_sin",
      "calc_formulae_014d_definition_arctan",
      "calc_formulae_014e_definition_cos",
      "calc_formulae_016b_claim_angle_section_existence_uniqueness",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_028_definition_phi_cartesian",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_036_claim_arg_of_reciprocal",
      "calculation_formulae_038_definition_sqrt_of_complex_number",
      "calculation_formulae_039_claim_sqrt_expansion_via_polar",
      "calculation_formulae_040_claim_sqrt_commutativity_condition",
      "calculation_formulae_041_claim_sqrt_squared_is_original",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_044_claim_reciprocal_of_sqrt",
    "kind": "claim",
    "sha256": "e4434859bed3bbcf8bfaa006afbedb93c4eb574d5f9f32b710751e6234ce7ad7",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_043_claim_sqrt_of_reciprocal"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_045_theorem_euler_formula_cos_sin",
    "kind": "theorem",
    "sha256": "17e951100e2c864fbd07ab446c37156d9ff2b24e720fefc616e5417df7900e43",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014c_definition_sin",
      "calc_formulae_014e_definition_cos",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of squareRootReciprocalSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`逆数の平方根と平方根の逆元の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("calculation_formulae_045_theorem_euler_formula_cos_sin").dependencyPlacement!.chapterOrder
  !== squareRootReciprocalSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("逆数の平方根と平方根の逆元の直後の項目が変わりました");
}
const eulerTrigSectionEntryIds = [
  "calculation_formulae_045_theorem_euler_formula_cos_sin"
];
const eulerTrigSection = validateReviewedSection(
  "正弦と余弦の指数関数による表示", "数学的道具立て", eulerTrigSectionEntryIds,
  new Map([
  [
    "calculation_formulae_045_theorem_euler_formula_cos_sin",
    []
  ]
]),
  new Map([
  [
    "calculation_formulae_045_theorem_euler_formula_cos_sin",
    "17e951100e2c864fbd07ab446c37156d9ff2b24e720fefc616e5417df7900e43"
  ]
]),
  [
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_014c_definition_sin",
  "calc_formulae_014e_definition_cos",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_014c_definition_sin",
    "6a8ea2317a4ee4a034fe63a9f7371bb06cc429b38cc136c4059b9b1c28983b54"
  ],
  [
    "calc_formulae_014e_definition_cos",
    "cf32ed2ef717d12941d16958599fccde9b93fe4dc82a7a97b5e4188e35960205"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "calculation_formulae_045_theorem_euler_formula_cos_sin"
],
);
const eulerTrigSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_005_matrix_conjugation",
    "kind": "theorem",
    "sha256": "db8101215168a62a7c2059d3e97a8cb9d4a4e898c5be04084e68b1547e9b5239",
    "dependencies": [
      "calc_formulae_006_definition_of_cc"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_014c_definition_sin",
    "kind": "definition",
    "sha256": "6a8ea2317a4ee4a034fe63a9f7371bb06cc429b38cc136c4059b9b1c28983b54",
    "dependencies": [
      "calc_formulae_014_definition_inverse_trig_functions",
      "calc_formulae_014b_claim_arcsin_bijection"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014e_definition_cos",
    "kind": "definition",
    "sha256": "cf32ed2ef717d12941d16958599fccde9b93fe4dc82a7a97b5e4188e35960205",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_014c_definition_sin",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_045_theorem_euler_formula_cos_sin",
    "kind": "theorem",
    "sha256": "17e951100e2c864fbd07ab446c37156d9ff2b24e720fefc616e5417df7900e43",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_014c_definition_sin",
      "calc_formulae_014e_definition_cos",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_046_claim_conjugation_is_ring_homomorphism",
    "kind": "claim",
    "sha256": "5f3c6ac5c3bfa898bea8382a6f3dfdb4e72d4c57928d3e19a05e17bd7bf14c0f",
    "dependencies": [
      "calc_formulae_005_matrix_conjugation",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of eulerTrigSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`正弦と余弦の指数関数による表示の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("calculation_formulae_046_claim_conjugation_is_ring_homomorphism").dependencyPlacement!.chapterOrder
  !== eulerTrigSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("正弦と余弦の指数関数による表示の直後の項目が変わりました");
}
const matrixConjugationSectionEntryIds = [
  "calculation_formulae_046_claim_conjugation_is_ring_homomorphism"
];
const matrixConjugationSection = validateReviewedSection(
  "行列共役による積と単位元の保存と合成", "数学的道具立て", matrixConjugationSectionEntryIds,
  new Map([
  [
    "calculation_formulae_046_claim_conjugation_is_ring_homomorphism",
    []
  ]
]),
  new Map([
  [
    "calculation_formulae_046_claim_conjugation_is_ring_homomorphism",
    "5f3c6ac5c3bfa898bea8382a6f3dfdb4e72d4c57928d3e19a05e17bd7bf14c0f"
  ]
]),
  [
  "calc_formulae_005_matrix_conjugation",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_005_matrix_conjugation",
    "db8101215168a62a7c2059d3e97a8cb9d4a4e898c5be04084e68b1547e9b5239"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "calculation_formulae_046_claim_conjugation_is_ring_homomorphism"
],
);
const matrixConjugationSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_005_matrix_conjugation",
    "kind": "theorem",
    "sha256": "db8101215168a62a7c2059d3e97a8cb9d4a4e898c5be04084e68b1547e9b5239",
    "dependencies": [
      "calc_formulae_006_definition_of_cc"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_046_claim_conjugation_is_ring_homomorphism",
    "kind": "claim",
    "sha256": "5f3c6ac5c3bfa898bea8382a6f3dfdb4e72d4c57928d3e19a05e17bd7bf14c0f",
    "dependencies": [
      "calc_formulae_005_matrix_conjugation",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_047_claim_commutator_via_anticommutators",
    "kind": "claim",
    "sha256": "25d2f2a1ad5ab6bcbe05427a4ce4f06a4250ea5f7f3f79b5d7170303b8d4ebeb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of matrixConjugationSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`行列共役による積と単位元の保存と合成の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("calculation_formulae_047_claim_commutator_via_anticommutators").dependencyPlacement!.chapterOrder
  !== matrixConjugationSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("行列共役による積と単位元の保存と合成の直後の項目が変わりました");
}
const commutatorIdentitySectionEntryIds = [
  "calculation_formulae_047_claim_commutator_via_anticommutators"
];
const commutatorIdentitySection = validateReviewedSection(
  "交換子を反交換子で表す行列恒等式", "数学的道具立て", commutatorIdentitySectionEntryIds,
  new Map([
  [
    "calculation_formulae_047_claim_commutator_via_anticommutators",
    []
  ]
]),
  new Map([
  [
    "calculation_formulae_047_claim_commutator_via_anticommutators",
    "25d2f2a1ad5ab6bcbe05427a4ce4f06a4250ea5f7f3f79b5d7170303b8d4ebeb"
  ]
]),
  [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "calculation_formulae_047_claim_commutator_via_anticommutators"
],
);
const commutatorIdentitySectionBoundarySnapshot = [
  {
    "id": "calc_formulae_000b_claim_cosh_sinh_basic_properties",
    "kind": "claim",
    "sha256": "8eb7e83461c7dd3069ae859b9aa527374c7898d1e6f4609218e4f7caac34c68f",
    "dependencies": [
      "calc_formulae_definition_cosh_sinh",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_047_claim_commutator_via_anticommutators",
    "kind": "claim",
    "sha256": "25d2f2a1ad5ab6bcbe05427a4ce4f06a4250ea5f7f3f79b5d7170303b8d4ebeb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "critical_001_claim_cosh_addition_and_half_angle",
    "kind": "claim",
    "sha256": "1cb6576cf9e8ced25389d06eaff8f79b31a55154aab293a5fa1b58526482dd08",
    "dependencies": [
      "calc_formulae_000b_claim_cosh_sinh_basic_properties",
      "calc_formulae_001_sqrt_nonnegative_real",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of commutatorIdentitySectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`交換子を反交換子で表す行列恒等式の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("critical_001_claim_cosh_addition_and_half_angle").dependencyPlacement!.chapterOrder
  !== commutatorIdentitySection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("交換子を反交換子で表す行列恒等式の直後の項目が変わりました");
}
const hyperbolicCalculusSectionEntryIds = [
  "critical_001_claim_cosh_addition_and_half_angle"
];
const hyperbolicCalculusSection = validateReviewedSection(
  "双曲線関数の加法公式と逆双曲線正弦", "数学的道具立て", hyperbolicCalculusSectionEntryIds,
  new Map([
  [
    "critical_001_claim_cosh_addition_and_half_angle",
    []
  ]
]),
  new Map([
  [
    "critical_001_claim_cosh_addition_and_half_angle",
    "1cb6576cf9e8ced25389d06eaff8f79b31a55154aab293a5fa1b58526482dd08"
  ]
]),
  [
  "calc_formulae_000b_claim_cosh_sinh_basic_properties",
  "calc_formulae_001_sqrt_nonnegative_real",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_000b_claim_cosh_sinh_basic_properties",
    "8eb7e83461c7dd3069ae859b9aa527374c7898d1e6f4609218e4f7caac34c68f"
  ],
  [
    "calc_formulae_001_sqrt_nonnegative_real",
    "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "critical_001_claim_cosh_addition_and_half_angle"
],
);
const hyperbolicCalculusSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_000b_claim_cosh_sinh_basic_properties",
    "kind": "claim",
    "sha256": "8eb7e83461c7dd3069ae859b9aa527374c7898d1e6f4609218e4f7caac34c68f",
    "dependencies": [
      "calc_formulae_definition_cosh_sinh",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014c_definition_sin",
    "kind": "definition",
    "sha256": "6a8ea2317a4ee4a034fe63a9f7371bb06cc429b38cc136c4059b9b1c28983b54",
    "dependencies": [
      "calc_formulae_014_definition_inverse_trig_functions",
      "calc_formulae_014b_claim_arcsin_bijection"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014e_definition_cos",
    "kind": "definition",
    "sha256": "cf32ed2ef717d12941d16958599fccde9b93fe4dc82a7a97b5e4188e35960205",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_014c_definition_sin",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "critical_001_claim_cosh_addition_and_half_angle",
    "kind": "claim",
    "sha256": "1cb6576cf9e8ced25389d06eaff8f79b31a55154aab293a5fa1b58526482dd08",
    "dependencies": [
      "calc_formulae_000b_claim_cosh_sinh_basic_properties",
      "calc_formulae_001_sqrt_nonnegative_real",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "critical_008_claim_elementary_sine_bounds",
    "kind": "claim",
    "sha256": "9884c021fc176d9524dd25e4f5348eb304a09edfd96264c49bf76e4d0e3a2a41",
    "dependencies": [
      "calc_formulae_014c_definition_sin",
      "calc_formulae_014e_definition_cos",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of hyperbolicCalculusSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`双曲線関数の加法公式と逆双曲線正弦の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("critical_008_claim_elementary_sine_bounds").dependencyPlacement!.chapterOrder
  !== hyperbolicCalculusSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("双曲線関数の加法公式と逆双曲線正弦の直後の項目が変わりました");
}
const sineIntegralSectionEntryIds = [
  "critical_008_claim_elementary_sine_bounds",
  "critical_009_claim_closed_form_log_integral",
  "critical_010_claim_sine_integral_two_sided"
];
const sineIntegralSection = validateReviewedSection(
  "正弦の近似と積分の対数評価", "数学的道具立て", sineIntegralSectionEntryIds,
  new Map([
  [
    "critical_008_claim_elementary_sine_bounds",
    []
  ],
  [
    "critical_009_claim_closed_form_log_integral",
    []
  ],
  [
    "critical_010_claim_sine_integral_two_sided",
    [
      "critical_008_claim_elementary_sine_bounds",
      "critical_009_claim_closed_form_log_integral"
    ]
  ]
]),
  new Map([
  [
    "critical_008_claim_elementary_sine_bounds",
    "9884c021fc176d9524dd25e4f5348eb304a09edfd96264c49bf76e4d0e3a2a41"
  ],
  [
    "critical_009_claim_closed_form_log_integral",
    "caf746ec96c16a256aefbec5dc2dc79537d74e662922b544c70c5035146b3875"
  ],
  [
    "critical_010_claim_sine_integral_two_sided",
    "f7860f6e57f8cb18dea15cd0a2deb5c958d4ab8be60fcf4c9e55620598c1b0d4"
  ]
]),
  [
  "calc_formulae_001_sqrt_nonnegative_real",
  "calc_formulae_014c_definition_sin",
  "calc_formulae_014e_definition_cos",
  "calculation_formulae_definition_set_and_algebra_notation",
  "critical_001_claim_cosh_addition_and_half_angle"
],
  new Map([
  [
    "calc_formulae_001_sqrt_nonnegative_real",
    "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"
  ],
  [
    "calc_formulae_014c_definition_sin",
    "6a8ea2317a4ee4a034fe63a9f7371bb06cc429b38cc136c4059b9b1c28983b54"
  ],
  [
    "calc_formulae_014e_definition_cos",
    "cf32ed2ef717d12941d16958599fccde9b93fe4dc82a7a97b5e4188e35960205"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ],
  [
    "critical_001_claim_cosh_addition_and_half_angle",
    "1cb6576cf9e8ced25389d06eaff8f79b31a55154aab293a5fa1b58526482dd08"
  ]
]),
  [
  "critical_010_claim_sine_integral_two_sided"
],
);
const sineIntegralSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_014c_definition_sin",
    "kind": "definition",
    "sha256": "6a8ea2317a4ee4a034fe63a9f7371bb06cc429b38cc136c4059b9b1c28983b54",
    "dependencies": [
      "calc_formulae_014_definition_inverse_trig_functions",
      "calc_formulae_014b_claim_arcsin_bijection"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_014e_definition_cos",
    "kind": "definition",
    "sha256": "cf32ed2ef717d12941d16958599fccde9b93fe4dc82a7a97b5e4188e35960205",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_014c_definition_sin",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "critical_001_claim_cosh_addition_and_half_angle",
    "kind": "claim",
    "sha256": "1cb6576cf9e8ced25389d06eaff8f79b31a55154aab293a5fa1b58526482dd08",
    "dependencies": [
      "calc_formulae_000b_claim_cosh_sinh_basic_properties",
      "calc_formulae_001_sqrt_nonnegative_real",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "critical_008_claim_elementary_sine_bounds",
    "kind": "claim",
    "sha256": "9884c021fc176d9524dd25e4f5348eb304a09edfd96264c49bf76e4d0e3a2a41",
    "dependencies": [
      "calc_formulae_014c_definition_sin",
      "calc_formulae_014e_definition_cos",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "critical_009_claim_closed_form_log_integral",
    "kind": "claim",
    "sha256": "caf746ec96c16a256aefbec5dc2dc79537d74e662922b544c70c5035146b3875",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calculation_formulae_definition_set_and_algebra_notation",
      "critical_001_claim_cosh_addition_and_half_angle"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "critical_010_claim_sine_integral_two_sided",
    "kind": "claim",
    "sha256": "f7860f6e57f8cb18dea15cd0a2deb5c958d4ab8be60fcf4c9e55620598c1b0d4",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_014c_definition_sin",
      "calculation_formulae_definition_set_and_algebra_notation",
      "critical_008_claim_elementary_sine_bounds",
      "critical_009_claim_closed_form_log_integral"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "eigenvalues_of_V_001_definition_trace",
    "kind": "definition",
    "sha256": "35ae403d96746496fb0fdaa59d0122e38c3fc5129338230666507cb62c07a73d",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  }
];
for (const expected of sineIntegralSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`正弦の近似と積分の対数評価の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("eigenvalues_of_V_001_definition_trace").dependencyPlacement!.chapterOrder
  !== sineIntegralSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("正弦の近似と積分の対数評価の直後の項目が変わりました");
}
const traceSectionEntryIds = [
  "eigenvalues_of_V_001_definition_trace",
  "eigenvalues_of_V_002_claim_trace_properties",
  "eigenvalues_of_V_003_claim_trace_of_idempotent"
];
const traceSection = validateReviewedSection(
  "トレースの定義と冪等行列の像の次元", "数学的道具立て", traceSectionEntryIds,
  new Map([
  [
    "eigenvalues_of_V_001_definition_trace",
    []
  ],
  [
    "eigenvalues_of_V_002_claim_trace_properties",
    [
      "eigenvalues_of_V_001_definition_trace"
    ]
  ],
  [
    "eigenvalues_of_V_003_claim_trace_of_idempotent",
    [
      "eigenvalues_of_V_001_definition_trace",
      "eigenvalues_of_V_002_claim_trace_properties"
    ]
  ]
]),
  new Map([
  [
    "eigenvalues_of_V_001_definition_trace",
    "35ae403d96746496fb0fdaa59d0122e38c3fc5129338230666507cb62c07a73d"
  ],
  [
    "eigenvalues_of_V_002_claim_trace_properties",
    "78bd54e0678d6ade8a2e4af5af89866b4bcb64adffcf7ce89c4ca7924dd6f7c1"
  ],
  [
    "eigenvalues_of_V_003_claim_trace_of_idempotent",
    "a0cc9fd61c2f5b938ee062e64883ae68a88f1d939636ed051b3acb0ec0102c1b"
  ]
]),
  [
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_003_matrix_decomposition",
    "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "eigenvalues_of_V_003_claim_trace_of_idempotent"
],
);
const traceSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_010_definition_real_imag_parts_of_cc",
    "kind": "definition",
    "sha256": "6e080bfb6c5694b115f4761c5d2db993b1d5c315a4e36f7389774cfd711a07bd",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "eigenvalues_of_V_001_definition_trace",
    "kind": "definition",
    "sha256": "35ae403d96746496fb0fdaa59d0122e38c3fc5129338230666507cb62c07a73d",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "eigenvalues_of_V_002_claim_trace_properties",
    "kind": "claim",
    "sha256": "78bd54e0678d6ade8a2e4af5af89866b4bcb64adffcf7ce89c4ca7924dd6f7c1",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "eigenvalues_of_V_001_definition_trace"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "eigenvalues_of_V_003_claim_trace_of_idempotent",
    "kind": "claim",
    "sha256": "a0cc9fd61c2f5b938ee062e64883ae68a88f1d939636ed051b3acb0ec0102c1b",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "eigenvalues_of_V_001_definition_trace",
      "eigenvalues_of_V_002_claim_trace_properties"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_conjugation_definition_complex_conjugate_and_real_part",
    "kind": "definition",
    "sha256": "69fd82e2a5857d7844277a0dffbd61a33f0c61050aea4abeb87340c5e1fae879",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_010_definition_real_imag_parts_of_cc"
    ],
    "granularity": "自動検査で主題に適合"
  }
];
for (const expected of traceSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`トレースの定義と冪等行列の像の次元の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("exp_conjugation_definition_complex_conjugate_and_real_part").dependencyPlacement!.chapterOrder
  !== traceSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("トレースの定義と冪等行列の像の次元の直後の項目が変わりました");
}
const conjugateAdjointSectionEntryIds = [
  "exp_conjugation_definition_complex_conjugate_and_real_part",
  "eigenvalues_of_V_011_definition_hermitian_positive_definite"
];
const conjugateAdjointSection = validateReviewedSection(
  "複素共役から共役転置と正定値行列へ", "数学的道具立て", conjugateAdjointSectionEntryIds,
  new Map([
  [
    "exp_conjugation_definition_complex_conjugate_and_real_part",
    []
  ],
  [
    "eigenvalues_of_V_011_definition_hermitian_positive_definite",
    [
      "exp_conjugation_definition_complex_conjugate_and_real_part"
    ]
  ]
]),
  new Map([
  [
    "exp_conjugation_definition_complex_conjugate_and_real_part",
    "69fd82e2a5857d7844277a0dffbd61a33f0c61050aea4abeb87340c5e1fae879"
  ],
  [
    "eigenvalues_of_V_011_definition_hermitian_positive_definite",
    "4b1f272661509c47420344ab38051e53285d0f666507a9a3a3333af52a4f6bf1"
  ]
]),
  [
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_007_inclusion_rr_to_cc",
  "calc_formulae_010_definition_real_imag_parts_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_003_matrix_decomposition",
    "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_007_inclusion_rr_to_cc",
    "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647"
  ],
  [
    "calc_formulae_010_definition_real_imag_parts_of_cc",
    "6e080bfb6c5694b115f4761c5d2db993b1d5c315a4e36f7389774cfd711a07bd"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "eigenvalues_of_V_011_definition_hermitian_positive_definite"
],
);
const conjugateAdjointSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_007_inclusion_rr_to_cc",
    "kind": "definition",
    "sha256": "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_010_definition_real_imag_parts_of_cc",
    "kind": "definition",
    "sha256": "6e080bfb6c5694b115f4761c5d2db993b1d5c315a4e36f7389774cfd711a07bd",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "eigenvalues_of_V_011_definition_hermitian_positive_definite",
    "kind": "definition",
    "sha256": "4b1f272661509c47420344ab38051e53285d0f666507a9a3a3333af52a4f6bf1",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_conjugation_definition_complex_conjugate_and_real_part"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_conjugation_definition_complex_conjugate_and_real_part",
    "kind": "definition",
    "sha256": "69fd82e2a5857d7844277a0dffbd61a33f0c61050aea4abeb87340c5e1fae879",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_010_definition_real_imag_parts_of_cc"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "exp_conjugation_proof_004_theorem_ad_binomial",
    "kind": "theorem",
    "sha256": "ba1875ca88bb10163d2a3ba85f2acb5e4a358169c00e6e2959ba76c666c34a1b",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of conjugateAdjointSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`複素共役から共役転置と正定値行列への境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("exp_conjugation_proof_004_theorem_ad_binomial").dependencyPlacement!.chapterOrder
  !== conjugateAdjointSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("複素共役から共役転置と正定値行列への直後の項目が変わりました");
}
const iteratedCommutatorSectionEntryIds = [
  "exp_conjugation_proof_004_theorem_ad_binomial"
];
const iteratedCommutatorSection = validateReviewedSection(
  "反復交換子の二項係数による展開", "数学的道具立て", iteratedCommutatorSectionEntryIds,
  new Map([
  [
    "exp_conjugation_proof_004_theorem_ad_binomial",
    []
  ]
]),
  new Map([
  [
    "exp_conjugation_proof_004_theorem_ad_binomial",
    "ba1875ca88bb10163d2a3ba85f2acb5e4a358169c00e6e2959ba76c666c34a1b"
  ]
]),
  [
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_003_matrix_decomposition",
    "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "exp_conjugation_proof_004_theorem_ad_binomial"
],
);
const iteratedCommutatorSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_conjugation_proof_004_theorem_ad_binomial",
    "kind": "theorem",
    "sha256": "ba1875ca88bb10163d2a3ba85f2acb5e4a358169c00e6e2959ba76c666c34a1b",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_000a_claim_real_exp_series_converges",
    "kind": "claim",
    "sha256": "1065e4f465b1b0b49eae7d16f9d734421f472beec053c3effaff63127eecf077",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of iteratedCommutatorSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`反復交換子の二項係数による展開の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("exp_linear_map_000a_claim_real_exp_series_converges").dependencyPlacement!.chapterOrder
  !== iteratedCommutatorSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("反復交換子の二項係数による展開の直後の項目が変わりました");
}
const realExponentialSeriesSectionEntryIds = [
  "exp_linear_map_000a_claim_real_exp_series_converges"
];
const realExponentialSeriesSection = validateReviewedSection(
  "非負実数の指数級数の収束と剰余", "数学的道具立て", realExponentialSeriesSectionEntryIds,
  new Map([
  [
    "exp_linear_map_000a_claim_real_exp_series_converges",
    []
  ]
]),
  new Map([
  [
    "exp_linear_map_000a_claim_real_exp_series_converges",
    "1065e4f465b1b0b49eae7d16f9d734421f472beec053c3effaff63127eecf077"
  ]
]),
  [
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "exp_linear_map_000a_claim_real_exp_series_converges"
],
);
const realExponentialSeriesSectionBoundarySnapshot = [
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_000a_claim_real_exp_series_converges",
    "kind": "claim",
    "sha256": "1065e4f465b1b0b49eae7d16f9d734421f472beec053c3effaff63127eecf077",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "freeenergy_004_theorem_riemann_sum_to_integral",
    "kind": "theorem",
    "sha256": "b7b5c2383ded596b035d003ba855d8f3d8109c68d44e4459836fa39c2218c4e3",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_004_theorem_exp_zero_is_identity",
    "kind": "theorem",
    "sha256": "bb23ba43e403ab11c2c6a41e4356f0228a5880e37b0e2fe4df9a62289696fd53",
    "dependencies": [
      "exp_linear_map_002_definition_exp_of_endomorphism"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_002_definition_exp_of_endomorphism",
    "kind": "definition",
    "sha256": "1b90c006155b2b723ad7169ab806c4fff82870687ce2865a7bc677a875134fa2",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_linear_map_000b_claim_matrix_exp_series_converges",
      "exp_linear_map_001_theorem_exp_series_pointwise_converges",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of realExponentialSeriesSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`非負実数の指数級数の収束と剰余の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("freeenergy_004_theorem_riemann_sum_to_integral").dependencyPlacement!.chapterOrder
  !== realExponentialSeriesSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("非負実数の指数級数の収束と剰余の直後の項目が変わりました");
}
if (findToolEntry("exp_linear_map_004_theorem_exp_zero_is_identity").dependencyPlacement!.chapterOrder
  <= findToolEntry("exp_linear_map_002_definition_exp_of_endomorphism").dependencyPlacement!.chapterOrder) {
  throw new Error("零行列の指数が行列指数の定義より前へ移りました");
}
const riemannAverageSectionEntryIds = [
  "freeenergy_004_theorem_riemann_sum_to_integral"
];
const riemannAverageSection = validateReviewedSection(
  "等間隔点の平均の積分への収束", "数学的道具立て", riemannAverageSectionEntryIds,
  new Map([
  [
    "freeenergy_004_theorem_riemann_sum_to_integral",
    []
  ]
]),
  new Map([
  [
    "freeenergy_004_theorem_riemann_sum_to_integral",
    "b7b5c2383ded596b035d003ba855d8f3d8109c68d44e4459836fa39c2218c4e3"
  ]
]),
  [
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "freeenergy_004_theorem_riemann_sum_to_integral"
],
);
const riemannAverageSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "freeenergy_004_theorem_riemann_sum_to_integral",
    "kind": "theorem",
    "sha256": "b7b5c2383ded596b035d003ba855d8f3d8109c68d44e4459836fa39c2218c4e3",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_000_definition_kronecker_product",
    "kind": "definition",
    "sha256": "d67144d5a2fc061d370a8a29846c5cdb963a1b6ce42b0f6b08daee519364bc40",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of riemannAverageSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`等間隔点の平均の積分への収束の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("linear_space_general_000_definition_kronecker_product").dependencyPlacement!.chapterOrder
  !== riemannAverageSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("等間隔点の平均の積分への収束の直後の項目が変わりました");
}
const kroneckerProductSectionEntryIds = [
  "linear_space_general_000_definition_kronecker_product",
  "linear_space_general_000b_claim_kronecker_product_rule"
];
const kroneckerProductSection = validateReviewedSection(
  "成分で定めるクロネッカー積と積の規則", "数学的道具立て", kroneckerProductSectionEntryIds,
  new Map([
  [
    "linear_space_general_000_definition_kronecker_product",
    []
  ],
  [
    "linear_space_general_000b_claim_kronecker_product_rule",
    [
      "linear_space_general_000_definition_kronecker_product"
    ]
  ]
]),
  new Map([
  [
    "linear_space_general_000_definition_kronecker_product",
    "d67144d5a2fc061d370a8a29846c5cdb963a1b6ce42b0f6b08daee519364bc40"
  ],
  [
    "linear_space_general_000b_claim_kronecker_product_rule",
    "33e23f14fdb3a2b277ed3327fa3edd342512113eb0eb3d327f88992d26a48bf9"
  ]
]),
  [
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_025_claim_complex_numbers_form_a_field",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_003_matrix_decomposition",
    "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "linear_space_general_000b_claim_kronecker_product_rule"
],
);
const kroneckerProductSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "kind": "claim",
    "sha256": "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_008_multiply_by_minus_one",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_000_definition_kronecker_product",
    "kind": "definition",
    "sha256": "d67144d5a2fc061d370a8a29846c5cdb963a1b6ce42b0f6b08daee519364bc40",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_000b_claim_kronecker_product_rule",
    "kind": "claim",
    "sha256": "33e23f14fdb3a2b277ed3327fa3edd342512113eb0eb3d327f88992d26a48bf9",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_000_definition_kronecker_product"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_000c_claim_kronecker_multilinear",
    "kind": "claim",
    "sha256": "8a73f81902220cd224baa17d4506c7af2e9e7597bda2e6918da88a3b3c1d23c5",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_000_definition_kronecker_product"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of kroneckerProductSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`成分で定めるクロネッカー積と積の規則の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("linear_space_general_000c_claim_kronecker_multilinear").dependencyPlacement!.chapterOrder
  !== kroneckerProductSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("成分で定めるクロネッカー積と積の規則の直後の項目が変わりました");
}
const kroneckerLinearitySectionEntryIds = [
  "linear_space_general_000c_claim_kronecker_multilinear"
];
const kroneckerLinearitySection = validateReviewedSection(
  "クロネッカー積の和とスカラー倍の展開", "数学的道具立て", kroneckerLinearitySectionEntryIds,
  new Map([
  [
    "linear_space_general_000c_claim_kronecker_multilinear",
    []
  ]
]),
  new Map([
  [
    "linear_space_general_000c_claim_kronecker_multilinear",
    "8a73f81902220cd224baa17d4506c7af2e9e7597bda2e6918da88a3b3c1d23c5"
  ]
]),
  [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_025_claim_complex_numbers_form_a_field",
  "calculation_formulae_definition_set_and_algebra_notation",
  "linear_space_general_000_definition_kronecker_product"
],
  new Map([
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ],
  [
    "linear_space_general_000_definition_kronecker_product",
    "d67144d5a2fc061d370a8a29846c5cdb963a1b6ce42b0f6b08daee519364bc40"
  ]
]),
  [
  "linear_space_general_000c_claim_kronecker_multilinear"
],
);
const kroneckerLinearitySectionBoundarySnapshot = [
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "kind": "claim",
    "sha256": "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_008_multiply_by_minus_one",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_000_definition_kronecker_product",
    "kind": "definition",
    "sha256": "d67144d5a2fc061d370a8a29846c5cdb963a1b6ce42b0f6b08daee519364bc40",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_000c_claim_kronecker_multilinear",
    "kind": "claim",
    "sha256": "8a73f81902220cd224baa17d4506c7af2e9e7597bda2e6918da88a3b3c1d23c5",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_000_definition_kronecker_product"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_000d_claim_kronecker_transpose",
    "kind": "claim",
    "sha256": "c0014341f8b8968f27acf4793018d15312e7313acad2dccadd439617703c4cd4",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "linear_space_general_000_definition_kronecker_product"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of kroneckerLinearitySectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`クロネッカー積の和とスカラー倍の展開の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("linear_space_general_000d_claim_kronecker_transpose").dependencyPlacement!.chapterOrder
  !== kroneckerLinearitySection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("クロネッカー積の和とスカラー倍の展開の直後の項目が変わりました");
}
const kroneckerTransposeSectionEntryIds = [
  "linear_space_general_000d_claim_kronecker_transpose"
];
const kroneckerTransposeSection = validateReviewedSection(
  "クロネッカー積の成分添字と転置", "数学的道具立て", kroneckerTransposeSectionEntryIds,
  new Map([
  [
    "linear_space_general_000d_claim_kronecker_transpose",
    []
  ]
]),
  new Map([
  [
    "linear_space_general_000d_claim_kronecker_transpose",
    "c0014341f8b8968f27acf4793018d15312e7313acad2dccadd439617703c4cd4"
  ]
]),
  [
  "calc_formulae_006_definition_of_cc",
  "linear_space_general_000_definition_kronecker_product"
],
  new Map([
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "linear_space_general_000_definition_kronecker_product",
    "d67144d5a2fc061d370a8a29846c5cdb963a1b6ce42b0f6b08daee519364bc40"
  ]
]),
  [
  "linear_space_general_000d_claim_kronecker_transpose"
],
);
const kroneckerTransposeSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_000_definition_kronecker_product",
    "kind": "definition",
    "sha256": "d67144d5a2fc061d370a8a29846c5cdb963a1b6ce42b0f6b08daee519364bc40",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_000c_claim_kronecker_multilinear",
    "kind": "claim",
    "sha256": "8a73f81902220cd224baa17d4506c7af2e9e7597bda2e6918da88a3b3c1d23c5",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_000_definition_kronecker_product"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_000d_claim_kronecker_transpose",
    "kind": "claim",
    "sha256": "c0014341f8b8968f27acf4793018d15312e7313acad2dccadd439617703c4cd4",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "linear_space_general_000_definition_kronecker_product"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_001_theorem_tensor_product_basis",
    "kind": "theorem",
    "sha256": "0b14d498919e0e510b2e50b975d3379db4e963cb1dc5583d6bb429c782a7fd31",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_000_definition_kronecker_product",
      "linear_space_general_000c_claim_kronecker_multilinear"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of kroneckerTransposeSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`クロネッカー積の成分添字と転置の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("linear_space_general_001_theorem_tensor_product_basis").dependencyPlacement!.chapterOrder
  !== kroneckerTransposeSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("クロネッカー積の成分添字と転置の直後の項目が変わりました");
}
const kroneckerBasisSectionEntryIds = [
  "linear_space_general_001_theorem_tensor_product_basis"
];
const kroneckerBasisSection = validateReviewedSection(
  "クロネッカー積で作る行列と数ベクトルの基底", "数学的道具立て", kroneckerBasisSectionEntryIds,
  new Map([
  [
    "linear_space_general_001_theorem_tensor_product_basis",
    []
  ]
]),
  new Map([
  [
    "linear_space_general_001_theorem_tensor_product_basis",
    "0b14d498919e0e510b2e50b975d3379db4e963cb1dc5583d6bb429c782a7fd31"
  ]
]),
  [
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "linear_space_general_000_definition_kronecker_product",
  "linear_space_general_000c_claim_kronecker_multilinear"
],
  new Map([
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ],
  [
    "linear_space_general_000_definition_kronecker_product",
    "d67144d5a2fc061d370a8a29846c5cdb963a1b6ce42b0f6b08daee519364bc40"
  ],
  [
    "linear_space_general_000c_claim_kronecker_multilinear",
    "8a73f81902220cd224baa17d4506c7af2e9e7597bda2e6918da88a3b3c1d23c5"
  ]
]),
  [
  "linear_space_general_001_theorem_tensor_product_basis"
],
);
const kroneckerBasisSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "kind": "claim",
    "sha256": "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_008_multiply_by_minus_one",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_047_claim_commutator_via_anticommutators",
    "kind": "claim",
    "sha256": "25d2f2a1ad5ab6bcbe05427a4ce4f06a4250ea5f7f3f79b5d7170303b8d4ebeb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_000_definition_kronecker_product",
    "kind": "definition",
    "sha256": "d67144d5a2fc061d370a8a29846c5cdb963a1b6ce42b0f6b08daee519364bc40",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_000c_claim_kronecker_multilinear",
    "kind": "claim",
    "sha256": "8a73f81902220cd224baa17d4506c7af2e9e7597bda2e6918da88a3b3c1d23c5",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_000_definition_kronecker_product"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_001_theorem_tensor_product_basis",
    "kind": "theorem",
    "sha256": "0b14d498919e0e510b2e50b975d3379db4e963cb1dc5583d6bb429c782a7fd31",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_000_definition_kronecker_product",
      "linear_space_general_000c_claim_kronecker_multilinear"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002_claim_scalar_identity_commutes",
    "kind": "claim",
    "sha256": "2c83d104299b4e654c7e818045ba213e543e08102fa8dab8be6c54e26b7d830f",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_047_claim_commutator_via_anticommutators",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of kroneckerBasisSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`クロネッカー積で作る行列と数ベクトルの基底の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("linear_space_general_002_claim_scalar_identity_commutes").dependencyPlacement!.chapterOrder
  !== kroneckerBasisSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("クロネッカー積で作る行列と数ベクトルの基底の直後の項目が変わりました");
}
const scalarIdentitySectionEntryIds = [
  "linear_space_general_002_claim_scalar_identity_commutes"
];
const scalarIdentitySection = validateReviewedSection(
  "単位行列のスカラー倍と可換性", "数学的道具立て", scalarIdentitySectionEntryIds,
  new Map([
  [
    "linear_space_general_002_claim_scalar_identity_commutes",
    []
  ]
]),
  new Map([
  [
    "linear_space_general_002_claim_scalar_identity_commutes",
    "2c83d104299b4e654c7e818045ba213e543e08102fa8dab8be6c54e26b7d830f"
  ]
]),
  [
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_025_claim_complex_numbers_form_a_field",
  "calculation_formulae_047_claim_commutator_via_anticommutators",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_003_matrix_decomposition",
    "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6"
  ],
  [
    "calculation_formulae_047_claim_commutator_via_anticommutators",
    "25d2f2a1ad5ab6bcbe05427a4ce4f06a4250ea5f7f3f79b5d7170303b8d4ebeb"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "linear_space_general_002_claim_scalar_identity_commutes"
],
);
const scalarIdentitySectionBoundarySnapshot = [
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_007_inclusion_rr_to_cc",
    "kind": "definition",
    "sha256": "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "kind": "claim",
    "sha256": "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_008_multiply_by_minus_one",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031_definition_abs_arg",
    "kind": "definition",
    "sha256": "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031b_claim_abs_basic_properties",
    "kind": "claim",
    "sha256": "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_047_claim_commutator_via_anticommutators",
    "kind": "claim",
    "sha256": "25d2f2a1ad5ab6bcbe05427a4ce4f06a4250ea5f7f3f79b5d7170303b8d4ebeb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002_claim_scalar_identity_commutes",
    "kind": "claim",
    "sha256": "2c83d104299b4e654c7e818045ba213e543e08102fa8dab8be6c54e26b7d830f",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_047_claim_commutator_via_anticommutators",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002b_definition_matrix_norm",
    "kind": "definition",
    "sha256": "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of scalarIdentitySectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`単位行列のスカラー倍と可換性の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("linear_space_general_002b_definition_matrix_norm").dependencyPlacement!.chapterOrder
  !== scalarIdentitySection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("単位行列のスカラー倍と可換性の直後の項目が変わりました");
}
const matrixNormDefinitionSectionEntryIds = [
  "linear_space_general_002b_definition_matrix_norm"
];
const matrixNormDefinitionSection = validateReviewedSection(
  "成分の平方和によるノルムと収束の定義", "数学的道具立て", matrixNormDefinitionSectionEntryIds,
  new Map([
  [
    "linear_space_general_002b_definition_matrix_norm",
    []
  ]
]),
  new Map([
  [
    "linear_space_general_002b_definition_matrix_norm",
    "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab"
  ]
]),
  [
  "calc_formulae_001_sqrt_nonnegative_real",
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_007_inclusion_rr_to_cc",
  "calculation_formulae_031_definition_abs_arg",
  "calculation_formulae_031b_claim_abs_basic_properties",
  "calculation_formulae_definition_set_and_algebra_notation"
],
  new Map([
  [
    "calc_formulae_001_sqrt_nonnegative_real",
    "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_007_inclusion_rr_to_cc",
    "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647"
  ],
  [
    "calculation_formulae_031_definition_abs_arg",
    "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb"
  ],
  [
    "calculation_formulae_031b_claim_abs_basic_properties",
    "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ]
]),
  [
  "linear_space_general_002b_definition_matrix_norm"
],
);
const matrixNormDefinitionSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_007_inclusion_rr_to_cc",
    "kind": "definition",
    "sha256": "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_031_definition_abs_arg",
    "kind": "definition",
    "sha256": "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031b_claim_abs_basic_properties",
    "kind": "claim",
    "sha256": "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "eigenvalues_of_V_001_definition_trace",
    "kind": "definition",
    "sha256": "35ae403d96746496fb0fdaa59d0122e38c3fc5129338230666507cb62c07a73d",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "eigenvalues_of_V_011_definition_hermitian_positive_definite",
    "kind": "definition",
    "sha256": "4b1f272661509c47420344ab38051e53285d0f666507a9a3a3333af52a4f6bf1",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_conjugation_definition_complex_conjugate_and_real_part"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_conjugation_proof_003_definition_M_n_C_convergence",
    "kind": "definition",
    "sha256": "05aec16792fec6de063b35504c90d6726cf31b5fc4509c42dab976305d55909d",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "eigenvalues_of_V_001_definition_trace",
      "eigenvalues_of_V_011_definition_hermitian_positive_definite",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002b_definition_matrix_norm",
    "kind": "definition",
    "sha256": "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of matrixNormDefinitionSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`成分の平方和によるノルムと収束の定義の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("exp_conjugation_proof_003_definition_M_n_C_convergence").dependencyPlacement!.chapterOrder
  !== matrixNormDefinitionSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("成分の平方和によるノルムと収束の定義の直後の項目が変わりました");
}
const matrixNormMovedStarSnapshot = [
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "kind": "claim",
    "sha256": "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_008_multiply_by_minus_one",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031b_claim_abs_basic_properties",
    "kind": "claim",
    "sha256": "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "eigenvalues_of_V_011_definition_hermitian_positive_definite",
    "kind": "definition",
    "sha256": "4b1f272661509c47420344ab38051e53285d0f666507a9a3a3333af52a4f6bf1",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_conjugation_definition_complex_conjugate_and_real_part"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "eigenvalues_of_V_012_claim_star_is_norm_preserving",
    "kind": "claim",
    "sha256": "34155cf8eb5b5d74228dd34a7b3bc563dba0d010dc8e96ab05d0bb4a1f03c3bd",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "eigenvalues_of_V_011_definition_hermitian_positive_definite",
      "exp_conjugation_definition_complex_conjugate_and_real_part",
      "exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_conjugation_definition_complex_conjugate_and_real_part",
    "kind": "definition",
    "sha256": "69fd82e2a5857d7844277a0dffbd61a33f0c61050aea4abeb87340c5e1fae879",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_010_definition_real_imag_parts_of_cc"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms",
    "kind": "claim",
    "sha256": "316edd2523302d9bc329c4ae657623b9228323b847df0312eacbec979fbb2b47",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_010_definition_real_imag_parts_of_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "eigenvalues_of_V_001_definition_trace",
      "eigenvalues_of_V_011_definition_hermitian_positive_definite",
      "exp_conjugation_definition_complex_conjugate_and_real_part",
      "exp_conjugation_proof_003_definition_M_n_C_convergence",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002b_definition_matrix_norm",
    "kind": "definition",
    "sha256": "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of matrixNormMovedStarSnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て" || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`ノルム定義の境界に伴う共役転置の移動比較が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("eigenvalues_of_V_012_claim_star_is_norm_preserving").dependencyPlacement!.chapterOrder
  <= findToolEntry("exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms").dependencyPlacement!.chapterOrder) {
  throw new Error("共役転置の性質が複素共役の入力証明より前へ戻りました");
}
const frobeniusDefinitionSectionEntryIds = [
  "exp_conjugation_proof_003_definition_M_n_C_convergence"
];
const frobeniusDefinitionSection = validateReviewedSection(
  "共役転置とトレースによる内積の定義", "数学的道具立て", frobeniusDefinitionSectionEntryIds,
  new Map([
  [
    "exp_conjugation_proof_003_definition_M_n_C_convergence",
    []
  ]
]),
  new Map([
  [
    "exp_conjugation_proof_003_definition_M_n_C_convergence",
    "05aec16792fec6de063b35504c90d6726cf31b5fc4509c42dab976305d55909d"
  ]
]),
  [
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "eigenvalues_of_V_001_definition_trace",
  "eigenvalues_of_V_011_definition_hermitian_positive_definite",
  "linear_space_general_002b_definition_matrix_norm"
],
  new Map([
  [
    "calc_formulae_003_matrix_decomposition",
    "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ],
  [
    "eigenvalues_of_V_001_definition_trace",
    "35ae403d96746496fb0fdaa59d0122e38c3fc5129338230666507cb62c07a73d"
  ],
  [
    "eigenvalues_of_V_011_definition_hermitian_positive_definite",
    "4b1f272661509c47420344ab38051e53285d0f666507a9a3a3333af52a4f6bf1"
  ],
  [
    "linear_space_general_002b_definition_matrix_norm",
    "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab"
  ]
]),
  [
  "exp_conjugation_proof_003_definition_M_n_C_convergence"
],
);
const frobeniusDefinitionSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "eigenvalues_of_V_001_definition_trace",
    "kind": "definition",
    "sha256": "35ae403d96746496fb0fdaa59d0122e38c3fc5129338230666507cb62c07a73d",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "eigenvalues_of_V_011_definition_hermitian_positive_definite",
    "kind": "definition",
    "sha256": "4b1f272661509c47420344ab38051e53285d0f666507a9a3a3333af52a4f6bf1",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_conjugation_definition_complex_conjugate_and_real_part"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_conjugation_proof_003_definition_M_n_C_convergence",
    "kind": "definition",
    "sha256": "05aec16792fec6de063b35504c90d6726cf31b5fc4509c42dab976305d55909d",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "eigenvalues_of_V_001_definition_trace",
      "eigenvalues_of_V_011_definition_hermitian_positive_definite",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_conjugation_proof_004_theorem_ad_binomial",
    "kind": "theorem",
    "sha256": "ba1875ca88bb10163d2a3ba85f2acb5e4a358169c00e6e2959ba76c666c34a1b",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix",
    "kind": "definition",
    "sha256": "8a6b649f4059d7c238cc45e58e70461badfb98bb871e4557cc5032dcc9ce601b",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_conjugation_proof_003_definition_M_n_C_convergence",
      "exp_conjugation_proof_004_theorem_ad_binomial"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002b_definition_matrix_norm",
    "kind": "definition",
    "sha256": "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of frobeniusDefinitionSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`共役転置とトレースによる内積の定義の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix").dependencyPlacement!.chapterOrder
  !== frobeniusDefinitionSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("共役転置とトレースによる内積の定義の直後の項目が変わりました");
}
const adMapsDefinitionSectionEntryIds = [
  "exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix"
];
const adMapsDefinitionSection = validateReviewedSection(
  "交換子と共役による複素行列上の写像", "数学的道具立て", adMapsDefinitionSectionEntryIds,
  new Map([
  [
    "exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix",
    []
  ]
]),
  new Map([
  [
    "exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix",
    "8a6b649f4059d7c238cc45e58e70461badfb98bb871e4557cc5032dcc9ce601b"
  ]
]),
  [
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_conjugation_proof_003_definition_M_n_C_convergence",
  "exp_conjugation_proof_004_theorem_ad_binomial"
],
  new Map([
  [
    "calc_formulae_003_matrix_decomposition",
    "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ],
  [
    "exp_conjugation_proof_003_definition_M_n_C_convergence",
    "05aec16792fec6de063b35504c90d6726cf31b5fc4509c42dab976305d55909d"
  ],
  [
    "exp_conjugation_proof_004_theorem_ad_binomial",
    "ba1875ca88bb10163d2a3ba85f2acb5e4a358169c00e6e2959ba76c666c34a1b"
  ]
]),
  [
  "exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix"
],
);
const adMapsDefinitionSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_007_inclusion_rr_to_cc",
    "kind": "definition",
    "sha256": "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_031_definition_abs_arg",
    "kind": "definition",
    "sha256": "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031b_claim_abs_basic_properties",
    "kind": "claim",
    "sha256": "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_conjugation_proof_003_definition_M_n_C_convergence",
    "kind": "definition",
    "sha256": "05aec16792fec6de063b35504c90d6726cf31b5fc4509c42dab976305d55909d",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "eigenvalues_of_V_001_definition_trace",
      "eigenvalues_of_V_011_definition_hermitian_positive_definite",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_conjugation_proof_004_theorem_ad_binomial",
    "kind": "theorem",
    "sha256": "ba1875ca88bb10163d2a3ba85f2acb5e4a358169c00e6e2959ba76c666c34a1b",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix",
    "kind": "definition",
    "sha256": "8a6b649f4059d7c238cc45e58e70461badfb98bb871e4557cc5032dcc9ce601b",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_conjugation_proof_003_definition_M_n_C_convergence",
      "exp_conjugation_proof_004_theorem_ad_binomial"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002b_definition_matrix_norm",
    "kind": "definition",
    "sha256": "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "kind": "claim",
    "sha256": "3cd28853c071460f14cbe4ac6e63a6a4e9db98e51a6a752f5cfc064d14f0e069",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of adMapsDefinitionSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`交換子と共役による複素行列上の写像の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("linear_space_general_002c_claim_matrix_norm_triangle_inequality").dependencyPlacement!.chapterOrder
  !== adMapsDefinitionSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("交換子と共役による複素行列上の写像の直後の項目が変わりました");
}
const normInnerStarSectionEntryIds = [
  "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
  "exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms",
  "eigenvalues_of_V_012_claim_star_is_norm_preserving"
];
const normInnerStarSection = validateReviewedSection(
  "ノルムと内積の性質および共役転置", "数学的道具立て", normInnerStarSectionEntryIds,
  new Map([
  [
    "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    []
  ],
  [
    "exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms",
    [
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ]
  ],
  [
    "eigenvalues_of_V_012_claim_star_is_norm_preserving",
    [
      "exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms"
    ]
  ]
]),
  new Map([
  [
    "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "3cd28853c071460f14cbe4ac6e63a6a4e9db98e51a6a752f5cfc064d14f0e069"
  ],
  [
    "exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms",
    "316edd2523302d9bc329c4ae657623b9228323b847df0312eacbec979fbb2b47"
  ],
  [
    "eigenvalues_of_V_012_claim_star_is_norm_preserving",
    "34155cf8eb5b5d74228dd34a7b3bc563dba0d010dc8e96ab05d0bb4a1f03c3bd"
  ]
]),
  [
  "calc_formulae_001_sqrt_nonnegative_real",
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_007_inclusion_rr_to_cc",
  "calc_formulae_010_definition_real_imag_parts_of_cc",
  "calculation_formulae_025_claim_complex_numbers_form_a_field",
  "calculation_formulae_031_definition_abs_arg",
  "calculation_formulae_031b_claim_abs_basic_properties",
  "calculation_formulae_definition_set_and_algebra_notation",
  "eigenvalues_of_V_001_definition_trace",
  "eigenvalues_of_V_011_definition_hermitian_positive_definite",
  "exp_conjugation_definition_complex_conjugate_and_real_part",
  "exp_conjugation_proof_003_definition_M_n_C_convergence",
  "linear_space_general_002b_definition_matrix_norm"
],
  new Map([
  [
    "calc_formulae_001_sqrt_nonnegative_real",
    "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"
  ],
  [
    "calc_formulae_003_matrix_decomposition",
    "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_007_inclusion_rr_to_cc",
    "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647"
  ],
  [
    "calc_formulae_010_definition_real_imag_parts_of_cc",
    "6e080bfb6c5694b115f4761c5d2db993b1d5c315a4e36f7389774cfd711a07bd"
  ],
  [
    "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6"
  ],
  [
    "calculation_formulae_031_definition_abs_arg",
    "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb"
  ],
  [
    "calculation_formulae_031b_claim_abs_basic_properties",
    "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ],
  [
    "eigenvalues_of_V_001_definition_trace",
    "35ae403d96746496fb0fdaa59d0122e38c3fc5129338230666507cb62c07a73d"
  ],
  [
    "eigenvalues_of_V_011_definition_hermitian_positive_definite",
    "4b1f272661509c47420344ab38051e53285d0f666507a9a3a3333af52a4f6bf1"
  ],
  [
    "exp_conjugation_definition_complex_conjugate_and_real_part",
    "69fd82e2a5857d7844277a0dffbd61a33f0c61050aea4abeb87340c5e1fae879"
  ],
  [
    "exp_conjugation_proof_003_definition_M_n_C_convergence",
    "05aec16792fec6de063b35504c90d6726cf31b5fc4509c42dab976305d55909d"
  ],
  [
    "linear_space_general_002b_definition_matrix_norm",
    "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab"
  ]
]),
  [
  "eigenvalues_of_V_012_claim_star_is_norm_preserving"
],
);
const normInnerStarSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_007_inclusion_rr_to_cc",
    "kind": "definition",
    "sha256": "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_010_definition_real_imag_parts_of_cc",
    "kind": "definition",
    "sha256": "6e080bfb6c5694b115f4761c5d2db993b1d5c315a4e36f7389774cfd711a07bd",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "kind": "claim",
    "sha256": "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_008_multiply_by_minus_one",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031_definition_abs_arg",
    "kind": "definition",
    "sha256": "fc64442d22789d6cb4f802c87699680414adc93241acb97a20a44eeb3490c2cb",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_017_definition_section_of_angle_representation",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031b_claim_abs_basic_properties",
    "kind": "claim",
    "sha256": "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "eigenvalues_of_V_001_definition_trace",
    "kind": "definition",
    "sha256": "35ae403d96746496fb0fdaa59d0122e38c3fc5129338230666507cb62c07a73d",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "eigenvalues_of_V_011_definition_hermitian_positive_definite",
    "kind": "definition",
    "sha256": "4b1f272661509c47420344ab38051e53285d0f666507a9a3a3333af52a4f6bf1",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_conjugation_definition_complex_conjugate_and_real_part"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "eigenvalues_of_V_012_claim_star_is_norm_preserving",
    "kind": "claim",
    "sha256": "34155cf8eb5b5d74228dd34a7b3bc563dba0d010dc8e96ab05d0bb4a1f03c3bd",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "eigenvalues_of_V_011_definition_hermitian_positive_definite",
      "exp_conjugation_definition_complex_conjugate_and_real_part",
      "exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_conjugation_definition_complex_conjugate_and_real_part",
    "kind": "definition",
    "sha256": "69fd82e2a5857d7844277a0dffbd61a33f0c61050aea4abeb87340c5e1fae879",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_010_definition_real_imag_parts_of_cc"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "exp_conjugation_proof_003_definition_M_n_C_convergence",
    "kind": "definition",
    "sha256": "05aec16792fec6de063b35504c90d6726cf31b5fc4509c42dab976305d55909d",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "eigenvalues_of_V_001_definition_trace",
      "eigenvalues_of_V_011_definition_hermitian_positive_definite",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms",
    "kind": "claim",
    "sha256": "316edd2523302d9bc329c4ae657623b9228323b847df0312eacbec979fbb2b47",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_010_definition_real_imag_parts_of_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "eigenvalues_of_V_001_definition_trace",
      "eigenvalues_of_V_011_definition_hermitian_positive_definite",
      "exp_conjugation_definition_complex_conjugate_and_real_part",
      "exp_conjugation_proof_003_definition_M_n_C_convergence",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002b_definition_matrix_norm",
    "kind": "definition",
    "sha256": "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "kind": "claim",
    "sha256": "3cd28853c071460f14cbe4ac6e63a6a4e9db98e51a6a752f5cfc064d14f0e069",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_003_claim_matrix_norm_submultiplicativity",
    "kind": "claim",
    "sha256": "b120c7834055676e534d67e01428c170782fb7db99651f9955bd5e2a6b16cde3",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of normInnerStarSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`ノルムと内積の性質および共役転置の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("linear_space_general_003_claim_matrix_norm_submultiplicativity").dependencyPlacement!.chapterOrder
  !== normInnerStarSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("ノルムと内積の性質および共役転置の直後の項目が変わりました");
}
const productNormContinuitySectionEntryIds = [
  "linear_space_general_003_claim_matrix_norm_submultiplicativity",
  "linear_space_general_003b_claim_matrix_multiplication_continuity"
];
const productNormContinuitySection = validateReviewedSection(
  "行列積のノルム評価と右からの乗算の連続性", "数学的道具立て", productNormContinuitySectionEntryIds,
  new Map([
  [
    "linear_space_general_003_claim_matrix_norm_submultiplicativity",
    []
  ],
  [
    "linear_space_general_003b_claim_matrix_multiplication_continuity",
    [
      "linear_space_general_003_claim_matrix_norm_submultiplicativity"
    ]
  ]
]),
  new Map([
  [
    "linear_space_general_003_claim_matrix_norm_submultiplicativity",
    "b120c7834055676e534d67e01428c170782fb7db99651f9955bd5e2a6b16cde3"
  ],
  [
    "linear_space_general_003b_claim_matrix_multiplication_continuity",
    "4997ade583c124391b81653b81abdc322ad7d13b46e84827b6e5814fc31a86f3"
  ]
]),
  [
  "calc_formulae_001_sqrt_nonnegative_real",
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "linear_space_general_002b_definition_matrix_norm",
  "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
],
  new Map([
  [
    "calc_formulae_001_sqrt_nonnegative_real",
    "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"
  ],
  [
    "calc_formulae_003_matrix_decomposition",
    "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ],
  [
    "linear_space_general_002b_definition_matrix_norm",
    "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab"
  ],
  [
    "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "3cd28853c071460f14cbe4ac6e63a6a4e9db98e51a6a752f5cfc064d14f0e069"
  ]
]),
  [
  "linear_space_general_003b_claim_matrix_multiplication_continuity"
],
);
const productNormContinuitySectionBoundarySnapshot = [
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002b_definition_matrix_norm",
    "kind": "definition",
    "sha256": "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "kind": "claim",
    "sha256": "3cd28853c071460f14cbe4ac6e63a6a4e9db98e51a6a752f5cfc064d14f0e069",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_003_claim_matrix_norm_submultiplicativity",
    "kind": "claim",
    "sha256": "b120c7834055676e534d67e01428c170782fb7db99651f9955bd5e2a6b16cde3",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_003b_claim_matrix_multiplication_continuity",
    "kind": "claim",
    "sha256": "4997ade583c124391b81653b81abdc322ad7d13b46e84827b6e5814fc31a86f3",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_003_claim_matrix_norm_submultiplicativity"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_003c_claim_matrix_norm_vector_bound",
    "kind": "claim",
    "sha256": "b8f654d8b634f423754816c6e90589c9dd709246dbe7d95f71382d041b05b11f",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
      "linear_space_general_003_claim_matrix_norm_submultiplicativity"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of productNormContinuitySectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`行列積のノルム評価と右からの乗算の連続性の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("linear_space_general_003c_claim_matrix_norm_vector_bound").dependencyPlacement!.chapterOrder
  !== productNormContinuitySection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("行列積のノルム評価と右からの乗算の連続性の直後の項目が変わりました");
}
const matrixVectorBoundSectionEntryIds = [
  "linear_space_general_003c_claim_matrix_norm_vector_bound"
];
const matrixVectorBoundSection = validateReviewedSection(
  "行列ノルムによる数ベクトルの評価", "数学的道具立て", matrixVectorBoundSectionEntryIds,
  new Map([
  [
    "linear_space_general_003c_claim_matrix_norm_vector_bound",
    []
  ]
]),
  new Map([
  [
    "linear_space_general_003c_claim_matrix_norm_vector_bound",
    "b8f654d8b634f423754816c6e90589c9dd709246dbe7d95f71382d041b05b11f"
  ]
]),
  [
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "linear_space_general_002b_definition_matrix_norm",
  "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
  "linear_space_general_003_claim_matrix_norm_submultiplicativity"
],
  new Map([
  [
    "calc_formulae_003_matrix_decomposition",
    "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ],
  [
    "linear_space_general_002b_definition_matrix_norm",
    "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab"
  ],
  [
    "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "3cd28853c071460f14cbe4ac6e63a6a4e9db98e51a6a752f5cfc064d14f0e069"
  ],
  [
    "linear_space_general_003_claim_matrix_norm_submultiplicativity",
    "b120c7834055676e534d67e01428c170782fb7db99651f9955bd5e2a6b16cde3"
  ]
]),
  [
  "linear_space_general_003c_claim_matrix_norm_vector_bound"
],
);
const matrixVectorBoundSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "kind": "claim",
    "sha256": "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_008_multiply_by_minus_one",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031b_claim_abs_basic_properties",
    "kind": "claim",
    "sha256": "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002b_definition_matrix_norm",
    "kind": "definition",
    "sha256": "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "kind": "claim",
    "sha256": "3cd28853c071460f14cbe4ac6e63a6a4e9db98e51a6a752f5cfc064d14f0e069",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_003_claim_matrix_norm_submultiplicativity",
    "kind": "claim",
    "sha256": "b120c7834055676e534d67e01428c170782fb7db99651f9955bd5e2a6b16cde3",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_003c_claim_matrix_norm_vector_bound",
    "kind": "claim",
    "sha256": "b8f654d8b634f423754816c6e90589c9dd709246dbe7d95f71382d041b05b11f",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
      "linear_space_general_003_claim_matrix_norm_submultiplicativity"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_003d_claim_matrix_completeness",
    "kind": "claim",
    "sha256": "dd073df5d0ec8186d0e924d507fd4c207333a4101bb562a89bdabf1b7029c102",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of matrixVectorBoundSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`行列ノルムによる数ベクトルの評価の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("linear_space_general_003d_claim_matrix_completeness").dependencyPlacement!.chapterOrder
  !== matrixVectorBoundSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("行列ノルムによる数ベクトルの評価の直後の項目が変わりました");
}
const completenessExpSeriesSectionEntryIds = [
  "linear_space_general_003d_claim_matrix_completeness",
  "exp_linear_map_000b_claim_matrix_exp_series_converges"
];
const completenessExpSeriesSection = validateReviewedSection(
  "行列級数の絶対収束と指数級数の収束", "数学的道具立て", completenessExpSeriesSectionEntryIds,
  new Map([
  [
    "linear_space_general_003d_claim_matrix_completeness",
    []
  ],
  [
    "exp_linear_map_000b_claim_matrix_exp_series_converges",
    [
      "linear_space_general_003d_claim_matrix_completeness"
    ]
  ]
]),
  new Map([
  [
    "linear_space_general_003d_claim_matrix_completeness",
    "dd073df5d0ec8186d0e924d507fd4c207333a4101bb562a89bdabf1b7029c102"
  ],
  [
    "exp_linear_map_000b_claim_matrix_exp_series_converges",
    "081de060bbad105f91c57433abbe6545518c96afee20f1e69f81167f6cb35325"
  ]
]),
  [
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_007_inclusion_rr_to_cc",
  "calculation_formulae_025_claim_complex_numbers_form_a_field",
  "calculation_formulae_031b_claim_abs_basic_properties",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_linear_map_000a_claim_real_exp_series_converges",
  "linear_space_general_002b_definition_matrix_norm",
  "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
  "linear_space_general_003_claim_matrix_norm_submultiplicativity"
],
  new Map([
  [
    "calc_formulae_003_matrix_decomposition",
    "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_007_inclusion_rr_to_cc",
    "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647"
  ],
  [
    "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6"
  ],
  [
    "calculation_formulae_031b_claim_abs_basic_properties",
    "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ],
  [
    "exp_linear_map_000a_claim_real_exp_series_converges",
    "1065e4f465b1b0b49eae7d16f9d734421f472beec053c3effaff63127eecf077"
  ],
  [
    "linear_space_general_002b_definition_matrix_norm",
    "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab"
  ],
  [
    "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "3cd28853c071460f14cbe4ac6e63a6a4e9db98e51a6a752f5cfc064d14f0e069"
  ],
  [
    "linear_space_general_003_claim_matrix_norm_submultiplicativity",
    "b120c7834055676e534d67e01428c170782fb7db99651f9955bd5e2a6b16cde3"
  ]
]),
  [
  "exp_linear_map_000b_claim_matrix_exp_series_converges"
],
);
const completenessExpSeriesSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_007_inclusion_rr_to_cc",
    "kind": "definition",
    "sha256": "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "kind": "claim",
    "sha256": "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_008_multiply_by_minus_one",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031b_claim_abs_basic_properties",
    "kind": "claim",
    "sha256": "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_000a_claim_real_exp_series_converges",
    "kind": "claim",
    "sha256": "1065e4f465b1b0b49eae7d16f9d734421f472beec053c3effaff63127eecf077",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_000b_claim_matrix_exp_series_converges",
    "kind": "claim",
    "sha256": "081de060bbad105f91c57433abbe6545518c96afee20f1e69f81167f6cb35325",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_linear_map_000a_claim_real_exp_series_converges",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
      "linear_space_general_003_claim_matrix_norm_submultiplicativity",
      "linear_space_general_003d_claim_matrix_completeness"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_001_theorem_exp_series_pointwise_converges",
    "kind": "theorem",
    "sha256": "7f8878116e4672d93d30e4babcccacab6bb2b8f8423348cbb9ba7e19d78af627",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_linear_map_000a_claim_real_exp_series_converges",
      "exp_linear_map_000b_claim_matrix_exp_series_converges",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
      "linear_space_general_003c_claim_matrix_norm_vector_bound",
      "linear_space_general_003d_claim_matrix_completeness"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002b_definition_matrix_norm",
    "kind": "definition",
    "sha256": "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "kind": "claim",
    "sha256": "3cd28853c071460f14cbe4ac6e63a6a4e9db98e51a6a752f5cfc064d14f0e069",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_003_claim_matrix_norm_submultiplicativity",
    "kind": "claim",
    "sha256": "b120c7834055676e534d67e01428c170782fb7db99651f9955bd5e2a6b16cde3",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_003c_claim_matrix_norm_vector_bound",
    "kind": "claim",
    "sha256": "b8f654d8b634f423754816c6e90589c9dd709246dbe7d95f71382d041b05b11f",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
      "linear_space_general_003_claim_matrix_norm_submultiplicativity"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_003d_claim_matrix_completeness",
    "kind": "claim",
    "sha256": "dd073df5d0ec8186d0e924d507fd4c207333a4101bb562a89bdabf1b7029c102",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of completenessExpSeriesSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`行列級数の絶対収束と指数級数の収束の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("exp_linear_map_001_theorem_exp_series_pointwise_converges").dependencyPlacement!.chapterOrder
  !== completenessExpSeriesSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("行列級数の絶対収束と指数級数の収束の直後の項目が変わりました");
}
const pointwiseExponentialSectionEntryIds = [
  "exp_linear_map_001_theorem_exp_series_pointwise_converges"
];
const pointwiseExponentialSection = validateReviewedSection(
  "指数級数の数ベクトル作用と線型写像の各点収束", "数学的道具立て", pointwiseExponentialSectionEntryIds,
  new Map([
  [
    "exp_linear_map_001_theorem_exp_series_pointwise_converges",
    []
  ]
]),
  new Map([
  [
    "exp_linear_map_001_theorem_exp_series_pointwise_converges",
    "7f8878116e4672d93d30e4babcccacab6bb2b8f8423348cbb9ba7e19d78af627"
  ]
]),
  [
  "calc_formulae_001_sqrt_nonnegative_real",
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_007_inclusion_rr_to_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_linear_map_000a_claim_real_exp_series_converges",
  "exp_linear_map_000b_claim_matrix_exp_series_converges",
  "linear_space_general_002b_definition_matrix_norm",
  "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
  "linear_space_general_003c_claim_matrix_norm_vector_bound",
  "linear_space_general_003d_claim_matrix_completeness"
],
  new Map([
  [
    "calc_formulae_001_sqrt_nonnegative_real",
    "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"
  ],
  [
    "calc_formulae_003_matrix_decomposition",
    "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_007_inclusion_rr_to_cc",
    "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ],
  [
    "exp_linear_map_000a_claim_real_exp_series_converges",
    "1065e4f465b1b0b49eae7d16f9d734421f472beec053c3effaff63127eecf077"
  ],
  [
    "exp_linear_map_000b_claim_matrix_exp_series_converges",
    "081de060bbad105f91c57433abbe6545518c96afee20f1e69f81167f6cb35325"
  ],
  [
    "linear_space_general_002b_definition_matrix_norm",
    "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab"
  ],
  [
    "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "3cd28853c071460f14cbe4ac6e63a6a4e9db98e51a6a752f5cfc064d14f0e069"
  ],
  [
    "linear_space_general_003c_claim_matrix_norm_vector_bound",
    "b8f654d8b634f423754816c6e90589c9dd709246dbe7d95f71382d041b05b11f"
  ],
  [
    "linear_space_general_003d_claim_matrix_completeness",
    "dd073df5d0ec8186d0e924d507fd4c207333a4101bb562a89bdabf1b7029c102"
  ]
]),
  [
  "exp_linear_map_001_theorem_exp_series_pointwise_converges"
],
);
const pointwiseExponentialSectionBoundarySnapshot = [
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_007_inclusion_rr_to_cc",
    "kind": "definition",
    "sha256": "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_000a_claim_real_exp_series_converges",
    "kind": "claim",
    "sha256": "1065e4f465b1b0b49eae7d16f9d734421f472beec053c3effaff63127eecf077",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_000b_claim_matrix_exp_series_converges",
    "kind": "claim",
    "sha256": "081de060bbad105f91c57433abbe6545518c96afee20f1e69f81167f6cb35325",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_linear_map_000a_claim_real_exp_series_converges",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
      "linear_space_general_003_claim_matrix_norm_submultiplicativity",
      "linear_space_general_003d_claim_matrix_completeness"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_001_theorem_exp_series_pointwise_converges",
    "kind": "theorem",
    "sha256": "7f8878116e4672d93d30e4babcccacab6bb2b8f8423348cbb9ba7e19d78af627",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_linear_map_000a_claim_real_exp_series_converges",
      "exp_linear_map_000b_claim_matrix_exp_series_converges",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
      "linear_space_general_003c_claim_matrix_norm_vector_bound",
      "linear_space_general_003d_claim_matrix_completeness"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_002_definition_exp_of_endomorphism",
    "kind": "definition",
    "sha256": "1b90c006155b2b723ad7169ab806c4fff82870687ce2865a7bc677a875134fa2",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_linear_map_000b_claim_matrix_exp_series_converges",
      "exp_linear_map_001_theorem_exp_series_pointwise_converges",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002b_definition_matrix_norm",
    "kind": "definition",
    "sha256": "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "kind": "claim",
    "sha256": "3cd28853c071460f14cbe4ac6e63a6a4e9db98e51a6a752f5cfc064d14f0e069",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_003c_claim_matrix_norm_vector_bound",
    "kind": "claim",
    "sha256": "b8f654d8b634f423754816c6e90589c9dd709246dbe7d95f71382d041b05b11f",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
      "linear_space_general_003_claim_matrix_norm_submultiplicativity"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_003d_claim_matrix_completeness",
    "kind": "claim",
    "sha256": "dd073df5d0ec8186d0e924d507fd4c207333a4101bb562a89bdabf1b7029c102",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of pointwiseExponentialSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`指数級数の数ベクトル作用と線型写像の各点収束の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("exp_linear_map_002_definition_exp_of_endomorphism").dependencyPlacement!.chapterOrder
  !== pointwiseExponentialSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("指数級数の数ベクトル作用と線型写像の各点収束の直後の項目が変わりました");
}
const pointwiseMovedPositiveSnapshot = [
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_007_inclusion_rr_to_cc",
    "kind": "definition",
    "sha256": "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "kind": "claim",
    "sha256": "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_008_multiply_by_minus_one",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_031b_claim_abs_basic_properties",
    "kind": "claim",
    "sha256": "b4e198549ba1d7b1452fe4650837a325244f089149b147b0e8f802a72731588e",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_019_definition_polar_equivalence_class",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_027_definition_phi_polar",
      "calculation_formulae_030_definition_first_and_second_projections",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "eigenvalues_of_V_001_definition_trace",
    "kind": "definition",
    "sha256": "35ae403d96746496fb0fdaa59d0122e38c3fc5129338230666507cb62c07a73d",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "eigenvalues_of_V_011_definition_hermitian_positive_definite",
    "kind": "definition",
    "sha256": "4b1f272661509c47420344ab38051e53285d0f666507a9a3a3333af52a4f6bf1",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_conjugation_definition_complex_conjugate_and_real_part"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "eigenvalues_of_V_012_claim_star_is_norm_preserving",
    "kind": "claim",
    "sha256": "34155cf8eb5b5d74228dd34a7b3bc563dba0d010dc8e96ab05d0bb4a1f03c3bd",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "eigenvalues_of_V_011_definition_hermitian_positive_definite",
      "exp_conjugation_definition_complex_conjugate_and_real_part",
      "exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "eigenvalues_of_V_013_claim_exp_hermitian_positive_definite",
    "kind": "claim",
    "sha256": "73fdb5d24c8cec6a1c637fedee45e0040ef03c5d8e7c13449cc4d8c80bc5f324",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "eigenvalues_of_V_001_definition_trace",
      "eigenvalues_of_V_011_definition_hermitian_positive_definite",
      "eigenvalues_of_V_012_claim_star_is_norm_preserving",
      "exp_conjugation_definition_complex_conjugate_and_real_part",
      "exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms",
      "exp_linear_map_001_theorem_exp_series_pointwise_converges",
      "exp_linear_map_002_definition_exp_of_endomorphism",
      "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
      "exp_linear_map_004_theorem_exp_zero_is_identity",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_conjugation_definition_complex_conjugate_and_real_part",
    "kind": "definition",
    "sha256": "69fd82e2a5857d7844277a0dffbd61a33f0c61050aea4abeb87340c5e1fae879",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_010_definition_real_imag_parts_of_cc"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms",
    "kind": "claim",
    "sha256": "316edd2523302d9bc329c4ae657623b9228323b847df0312eacbec979fbb2b47",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_010_definition_real_imag_parts_of_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "eigenvalues_of_V_001_definition_trace",
      "eigenvalues_of_V_011_definition_hermitian_positive_definite",
      "exp_conjugation_definition_complex_conjugate_and_real_part",
      "exp_conjugation_proof_003_definition_M_n_C_convergence",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_001_theorem_exp_series_pointwise_converges",
    "kind": "theorem",
    "sha256": "7f8878116e4672d93d30e4babcccacab6bb2b8f8423348cbb9ba7e19d78af627",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_linear_map_000a_claim_real_exp_series_converges",
      "exp_linear_map_000b_claim_matrix_exp_series_converges",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
      "linear_space_general_003c_claim_matrix_norm_vector_bound",
      "linear_space_general_003d_claim_matrix_completeness"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_002_definition_exp_of_endomorphism",
    "kind": "definition",
    "sha256": "1b90c006155b2b723ad7169ab806c4fff82870687ce2865a7bc677a875134fa2",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_linear_map_000b_claim_matrix_exp_series_converges",
      "exp_linear_map_001_theorem_exp_series_pointwise_converges",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
    "kind": "theorem",
    "sha256": "5310027658533830ac1844d325362a6a451df8aad4bd746c7685d92802af5f24",
    "dependencies": [
  "calc_formulae_001_sqrt_nonnegative_real",
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_007_inclusion_rr_to_cc",
  "calculation_formulae_025_claim_complex_numbers_form_a_field",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_conjugation_proof_004_theorem_ad_binomial",
  "exp_linear_map_000a_claim_real_exp_series_converges",
  "exp_linear_map_000b_claim_matrix_exp_series_converges",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "linear_space_general_002b_definition_matrix_norm",
  "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
  "linear_space_general_003_claim_matrix_norm_submultiplicativity"
],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_004_theorem_exp_zero_is_identity",
    "kind": "theorem",
    "sha256": "bb23ba43e403ab11c2c6a41e4356f0228a5880e37b0e2fe4df9a62289696fd53",
    "dependencies": [
      "exp_linear_map_002_definition_exp_of_endomorphism"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002b_definition_matrix_norm",
    "kind": "definition",
    "sha256": "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "kind": "claim",
    "sha256": "3cd28853c071460f14cbe4ac6e63a6a4e9db98e51a6a752f5cfc064d14f0e069",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of pointwiseMovedPositiveSnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`各点収束の後から移した正定値性の比較入力が変わりました: ${expected.id}`);
  }
}
for (const id of ["exp_linear_map_002_definition_exp_of_endomorphism", "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices", "exp_linear_map_004_theorem_exp_zero_is_identity"]) {
  if (findToolEntry("eigenvalues_of_V_013_claim_exp_hermitian_positive_definite").dependencyPlacement!.chapterOrder <= findToolEntry(id).dependencyPlacement!.chapterOrder) {
    throw new Error("正定値性が指数の定義・積公式・零行列の指数より前へ移りました");
  }
}
const exponentialDefinitionSectionEntryIds = [
  "exp_linear_map_002_definition_exp_of_endomorphism"
];
const exponentialDefinitionSection = validateReviewedSection(
  "行列と行列への線型写像の指数の定義", "数学的道具立て", exponentialDefinitionSectionEntryIds,
  new Map([
  [
    "exp_linear_map_002_definition_exp_of_endomorphism",
    []
  ]
]),
  new Map([
  [
    "exp_linear_map_002_definition_exp_of_endomorphism",
    "1b90c006155b2b723ad7169ab806c4fff82870687ce2865a7bc677a875134fa2"
  ]
]),
  [
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_007_inclusion_rr_to_cc",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_linear_map_000b_claim_matrix_exp_series_converges",
  "exp_linear_map_001_theorem_exp_series_pointwise_converges",
  "linear_space_general_002b_definition_matrix_norm",
  "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
],
  new Map([
  [
    "calc_formulae_003_matrix_decomposition",
    "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_007_inclusion_rr_to_cc",
    "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ],
  [
    "exp_linear_map_000b_claim_matrix_exp_series_converges",
    "081de060bbad105f91c57433abbe6545518c96afee20f1e69f81167f6cb35325"
  ],
  [
    "exp_linear_map_001_theorem_exp_series_pointwise_converges",
    "7f8878116e4672d93d30e4babcccacab6bb2b8f8423348cbb9ba7e19d78af627"
  ],
  [
    "linear_space_general_002b_definition_matrix_norm",
    "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab"
  ],
  [
    "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "3cd28853c071460f14cbe4ac6e63a6a4e9db98e51a6a752f5cfc064d14f0e069"
  ]
]),
  [
  "exp_linear_map_002_definition_exp_of_endomorphism"
],
);
const exponentialDefinitionSectionBoundarySnapshot = [
  {
    "id": "bridge_003_claim_exp_of_diagonal",
    "kind": "claim",
    "sha256": "e088de3055a90fec15c19ec4b9241df47aa9f15313c517efbb9946462b5ed8b4",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_linear_map_000a_claim_real_exp_series_converges",
      "exp_linear_map_001_theorem_exp_series_pointwise_converges",
      "exp_linear_map_002_definition_exp_of_endomorphism",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_007_inclusion_rr_to_cc",
    "kind": "definition",
    "sha256": "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "kind": "claim",
    "sha256": "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_008_multiply_by_minus_one",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_000a_claim_real_exp_series_converges",
    "kind": "claim",
    "sha256": "1065e4f465b1b0b49eae7d16f9d734421f472beec053c3effaff63127eecf077",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_000b_claim_matrix_exp_series_converges",
    "kind": "claim",
    "sha256": "081de060bbad105f91c57433abbe6545518c96afee20f1e69f81167f6cb35325",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_linear_map_000a_claim_real_exp_series_converges",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
      "linear_space_general_003_claim_matrix_norm_submultiplicativity",
      "linear_space_general_003d_claim_matrix_completeness"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_001_theorem_exp_series_pointwise_converges",
    "kind": "theorem",
    "sha256": "7f8878116e4672d93d30e4babcccacab6bb2b8f8423348cbb9ba7e19d78af627",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_linear_map_000a_claim_real_exp_series_converges",
      "exp_linear_map_000b_claim_matrix_exp_series_converges",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
      "linear_space_general_003c_claim_matrix_norm_vector_bound",
      "linear_space_general_003d_claim_matrix_completeness"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_002_definition_exp_of_endomorphism",
    "kind": "definition",
    "sha256": "1b90c006155b2b723ad7169ab806c4fff82870687ce2865a7bc677a875134fa2",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_linear_map_000b_claim_matrix_exp_series_converges",
      "exp_linear_map_001_theorem_exp_series_pointwise_converges",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002b_definition_matrix_norm",
    "kind": "definition",
    "sha256": "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "kind": "claim",
    "sha256": "3cd28853c071460f14cbe4ac6e63a6a4e9db98e51a6a752f5cfc064d14f0e069",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of exponentialDefinitionSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`行列と行列への線型写像の指数の定義の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("bridge_003_claim_exp_of_diagonal").dependencyPlacement!.chapterOrder
  !== exponentialDefinitionSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("行列と行列への線型写像の指数の定義の直後の項目が変わりました");
}
const diagonalExponentialSectionEntryIds = [
  "bridge_003_claim_exp_of_diagonal"
];
const diagonalExponentialSection = validateReviewedSection(
  "対角行列の指数の成分表示", "数学的道具立て", diagonalExponentialSectionEntryIds,
  new Map([
  [
    "bridge_003_claim_exp_of_diagonal",
    []
  ]
]),
  new Map([
  [
    "bridge_003_claim_exp_of_diagonal",
    "e088de3055a90fec15c19ec4b9241df47aa9f15313c517efbb9946462b5ed8b4"
  ]
]),
  [
  "calc_formulae_001_sqrt_nonnegative_real",
  "calc_formulae_003_matrix_decomposition",
  "calc_formulae_006_definition_of_cc",
  "calc_formulae_007_inclusion_rr_to_cc",
  "calculation_formulae_025_claim_complex_numbers_form_a_field",
  "calculation_formulae_definition_set_and_algebra_notation",
  "exp_linear_map_000a_claim_real_exp_series_converges",
  "exp_linear_map_001_theorem_exp_series_pointwise_converges",
  "exp_linear_map_002_definition_exp_of_endomorphism",
  "linear_space_general_002b_definition_matrix_norm"
],
  new Map([
  [
    "calc_formulae_001_sqrt_nonnegative_real",
    "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d"
  ],
  [
    "calc_formulae_003_matrix_decomposition",
    "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee"
  ],
  [
    "calc_formulae_006_definition_of_cc",
    "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c"
  ],
  [
    "calc_formulae_007_inclusion_rr_to_cc",
    "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647"
  ],
  [
    "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6"
  ],
  [
    "calculation_formulae_definition_set_and_algebra_notation",
    "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b"
  ],
  [
    "exp_linear_map_000a_claim_real_exp_series_converges",
    "1065e4f465b1b0b49eae7d16f9d734421f472beec053c3effaff63127eecf077"
  ],
  [
    "exp_linear_map_001_theorem_exp_series_pointwise_converges",
    "7f8878116e4672d93d30e4babcccacab6bb2b8f8423348cbb9ba7e19d78af627"
  ],
  [
    "exp_linear_map_002_definition_exp_of_endomorphism",
    "1b90c006155b2b723ad7169ab806c4fff82870687ce2865a7bc677a875134fa2"
  ],
  [
    "linear_space_general_002b_definition_matrix_norm",
    "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab"
  ]
]),
  [
  "bridge_003_claim_exp_of_diagonal"
],
);
const diagonalExponentialSectionBoundarySnapshot = [
  {
    "id": "bridge_003_claim_exp_of_diagonal",
    "kind": "claim",
    "sha256": "e088de3055a90fec15c19ec4b9241df47aa9f15313c517efbb9946462b5ed8b4",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_linear_map_000a_claim_real_exp_series_converges",
      "exp_linear_map_001_theorem_exp_series_pointwise_converges",
      "exp_linear_map_002_definition_exp_of_endomorphism",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_001_sqrt_nonnegative_real",
    "kind": "definition",
    "sha256": "9b28cccf76a246982dba0b0523ed6abd9dfeba10b9cdb2c1336bf7d5588a739d",
    "dependencies": [
      "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calc_formulae_003_matrix_decomposition",
    "kind": "definition",
    "sha256": "b1ce816719f5fbd4b3a16dfc9d7b7fecba7bb375757b6e0658e70060bff2e8ee",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_006_definition_of_cc",
    "kind": "definition",
    "sha256": "87fdc15b6c4d6e66553807fd125e27f26ba92b303a21f813ad9b0a10eefaa40c",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calc_formulae_007_inclusion_rr_to_cc",
    "kind": "definition",
    "sha256": "fe186e23ab9f4d50ef611f752373da5bb2e5d249e8020c0b0014e9e87c8e1647",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "自動検査で主題に適合"
  },
  {
    "id": "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "kind": "claim",
    "sha256": "c31e56b9b88aba827b1debe699a718a947f1af536759680e5e08612e9dd17ce6",
    "dependencies": [
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calc_formulae_008_multiply_by_minus_one",
      "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "calculation_formulae_definition_set_and_algebra_notation",
    "kind": "definition",
    "sha256": "ff5e922f6e64e0572521aeb4c979b81a1b666137620ce9a66cdad955b81daa9b",
    "dependencies": [],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_conjugation_proof_004_theorem_ad_binomial",
    "kind": "theorem",
    "sha256": "ba1875ca88bb10163d2a3ba85f2acb5e4a358169c00e6e2959ba76c666c34a1b",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_000a_claim_real_exp_series_converges",
    "kind": "claim",
    "sha256": "1065e4f465b1b0b49eae7d16f9d734421f472beec053c3effaff63127eecf077",
    "dependencies": [
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_000b_claim_matrix_exp_series_converges",
    "kind": "claim",
    "sha256": "081de060bbad105f91c57433abbe6545518c96afee20f1e69f81167f6cb35325",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_linear_map_000a_claim_real_exp_series_converges",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
      "linear_space_general_003_claim_matrix_norm_submultiplicativity",
      "linear_space_general_003d_claim_matrix_completeness"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_001_theorem_exp_series_pointwise_converges",
    "kind": "theorem",
    "sha256": "7f8878116e4672d93d30e4babcccacab6bb2b8f8423348cbb9ba7e19d78af627",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_linear_map_000a_claim_real_exp_series_converges",
      "exp_linear_map_000b_claim_matrix_exp_series_converges",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
      "linear_space_general_003c_claim_matrix_norm_vector_bound",
      "linear_space_general_003d_claim_matrix_completeness"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_002_definition_exp_of_endomorphism",
    "kind": "definition",
    "sha256": "1b90c006155b2b723ad7169ab806c4fff82870687ce2865a7bc677a875134fa2",
    "dependencies": [
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_linear_map_000b_claim_matrix_exp_series_converges",
      "exp_linear_map_001_theorem_exp_series_pointwise_converges",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
    "kind": "theorem",
    "sha256": "5310027658533830ac1844d325362a6a451df8aad4bd746c7685d92802af5f24",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_025_claim_complex_numbers_form_a_field",
      "calculation_formulae_definition_set_and_algebra_notation",
      "exp_conjugation_proof_004_theorem_ad_binomial",
      "exp_linear_map_000a_claim_real_exp_series_converges",
      "exp_linear_map_000b_claim_matrix_exp_series_converges",
      "exp_linear_map_002_definition_exp_of_endomorphism",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
      "linear_space_general_003_claim_matrix_norm_submultiplicativity"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002b_definition_matrix_norm",
    "kind": "definition",
    "sha256": "c1a48a3eadb1f66ad0d756ebed2e36b33f8321f56c93174c02889052a18d2bab",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "kind": "claim",
    "sha256": "3cd28853c071460f14cbe4ac6e63a6a4e9db98e51a6a752f5cfc064d14f0e069",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_006_definition_of_cc",
      "calc_formulae_007_inclusion_rr_to_cc",
      "calculation_formulae_031_definition_abs_arg",
      "calculation_formulae_031b_claim_abs_basic_properties",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  },
  {
    "id": "linear_space_general_003_claim_matrix_norm_submultiplicativity",
    "kind": "claim",
    "sha256": "b120c7834055676e534d67e01428c170782fb7db99651f9955bd5e2a6b16cde3",
    "dependencies": [
      "calc_formulae_001_sqrt_nonnegative_real",
      "calc_formulae_003_matrix_decomposition",
      "calc_formulae_006_definition_of_cc",
      "calculation_formulae_definition_set_and_algebra_notation",
      "linear_space_general_002b_definition_matrix_norm",
      "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
    ],
    "granularity": "具体的な行列計算への展開またはブロック分割を要する"
  }
];
for (const expected of diagonalExponentialSectionBoundarySnapshot) {
  const entry = findToolEntry(expected.id);
  if (entry.provisionalFinalChapter !== "数学的道具立て"
    || entry.kind !== expected.kind
    || entry.explanationGranularityReview.inspectedContentSha256 !== expected.sha256
    || entry.explanationGranularityReview.status !== expected.granularity
    || JSON.stringify(entry.dependsOnEntryIds) !== JSON.stringify(expected.dependencies)) {
    throw new Error(`対角行列の指数の成分表示の境界比較対象が変わりました: ${expected.id}`);
  }
}
if (findToolEntry("exp_linear_map_003_theorem_exp_product_formula_commuting_matrices").dependencyPlacement!.chapterOrder
  !== diagonalExponentialSection.sectionEntries.at(-1)!.dependencyPlacement!.chapterOrder + 1) {
  throw new Error("対角行列の指数の成分表示の直後の項目が変わりました");
}
const mathematicalToolSectionBoundaries = [{
  "name": "対角行列の指数の成分表示",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "bridge_003_claim_exp_of_diagonal"
  ],
  "input": [
    "行列指数の定義と各点・成分収束、行列ノルム",
    "行列積・複素演算・実数包含・非負平方根・集合記号",
    "非負実数の指数級数（複素成分への接続は未完）"
  ],
  "output": [
    "対角行列の指数が対角行列となる成分計算",
    "対角成分を複素指数で表示する主張（複素指数の定義と収束への接続は未完）"
  ],
  "mainTheorem": "対角行列の指数の対角成分と非対角成分の表示",
  "mainTheoremEntryId": "bridge_003_claim_exp_of_diagonal",
  "boundaryEvidence": "対角行列の冪から部分和・成分極限へ進む一項として配置する。直後の可換指数積は対角成分の表示を使わず、一般の可換行列に対する二項展開と有限添字集合の比較、ノルムの劣乗法性と剰余評価を追加する別枝である。未完の複素指数への接続を補った後に閉包を再判定する条件で、現存項目の境界を定める。対象・比較と全直接入力の本文・全依存・種別・粒度・相対順をプログラミングによる検証で固定する。",
  "readabilityStatus": "LLMによる検証で対象・全直接入力・可換指数積の全本文を読んだ。対象は非負実数の級数定理を任意の複素成分へ適用できず、複素指数の定義と収束への接続が未完である。零の部分和成分と差の絶対値の極限の説明、成分冪と有限和の帰納、同時適用と各行参照の分割も未解決である。比較側は参照先に実在する二項係数とPascalの計算の補題分離、添字全単射・有限和・二箇所の同時適用、実数の極限法則と行列演算への接続が未整備である。零成分・零次と比較側の空の添字範囲を保持し、定義・前提の補完と分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_001_sqrt_nonnegative_real",
    "calc_formulae_003_matrix_decomposition",
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_007_inclusion_rr_to_cc",
    "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "calculation_formulae_definition_set_and_algebra_notation",
    "exp_linear_map_000a_claim_real_exp_series_converges",
    "exp_linear_map_001_theorem_exp_series_pointwise_converges",
    "exp_linear_map_002_definition_exp_of_endomorphism",
    "linear_space_general_002b_definition_matrix_norm"
  ]
}, {
  "name": "行列と行列への線型写像の指数の定義",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "exp_linear_map_002_definition_exp_of_endomorphism"
  ],
  "input": [
    "行列指数級数と線型写像の各点収束、ノルムと極限の一意性",
    "行列積、複素数と実数係数の包含、集合記号"
  ],
  "output": [
    "行列の冪と指数写像",
    "行列への線型写像の反復と指数写像"
  ],
  "mainTheorem": "収束と一意性を使う二種類の指数写像の定義",
  "mainTheoremEntryId": "exp_linear_map_002_definition_exp_of_endomorphism",
  "boundaryEvidence": "既存の収束・一意性を受けて行列と線型写像の指数を定める一項で閉じる。直後の対角行列は行列指数だけを使い、線型写像の反復を使わず、対角成分の冪と複素数の指数への接続を追加する計算である。定義から特定の行列の成分計算への境界として、対象と全直接入力、比較項と全直接入力の本文・全依存・種別・粒度・相対順をプログラミングによる検証で固定する。",
  "readabilityStatus": "LLMによる検証で対象と全直接入力、対角行列の全本文を読んだ。冪と反復、二種類の指数の定義の分割、実行列と複素行列の演算接続、収束証明より後にある冪の再帰の提示順が未解決である。比較側は非負実数だけの級数定理を複素成分へ適用しており、複素数の指数の定義と収束への接続が未完である。非対角の部分和が零であることと差の絶対値の極限の説明、成分冪と有限線型結合の帰納、平方比較と各行参照も未解決に記録する。零の引数と零次を保ち、定義・前提の補完と分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_003_matrix_decomposition",
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_007_inclusion_rr_to_cc",
    "calculation_formulae_definition_set_and_algebra_notation",
    "exp_linear_map_000b_claim_matrix_exp_series_converges",
    "exp_linear_map_001_theorem_exp_series_pointwise_converges",
    "linear_space_general_002b_definition_matrix_norm",
    "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
  ]
}, {
  "name": "指数級数の数ベクトル作用と線型写像の各点収束",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "exp_linear_map_001_theorem_exp_series_pointwise_converges"
  ],
  "input": [
    "行列級数の収束・絶対収束判定、ノルムと数ベクトル作用の評価",
    "行列積・複素数の演算、実数包含、非負平方根と集合記号"
  ],
  "output": [
    "行列指数級数の数ベクトル作用と成分の収束",
    "行列単位による線型写像の評価、反復級数の各点収束と極限写像の線型性"
  ],
  "mainTheorem": "行列への線型写像の反復級数の各点収束と極限写像の線型性",
  "mainTheoremEntryId": "exp_linear_map_001_theorem_exp_series_pointwise_converges",
  "boundaryEvidence": "行列単位による上界から反復級数の各点収束を得て極限の線型性までで閉じる。後続はこの収束と一意性を受け取って、行列と線型写像それぞれの指数を定義する。存在と線型性を示す主張からそれを使う写像定義への境界である。旧直後のエルミート指数の正定値性は、実際に適用する指数定義・可換指数積・零行列指数の参照を補い、それらの後へ移す。移動項と全直接入力は比較専用で固定し、本節の外部入力へ混ぜない。対象・直接入力・直後の定義と移動項の本文・全依存・種別・粒度・相対順をプログラミングによる検証で固定する。",
  "readabilityStatus": "LLMによる検証で各点収束の全本文・全直接入力、後続の指数定義と移動する正定値性の本文を読んだ。六群の主張と行列単位・反復・上界の定義の分割、有限和の線型性の帰納と添字写像の全単射、実数の収束前提と各行参照が未解決である。行列冪の再帰は後続定義に存在するが先行証明への提示順が未整備である。比較側の指数定義の分割と実行列の演算接続、移動項の矩形共役転置・両側逆元と非零性・正の実数包含の根拠と四主張の分割も未解決に記録した。零次の反復と零の上界を保持し、前提補完と分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_001_sqrt_nonnegative_real",
    "calc_formulae_003_matrix_decomposition",
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_007_inclusion_rr_to_cc",
    "calculation_formulae_definition_set_and_algebra_notation",
    "exp_linear_map_000a_claim_real_exp_series_converges",
    "exp_linear_map_000b_claim_matrix_exp_series_converges",
    "linear_space_general_002b_definition_matrix_norm",
    "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "linear_space_general_003c_claim_matrix_norm_vector_bound",
    "linear_space_general_003d_claim_matrix_completeness"
  ]
}, {
  "name": "行列級数の絶対収束と指数級数の収束",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "linear_space_general_003d_claim_matrix_completeness",
    "exp_linear_map_000b_claim_matrix_exp_series_converges"
  ],
  "input": [
    "行列のノルムと基本性質、行列積の劣乗法性",
    "複素数の演算と絶対値、実数から複素数への包含、集合記号",
    "非負実数の指数級数の上界と実数のCauchy完備性・極限法則の前提"
  ],
  "output": [
    "行列のCauchy列の収束と行列級数の絶対収束判定・ノルム評価",
    "行列の指数級数のノルム収束と部分和・極限の共通上界"
  ],
  "mainTheorem": "行列の指数級数のノルム収束",
  "mainTheoremEntryId": "exp_linear_map_000b_claim_matrix_exp_series_converges",
  "boundaryEvidence": "成分のCauchy列から行列の極限を作り絶対収束判定を得た前項を、行列の冪と非負実数の指数級数で評価する末尾が使う二項の依存鎖で閉じる。直後の各点収束は末尾の行列級数を受け取るが、数ベクトルへの作用の評価を追加し、さらに行列空間上の線型写像を行列単位で展開してその反復級数を扱う。行列級数の存在と上界から作用および線型写像の級数への入力切替を根拠とし、プログラミングによる検証で対象・比較と全直接入力の本文・種別・粒度・依存・相対順を固定する。",
  "readabilityStatus": "LLMによる検証で対象二項・全直接入力と後続各点収束の全本文を読んだ。Cauchy列・部分和・上界の定義と各主張の分割、実数のCauchy完備性・上限と単調列収束・極限法則の前提、添字の場合分けと有限回の不等式の帰納が未解決である。行列の冪の再帰は後続の指数定義内に存在するため、収束証明の前へ分離する必要がある。比較側は行列単位・線型写像と反復・上界の定義と六群の主張の分割、有限和の線型性、添字写像の全単射の根拠、同時適用と各行参照が未解決である。零の引数と零次の項を保持し、前提補完と分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_003_matrix_decomposition",
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_007_inclusion_rr_to_cc",
    "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "calculation_formulae_031b_claim_abs_basic_properties",
    "calculation_formulae_definition_set_and_algebra_notation",
    "exp_linear_map_000a_claim_real_exp_series_converges",
    "linear_space_general_002b_definition_matrix_norm",
    "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "linear_space_general_003_claim_matrix_norm_submultiplicativity"
  ]
}, {
  "name": "行列ノルムによる数ベクトルの評価",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "linear_space_general_003c_claim_matrix_norm_vector_bound"
  ],
  "input": [
    "行列と数ベクトルの積、ノルムと零成分の絶対値",
    "行列積の劣乗法性、複素数と集合記号"
  ],
  "output": [
    "行列を数ベクトルへ作用させた結果のノルムが、行列と数ベクトルのノルムの積以下になること"
  ],
  "mainTheorem": "行列ノルムによる数ベクトルの評価",
  "mainTheoremEntryId": "linear_space_general_003c_claim_matrix_norm_vector_bound",
  "boundaryEvidence": "数ベクトルを第一列に置いた行列を作り、二つのノルムの一致と劣乗法性から作用の評価を得る現存一項で閉じる。直後の完備性と絶対収束判定はこの評価や行列積の劣乗法性を使わず、成分の絶対値をノルムで抑え、実数のCauchy列の収束と有限和の極限へ進む別枝である。有限の行列作用の評価から列と級数の収束への入力切替を根拠とし、プログラミングによる検証で対象・比較と全直接入力の本文・種別・粒度・依存・相対順を固定する。",
  "readabilityStatus": "LLMによる検証で対象・全直接入力と比較する完備性の全本文を読んだ。対象は行列と数ベクトルの積への定義適用、零の列を除く有限和の計算と各行参照が未解決であり、n=1の空の列範囲を保持する。比較側はCauchy列の定義と完備性・絶対収束判定・級数のノルム評価の分割、実数のCauchy完備性と極限法則の前提、有限回の三角不等式の帰納、添字の大小の場合分け、各行参照が未解決である。成分から行列の極限を作る証明は現存する。前提補完と分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_003_matrix_decomposition",
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation",
    "linear_space_general_002b_definition_matrix_norm",
    "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "linear_space_general_003_claim_matrix_norm_submultiplicativity"
  ]
}, {
  "name": "行列積のノルム評価と右からの乗算の連続性",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "linear_space_general_003_claim_matrix_norm_submultiplicativity",
    "linear_space_general_003b_claim_matrix_multiplication_continuity"
  ],
  "input": [
    "成分で定めた行列積とノルム、非負実数の平方根",
    "ノルムの基本性質にある絶対値・有限列の不等式、実数列の極限法則の前提",
    "複素数と集合記号、成分演算と実行列の積への接続"
  ],
  "output": [
    "積のノルムは二因子のノルムの積以下であること",
    "収束する行列列に右から固定した行列を掛けた列も対応する積へ収束すること"
  ],
  "mainTheorem": "右から固定した行列を掛ける操作の連続性",
  "mainTheoremEntryId": "linear_space_general_003b_claim_matrix_multiplication_continuity",
  "boundaryEvidence": "行列積の各成分を有限列の不等式で評価した前項の劣乗法性を、末尾が行列列の差へ適用して収束を示す二項の依存鎖で閉じる。直後の数ベクトルの評価は劣乗法性を共有するが末尾の連続性は使わず、数ベクトルを第一列に置いた行列を作り、行列のノルムと数ベクトルのノルムの一致へ入力が切り替わる別枝である。実数列の極限による収束から有限列の埋込みによる作用の評価への切替を根拠とし、プログラミングによる検証で対象・比較と全直接入力の本文・種別・粒度・依存・相対順を固定する。",
  "readabilityStatus": "LLMによる検証で対象二項・全直接入力と比較する数ベクトルの評価の全本文を読んだ。実行列と複素行列の積の接続、有限和と平方根の同時適用、各行参照が未解決である。連続性は固定した右因子だけについての主張であり、分配則の根拠、非負性と実数列の定数倍・挟み撃ちの極限法則の前提を明示する必要がある。比較側は行列と数ベクトルの積への適用、有限和から零の列を除く計算と各行参照が未解決である。n=1の空の列範囲を保持し、前提補完と分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_001_sqrt_nonnegative_real",
    "calc_formulae_003_matrix_decomposition",
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation",
    "linear_space_general_002b_definition_matrix_norm",
    "linear_space_general_002c_claim_matrix_norm_triangle_inequality"
  ]
}, {
  "name": "ノルムと内積の性質および共役転置",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "linear_space_general_002c_claim_matrix_norm_triangle_inequality",
    "exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms",
    "eigenvalues_of_V_012_claim_star_is_norm_preserving"
  ],
  "input": [
    "複素数の演算・共役・実部・絶対値と実数から複素数への包含",
    "数ベクトルと行列のノルム、成分内積、行列積・共役転置・トレースの定義",
    "非負実数の平方根と集合記号、実数列の極限法則の前提"
  ],
  "output": [
    "ノルムの非退化性・斉次性・三角不等式と極限一意性",
    "成分内積の性質とCauchy–Schwarzの不等式、既出ノルムとの関係",
    "共役転置の積との関係と共役線型性、ノルム保存と極限保存"
  ],
  "mainTheorem": "共役転置のノルム保存と極限保存",
  "mainTheoremEntryId": "eigenvalues_of_V_012_claim_star_is_norm_preserving",
  "boundaryEvidence": "ノルムの基本性質を内積の性質の証明が使い、その冒頭の複素共役の和・積保存を末尾の共役転置が使う現存三項の依存鎖で閉じる。共役転置は内積の公理全体ではなく証明冒頭の複素数の計算を受け取る。直後の劣乗法性は内積の性質と共役転置を使わず、ノルムの基本性質の有限列の不等式と成分の行列積へ戻る別枝である。複素共役による保存則から行列積の大きさの評価への入力切替を根拠とし、プログラミングによる検証で対象・比較と全直接入力の本文・種別・粒度・依存・相対順を固定する。",
  "readabilityStatus": "LLMによる検証で三項・全直接入力と後続劣乗法性の全本文を読んだ。ノルムの四主張と補題、内積の成分式と五群の性質・複素共役の補題、共役転置の積・共役線型性・ノルム保存・極限保存の分割が未解決である。包含写像の各法則の根拠への接続、実数の像と平方根の所属、有限和・数ベクトル・第二式の省略、共役の絶対値への成分代入、実数列の極限法則、同時適用と各行参照の課題が残る。既存の証明と零の場合は保持する。比較側は実行列の積と複素行列の定義の接続、有限和の分解と平方根の同時適用、各行参照が未解決である。前提補完と分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_001_sqrt_nonnegative_real",
    "calc_formulae_003_matrix_decomposition",
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_007_inclusion_rr_to_cc",
    "calc_formulae_010_definition_real_imag_parts_of_cc",
    "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "calculation_formulae_031_definition_abs_arg",
    "calculation_formulae_031b_claim_abs_basic_properties",
    "calculation_formulae_definition_set_and_algebra_notation",
    "eigenvalues_of_V_001_definition_trace",
    "eigenvalues_of_V_011_definition_hermitian_positive_definite",
    "exp_conjugation_definition_complex_conjugate_and_real_part",
    "exp_conjugation_proof_003_definition_M_n_C_convergence",
    "linear_space_general_002b_definition_matrix_norm"
  ]
}, {
  "name": "交換子と共役による複素行列上の写像",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "exp_conjugation_proof_005_definition_ad_X_Ad_g_matrix"
  ],
  "input": [
    "複素行列空間の表記と行列積、交換子と反復の再帰",
    "複素数と集合記号、行列の差・単位元と結合律の前提"
  ],
  "output": [
    "固定した複素行列との交換子を取る写像とその反復",
    "固定した正則複素行列による共役写像と、定義を支える逆行列の一意性"
  ],
  "mainTheorem": null,
  "mainTheoremEntryId": null,
  "boundaryEvidence": "複素行列の積と差から交換子写像を、逆行列の一意性を確かめて共役写像を定める現存一項を定義の節として閉じる。直後のノルムの基本性質は両写像も逆行列も使わず、絶対値・平方根・包含写像・ノルムの成分定義へ戻り、有限和の不等式と極限一意性を扱う別枝である。写像の定義から実数値の大きさの評価への入力切替を根拠とし、プログラミングによる検証で対象・比較と全直接入力の本文・種別・粒度・依存・相対順を固定する。",
  "readabilityStatus": "LLMによる検証で対象・全直接入力と後続のノルムの基本性質の全本文を読んだ。対象は二写像・反復・正則性の定義と逆行列一意性証明の分割、具体的成分の演算法則への接続と各行参照が未解決である。比較側は四主張と非負平方の比較・実数から複素数への包含の計算・有限列のCauchy--Schwarzの補題の分割、有限和の零の議論、実数列の極限法則、数ベクトルへの同様計算、二箇所同時適用と各行参照が未解決である。極限一意性の証明と零の場合の分岐は現存しており、欠落とは扱わない。前提補完と分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_003_matrix_decomposition",
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation",
    "exp_conjugation_proof_003_definition_M_n_C_convergence",
    "exp_conjugation_proof_004_theorem_ad_binomial"
  ]
}, {
  "name": "共役転置とトレースによる内積の定義",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "exp_conjugation_proof_003_definition_M_n_C_convergence"
  ],
  "input": [
    "複素行列の成分と行列積、共役転置、トレースの定義",
    "成分の平方和によるノルムと集合記号"
  ],
  "output": [
    "複素行列空間の表記と、共役転置した第一引数と第二引数の積のトレースで定める二変数関数"
  ],
  "mainTheorem": null,
  "mainTheoremEntryId": null,
  "boundaryEvidence": "共役転置と行列積のトレースを複素数値の二変数関数として定める現存一項で定義が閉じる。直後の交換子と共役の写像はこの項から行列空間の表記だけを受け取り、内積の値や性質を用いず、交換子の再帰と行列積・逆行列を使う別枝である。二変数関数の定義から行列上の二種類の写像への入力切替を根拠とし、プログラミングによる検証で対象・比較と全直接入力の本文・種別・粒度・依存・相対順を固定する。",
  "readabilityStatus": "LLMによる検証で対象・全直接入力と後続の二写像の全本文を読んだ。内積の定義とその性質・既出ノルムとの一致は区別し、性質を定義だけで証明済みとは扱わない。行列空間の表記と関数定義の分割、入力の共役転置とノルムに残る定義・説明の不足が未解決である。比較側は交換子写像とその反復、正則性と共役写像、逆行列一意性の証明が同居し、行列の和・差・単位行列と積の法則を具体的成分計算へ接続する根拠、各行参照が未解決である。前提補完と分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_003_matrix_decomposition",
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation",
    "eigenvalues_of_V_001_definition_trace",
    "eigenvalues_of_V_011_definition_hermitian_positive_definite",
    "linear_space_general_002b_definition_matrix_norm"
  ]
}, {
  "name": "成分の平方和によるノルムと収束の定義",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "linear_space_general_002b_definition_matrix_norm"
  ],
  "input": [
    "複素数の絶対値とその成分表示・実数の包含",
    "非負実数の平方根と集合記号、実数列の収束の前提"
  ],
  "output": [
    "数ベクトルと行列の成分の平方和から定めるノルム",
    "差のノルムで定める列の収束と極限・無限級数の記法"
  ],
  "mainTheorem": null,
  "mainTheoremEntryId": null,
  "boundaryEvidence": "有限個の成分の絶対値と平方根によって大きさを定め、実数列の収束へ接続する現存一項を定義の節として閉じる。共役転置の性質は複素共役の和・積保存の誤参照を既存の内積の性質の証明へ訂正した結果、その証明より後へ移る。直後となるFrobenius内積定義は既出のノルムを共有するが、共役転置・行列積・トレースを追加して複素数値の二変数関数を定めるため入力が切り替わる。プログラミングによる検証で対象・直後と全直接入力を固定し、移動する共役転置とその全直接入力は節自身の入力へ混ぜず比較専用に固定する。",
  "readabilityStatus": "LLMによる検証で対象、直後の内積定義、移動する共役転置と全直接入力を読んだ。対象はノルム・収束・極限・級数の定義分割、実数列の収束と極限法則の前提、後続にある極限一意性の証明への接続が未解決である。比較側の内積定義は後続の性質とノルムの一致への接続を分ける必要がある。共役転置は積・共役線型性・ノルム保存・極限保存の主張分割、有限和への帰納・第二式の省略・絶対値の成分式への代入・同時適用と各行参照が未解決であり、その入力の内積の性質にも包含写像の法則と所属・主張分割の課題が残る。前提補完と分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_001_sqrt_nonnegative_real",
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_007_inclusion_rr_to_cc",
    "calculation_formulae_031_definition_abs_arg",
    "calculation_formulae_031b_claim_abs_basic_properties",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "単位行列のスカラー倍と可換性",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "linear_space_general_002_claim_scalar_identity_commutes"
  ],
  "input": [
    "複素行列の積と交換子の定義",
    "複素数の演算法則と集合記号、行列の和・スカラー倍・単位行列の前提"
  ],
  "output": [
    "単位行列の複素スカラー倍は同じサイズのすべての複素行列と可換であること"
  ],
  "mainTheorem": "単位行列のスカラー倍は全行列と可換",
  "mainTheoremEntryId": "linear_space_general_002_claim_scalar_identity_commutes",
  "boundaryEvidence": "交換子を二つの積の差へ展開し単位行列を消す現存一項で可換性の主張が閉じる。直後のノルムと収束の定義はこの可換性も交換子も使わず、絶対値・非負実数の平方根・実数の包含写像を入力に成分の平方和と実数列の収束を使う。有限行列の積の計算から大きさと収束の定義へ入力が切り替わる境界であり、プログラミングによる検証で対象と比較の全直接入力・本文・種別・粒度・相対順を固定する。",
  "readabilityStatus": "LLMによる検証で対象と全直接入力、比較するノルム定義と全直接入力を読んだ。対象は成分ごとの和・スカラー倍・単位行列の定義と積の法則、二箇所同時適用の分離と各行参照が未解決である。比較側はノルム・列の収束・極限・級数の定義の分割、実数列の収束・極限法則と成分の差・有限和の前提が未整備である。極限の一意性は後続のノルムの基本性質で証明しているが、定義時点ではその証明と級数の値の一意性への接続が未提示であり、絶対値とその入力に残る未完も解消済みとは扱わない。前提補完と分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_003_matrix_decomposition",
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "calculation_formulae_047_claim_commutator_via_anticommutators",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "クロネッカー積で作る行列と数ベクトルの基底",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "linear_space_general_001_theorem_tensor_product_basis"
  ],
  "input": [
    "クロネッカー積の成分定義と各因子についての線型性",
    "複素数と集合記号、有限次元の生成族と基底についての前提"
  ],
  "output": [
    "行列単位と標準基底のクロネッカー積による基底と次元",
    "各因子の任意の基底から得られる行列・数ベクトルの基底"
  ],
  "mainTheorem": "クロネッカー積がつくる基底",
  "mainTheoremEntryId": "linear_space_general_001_theorem_tensor_product_basis",
  "boundaryEvidence": "成分比較で標準基底と行列単位を同定し、線型性で任意の因子基底へ展開する現存一項が基底の主張へ閉じる。直後のスカラー倍した単位行列の可換性は本項やクロネッカー積を使わず、複素行列の積と交換子を入力にする別枝である。基底による生成の議論から成分による積の演算法則への入力切替を根拠とし、プログラミングによる検証で対象と比較の全直接入力・本文・種別・粒度と相対順を固定する。",
  "readabilityStatus": "LLMによる検証で対象・全直接入力と後続可換性の全本文を読んだ。三主張・次元と定義の分割、生成族元数の下限の未証明の一般命題を具体的複素行列へ接続する根拠、有限展開の帰納法・数ベクトルの場合の省略・各行参照が未解決である。比較側を複素行列に具体化し行列積と交換子の参照を補ったが、成分ごとの和・スカラー倍・単位行列の定義と積の法則、二箇所同時適用の分離と各行参照が未解決である。前提補完と分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation",
    "linear_space_general_000_definition_kronecker_product",
    "linear_space_general_000c_claim_kronecker_multilinear"
  ]
}, {
  "name": "クロネッカー積の成分添字と転置",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "linear_space_general_000d_claim_kronecker_transpose"
  ],
  "input": [
    "クロネッカー積の成分の定義と複素数の行列"
  ],
  "output": [
    "クロネッカー積の転置が各因子の転置のクロネッカー積になる等式"
  ],
  "mainTheorem": "クロネッカー積の転置",
  "mainTheoremEntryId": "linear_space_general_000d_claim_kronecker_transpose",
  "boundaryEvidence": "成分の二つの添字を入れ替えて因子ごとの転置へ戻す計算が全成分の一致で閉じる一項を節とする。直後の基底は転置を使わず、行列単位・数ベクトルの標準基底と任意の基底について線型性で展開する別枝である。定義への共通依存だけでまとめず、線型結合と基底の入力が加わる点を境界とし、プログラミングによる検証で対象・比較と全直接入力の本文・依存・種別・粒度・相対順を固定する。",
  "readabilityStatus": "LLMによる検証で対象と全直接入力、後続基底の全本文を読んだ。対象は転置の定義と公式の分割、各サイズへの定義適用と各行参照の明示が残る。比較側は三主張・次元と行列単位等の定義の分割、有限次元の生成族の元数の下限という未証明の一般命題を具体的複素行列へ接続する根拠、有限展開の帰納法と数ベクトルの場合の省略、各行参照が未解決である。生成に関する包含を逆向きに述べた説明は本文で訂正した。前提補完と分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_006_definition_of_cc",
    "linear_space_general_000_definition_kronecker_product"
  ]
}, {
  "name": "クロネッカー積の和とスカラー倍の展開",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "linear_space_general_000c_claim_kronecker_multilinear"
  ],
  "input": [
    "クロネッカー積の成分の定義と複素数の結合律・可換律・分配律",
    "集合記号と成分ごとの和・スカラー倍"
  ],
  "output": [
    "一つの因子の有限線型結合をクロネッカー積全体の有限線型結合へ展開する等式",
    "スカラー倍の特例と数ベクトルについての同形の等式"
  ],
  "mainTheorem": "クロネッカー積の各因子についての線型性",
  "mainTheoremEntryId": "linear_space_general_000c_claim_kronecker_multilinear",
  "boundaryEvidence": "成分定義から一因子の和を複素数の分配律で展開し、全成分の一致へ閉じる現存一項を節とする。直後の転置は本項を使わず、成分添字の入れ替えとクロネッカー積の成分定義だけで計算する別枝であり、線型結合を展開する演算法則の入力が外れる。プログラミングによる検証で対象と比較入力の本文・全直接依存・種別・粒度と後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で対象と全直接入力、後続転置の全本文を読んだ。対象は行列・数ベクトル・スカラー倍の特例の分割、成分ごとの和とスカラー倍の定義、複数演算・同時代入と数ベクトルの同様計算の展開、各行参照が未解決である。比較側は転置の定義と交換公式の主張が同居するため分割が残り、定義の各サイズへの適用と各行の参照を明示する必要がある。M=1の空積を保持し、前提補完と定義・主張の分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "calculation_formulae_definition_set_and_algebra_notation",
    "linear_space_general_000_definition_kronecker_product"
  ]
}, {
  "name": "成分で定めるクロネッカー積と積の規則",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "linear_space_general_000_definition_kronecker_product",
    "linear_space_general_000b_claim_kronecker_product_rule"
  ],
  "input": [
    "複素数の演算法則、集合記号と有限和・有限積",
    "成分による行列積と列ベクトルへの作用"
  ],
  "output": [
    "二値多重添字の全単射による数ベクトルと行列のクロネッカー積",
    "各因子ごとの行列積、単位行列およびベクトルへの作用の公式"
  ],
  "mainTheorem": "クロネッカー積の積の規則",
  "mainTheoremEntryId": "linear_space_general_000b_claim_kronecker_product_rule",
  "boundaryEvidence": "多重添字と成分による定義を入力に、多重添字和の補題で行列積とベクトルへの作用を因子ごとの計算へ帰着する二項が末尾の積の規則へ閉じる。直後の各因子についての線型性は積の規則を使わず、成分の定義へ戻って複素数の分配律で和とスカラー倍を展開する別枝であり、行列積という入力が外れる。共通の記法だけでまとめず、末尾主張への依存の閉包を根拠とする。プログラミングによる検証で全直接依存・本文・種別・粒度・連続性・節末と後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で二項、全直接入力と後続線型性の全本文を読んだ。定義側の元数・値域・全単射と二定義の分割、積の規則の三主張と多重添字和の補題の分割、有限和の帰納法、添字変更・二箇所への同時代入・可換律と結合律の同時適用、各行参照が未解決である。比較側も行列と数ベクトルの主張の分割、成分ごとの和とスカラー倍の定義、積の並べ替えと分配の分離、数ベクトルの同様計算と各行参照が未解決である。複素演算法則の入力にも既存の本文課題が残る。M=1と空和・空積の規約を保ち、前提補完と分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_003_matrix_decomposition",
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "等間隔点の平均の積分への収束",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "freeenergy_004_theorem_riemann_sum_to_integral"
  ],
  "input": [
    "連続実関数と集合記号、一様連続性とRiemann積分の基本性質という外部前提"
  ],
  "output": [
    "等間隔の各区間の代表点での平均の誤差を連続度で抑える評価",
    "代表点のずらし方に依存しない積分への収束"
  ],
  "mainTheorem": "等間隔点の平均は積分に収束する",
  "mainTheoremEntryId": "freeenergy_004_theorem_riemann_sum_to_integral",
  "boundaryEvidence": "各区間の代表点での誤差を連続度で抑え、有限和から全体の誤差評価を得て、一様連続性で収束へ閉じる現存一項を節とする。直後のクロネッカー積はこの極限を使わず、二値多重添字の全単射と複素成分の有限積で数ベクトルと行列を定める別枝である。連続関数の平均から有限配列の成分定義への入力切替を根拠とし、解析の有無自体で章を分けない。プログラミングによる検証で対象と比較入力の本文・全直接依存・種別・粒度および後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で等間隔平均とクロネッカー積定義の全本文・全直接入力を読んだ。平均側は一般形で明示した外部前提の本文内の証明、連続度の上限の有限な存在、誤差評価と収束・代表点の例の主張分割、各行参照と複数演算の分離が残る。比較側は添字の元数・全単射の証明とベクトル・行列の二定義が同居し、数え上げ・有限和の法則と各行参照、同時代入と複数演算の分離が未解決である。本文完成とは扱わず、前提補完と定義・主張の分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "非負実数の指数級数の収束と剰余",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "exp_linear_map_000a_claim_real_exp_series_converges"
  ],
  "input": [
    "非負実数と自然数、集合記号、実数の上限性質"
  ],
  "output": [
    "非負実数の指数級数の収束と部分和の上界",
    "非負剰余の零への収束と有限の末尾和の評価"
  ],
  "mainTheorem": "非負実数の指数級数の収束と剰余評価",
  "mainTheoremEntryId": "exp_linear_map_000a_claim_real_exp_series_converges",
  "boundaryEvidence": "各項の非負性から部分和を単調にし、等比和で上から抑え、上限による極限と剰余へ閉じる現存一項を節とする。零行列の指数は定義への欠落参照を補うと行列指数の定義より後へ移るため、修正後の直後は等間隔点の平均の積分への収束である。この主張は指数級数を使わず、一様連続性とRiemann積分の基本性質から連続度による誤差を評価する別枝である。プログラミングによる検証では対象と直後の比較入力の本文・全直接依存・種別・粒度・相対順に加え、移動した零行列指数とその全直接入力、および指数定義より後の相対順を比較専用で固定する。",
  "readabilityStatus": "LLMによる検証で実指数級数、零行列指数と行列指数の定義、等間隔和と直接入力の全本文を読んだ。部分和・極限・剰余と三主張の分割、Archimedes・等比和・上限から収束を導く根拠、極限の差と各行参照が未解決であり零引数を保つ。零行列指数は行列サイズと成分の所属、正整数冪の計算と収束級数の操作の説明が不足する。等間隔和はイジング固有の導入を外し、使う一様連続性と積分の基本性質を一般形の外部前提として明示するが、それらの本文内の証明、連続度の上限の存在、極限と誤差評価の主張分割と各行参照は残る。補完後に依存と閉包を再判定する構造確定であり本文完成とは扱わない。",
  "externalInputEntryIds": [
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "反復交換子の二項係数による展開",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "exp_conjugation_proof_004_theorem_ad_binomial"
  ],
  "input": [
    "複素数と集合記号、行列の積の成分による定義"
  ],
  "output": [
    "反復交換子を行列の冪の有限和で表す式"
  ],
  "mainTheorem": "反復交換子の二項展開公式",
  "mainTheoremEntryId": "exp_conjugation_proof_004_theorem_ad_binomial",
  "boundaryEvidence": "反復交換子の再帰と二項係数を置き、符号の処理とPascalの法則を準備し、帰納法で二項展開へ閉じる現存一項を節とする。直後の非負実数の指数級数は本項の出力を使わず、各項の非負性・等比級数による評価・実数の上限性質を入力に収束と剰余を導く。行列の再帰式から実数列の評価への入力切替を根拠とし、極限の有無自体は分類条件にしない。プログラミングによる検証で対象と比較入力の本文・全直接依存・種別・粒度および後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で反復交換子と実指数級数の全本文・全直接入力を読んだ。反復交換子・二項係数の定義、符号補題、Pascal則と帰納証明の分割、正整数冪の定義と行列演算法則の根拠、同時代入・複数法則の同時適用と各行参照が未解決である。比較側は単調性・有界性・収束・剰余を一項へ束ね、Archimedesの原理と単調有界列の収束、等比和、極限の差の前提を本文内で説明する必要がある。本文完成とは扱わず、定義・補題の追加と主張分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_003_matrix_decomposition",
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "複素共役から共役転置と正定値行列へ",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "exp_conjugation_definition_complex_conjugate_and_real_part",
    "eigenvalues_of_V_011_definition_hermitian_positive_definite"
  ],
  "input": [
    "実数対による複素数と実部・虚部、実数から複素数への包含、集合記号",
    "行列の積の成分による定義"
  ],
  "output": [
    "複素共役と行列の共役転置",
    "エルミート行列・正定値行列・実対称行列の定義"
  ],
  "mainTheorem": "共役転置を用いたエルミート行列と正定値行列の定義",
  "mainTheoremEntryId": "eigenvalues_of_V_011_definition_hermitian_positive_definite",
  "boundaryEvidence": "複素数対の第二成分の符号を変える共役を定め、それを成分へ使う共役転置からエルミート性と正定値性を定める二項が閉じる。主定理に代わる節末出力は行列の定義群である。直後の反復交換子の二項展開は共役も転置も使わず、積・差・二項係数と帰納法へ入力が切り替わる。プログラミングによる検証で対象と比較入力の本文・全直接依存・種別・粒度、内部依存・連続性・唯一の節末・後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で二定義と反復交換子の全本文・全直接入力を読んだ。複素共役は実数対の式で明示されている。節末は共役転置・エルミート・正定値・実対称を同居させ、列ベクトルへの長方形共役転置の拡張と、実対称の等式と正の実数を実数包含から説明する段、通常転置の記号導入が不足する。比較側は交換子と二項係数の定義・Pascalの法則・帰納証明を同居させ、正整数冪の定義と行列演算法則の根拠、複数演算法則の同時適用、符号の帰納法の展開と各行参照が残る。本文完成とは扱わず、定義・主張の分割と前提補完後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_003_matrix_decomposition",
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_007_inclusion_rr_to_cc",
    "calc_formulae_010_definition_real_imag_parts_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "トレースの定義と冪等行列の像の次元",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "eigenvalues_of_V_001_definition_trace",
    "eigenvalues_of_V_002_claim_trace_properties",
    "eigenvalues_of_V_003_claim_trace_of_idempotent"
  ],
  "input": [
    "複素数、行列の積の成分による定義、集合記号"
  ],
  "output": [
    "対角成分の有限和によるトレースと四つの基本性質",
    "冪等行列の像と核による直和分解、およびトレースと像の次元の一致"
  ],
  "mainTheorem": "冪等行列のトレースは像の次元に等しい",
  "mainTheoremEntryId": "eigenvalues_of_V_003_claim_trace_of_idempotent",
  "boundaryEvidence": "トレースを有限和で定義し、基本性質から相似変換での不変性を得て、像と核に適合する基底で冪等行列のトレースを計算する三項が閉じる。直後の複素共役はこの三項を使わず、実数対の第二成分の符号を変える定義へ入力が切り替わる。プログラミングによる検証で対象と比較入力の本文・全直接依存・種別・粒度、内部依存・連続性・唯一の節末・後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で三項と複素共役の全本文・全直接入力を読んだ。トレースの定義は有限和で明確だが、基本性質の四主張の分割と線型性の計算、有限和の順序交換を正当化する帰納法の展開と積の可換性の分離、各行参照が未解決である。冪等行列は像・核の部分空間性、基底の存在と個数、直和で基底を結合できること、基底変換の可逆性と表現行列の式の前提が未提示である。零次元の像や核も含め、具体的複素行列の計算への接続、像と核の定義と主張の分割を要する。本文完成とは扱わず、前提補完と主張分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_003_matrix_decomposition",
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "正弦の近似と積分の対数評価",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "critical_008_claim_elementary_sine_bounds",
    "critical_009_claim_closed_form_log_integral",
    "critical_010_claim_sine_integral_two_sided"
  ],
  "input": [
    "正弦・余弦、逆双曲線正弦の定義と導関数、非負実数の平方根、集合記号",
    "本文で用いる対数・微分・積分の性質（一般形の前提の整備は未完）"
  ],
  "output": [
    "正弦と半角の差の三次評価と正比例の上下界",
    "逆双曲線正弦による積分値と対数による評価",
    "正弦の平方を含む積分の対数項と有界誤差による上下評価"
  ],
  "mainTheorem": "正弦の平方を含む積分の両側評価",
  "mainTheoremEntryId": "critical_010_claim_sine_integral_two_sided",
  "boundaryEvidence": "正弦の近似と、逆双曲線正弦による積分の計算は互いを使わない二枝であり、末尾の積分の両側評価が両枝を合流させる三項を節とする。直後のトレースの定義はこれらの積分や関数を使わず、複素行列の対角成分の有限和へ入力が切り替わる。解析の使用自体を分類条件とせず、末尾の主張への閉包と次項の入力変更を根拠にする。プログラミングによる検証で対象と比較入力の本文・全直接依存・種別・粒度、二枝の内部依存・連続性・唯一の節末・後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で三項とトレースの全本文・全直接入力を読んだ。正弦側の証明の定義域超過と微分・零での値・π²評価の根拠、積分計算の三主張の分割、対数や平方根の積商法則・合成微分規則・数値評価・複数演算の省略、末尾の積分の定義可能性と評価の分割、c0の正値性とBの数値根拠、各点評価と積分の複数不等式の分割と各行参照を未解決とする。共通の積分の線型性・単調性・基本定理をイジング導入注記から一般形へ切り出す必要がある。トレースは対角成分の有限和として定義されており積分側の未完入力を使わない。本文完成とは扱わず、解析事実の補完と主張分割後に分類・依存・配置を再判定する。 p=0の分岐を維持し、正のpだけで分母を評価する。対数項との差は定数とは断定せず有界な差とする。",
  "externalInputEntryIds": [
    "calc_formulae_001_sqrt_nonnegative_real",
    "calc_formulae_014c_definition_sin",
    "calc_formulae_014e_definition_cos",
    "calculation_formulae_definition_set_and_algebra_notation",
    "critical_001_claim_cosh_addition_and_half_angle"
  ]
}, {
  "name": "双曲線関数の加法公式と逆双曲線正弦",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "critical_001_claim_cosh_addition_and_half_angle"
  ],
  "input": [
    "双曲線関数の定義と基本性質、非負実数の平方根、集合記号",
    "本文で用いる実指数・対数・微分規則と積分の性質（一般形の前提の整備は未完）"
  ],
  "output": [
    "双曲線関数の加法・半角公式と狭義単調性",
    "逆双曲線正弦の定義・逆関数の性質と導関数",
    "非負引数の双曲線正弦の上下評価"
  ],
  "mainTheorem": "双曲線関数の加法・半角公式と逆双曲線正弦の性質",
  "mainTheoremEntryId": "critical_001_claim_cosh_addition_and_half_angle",
  "boundaryEvidence": "双曲線関数の定義から加法・半角公式を示し、単調性から逆関数の性質を、微積分から導関数と上下評価を述べる現存一項を節へ置く。直後の正弦の評価は本項の出力を使わず、正弦と余弦の微分と積分の単調性から三次誤差を評価する別枝である。双曲線関数から正弦・余弦への入力切替を境界とする。プログラミングによる検証で対象と比較入力の本文・全直接依存・種別・粒度および後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で双曲線関数と正弦評価の全本文・全直接入力を読んだ。五群の主張と逆関数定義の分割、指数対数・微分規則の前提、同様計算の展開と各行参照が未解決である。両項のR3/R4はイジング導入注記に混在する積分の性質で、一般形の解析事実として切り出す必要がある。比較側は主張の半角範囲は現行sin/cosの定義域内だが、証明の全非負引数への拡張が定義域を超え、微分公式・零での値・円周率の数値範囲の根拠も未整備である。本文完成とは扱わず、前提補完と主張分割後に分類・依存・配置を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_000b_claim_cosh_sinh_basic_properties",
    "calc_formulae_001_sqrt_nonnegative_real",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "交換子を反交換子で表す行列恒等式",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calculation_formulae_047_claim_commutator_via_anticommutators"
  ],
  "input": [
    "複素数と集合記号、複素行列の演算"
  ],
  "output": [
    "三行列の積の交換子を二つの反交換子で表す恒等式"
  ],
  "mainTheorem": "交換子と反交換子の関係",
  "mainTheoremEntryId": "calculation_formulae_047_claim_commutator_via_anticommutators",
  "boundaryEvidence": "三行列の積の交換子を展開し、零を挿入して左右から括り、二つの反交換子へ閉じる現存一項を節とする。直後の双曲線関数と逆双曲線正弦はこの恒等式を使わず、実指数・非負平方根・対数・微積分を入力として実関数の性質を導く別枝である。有限行列の多項式の展開から実関数の性質へ入力が切り替わる。プログラミングによる検証で対象と比較入力の本文・全直接依存・種別・粒度および後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で交換子恒等式と双曲線関数の五群の全本文・全直接入力を読んだ。交換子側は二定義と恒等式の分割、結合律・分配則の参照、同時代入と零の挿入の演算分解が未解決である。比較側は加法定理・半角公式・単調性・arcsinhの定義と導関数・積分評価が同居し、指数対数・微分規則の前提と各行参照、同様計算の省略が残る。R3/R4という積分の性質はイジング固有の導入注記へ混在しているため、一般形での切り出しが未解決である。その注記全体を道具章の直接入力にせず、解析事実の補完後に分類・依存・配置を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "行列共役による積と単位元の保存と合成",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calculation_formulae_046_claim_conjugation_is_ring_homomorphism"
  ],
  "input": [
    "正則複素行列による共役写像とその線型性",
    "複素数と集合記号"
  ],
  "output": [
    "共役写像の積保存と単位元保存",
    "共役写像の合成則"
  ],
  "mainTheorem": "正則行列による共役写像の三性質",
  "mainTheoremEntryId": "calculation_formulae_046_claim_conjugation_is_ring_homomorphism",
  "boundaryEvidence": "共役写像の定義を受け取り、積・単位元の保存と、積の逆元公式を用いた共役写像の合成則を示す現存一項で閉じる。直後の交換子と反交換子の関係は共役写像を使わず、三行列の積の展開と分配則から直接計算する。正則性と共役写像を使う保存則から、正則性を仮定しない多項式の恒等式への入力切替を境界とする。プログラミングによる検証で対象と比較入力の本文・全直接依存・種別・粒度、節末と後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で共役の三性質・交換子と全直接入力を読んだ。共役の三性質と積の逆元公式の主張分割、先行の加法保存を環準同型という題へ結び付ける説明、行列の結合律・単位元・逆元一意性の根拠と各行参照が未解決である。比較側も交換子と反交換子の定義を恒等式と同居させ、結合律・分配則と零の挿入の説明を各行の根拠へ展開する課題が残る。本文完成とは扱わず、主張分割と演算法則の補完後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_005_matrix_conjugation",
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "正弦と余弦の指数関数による表示",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calculation_formulae_045_theorem_euler_formula_cos_sin"
  ],
  "input": [
    "現行の正弦・余弦、複素数、集合記号",
    "本文で使うが未整備の複素指数・Euler公式・全実数上の三角関数と偶奇性"
  ],
  "output": [
    "正弦と余弦を二つの複素指数の差と和で表す二等式（定義・証明未完）"
  ],
  "mainTheorem": "正弦と余弦のEuler表示",
  "mainTheoremEntryId": "calculation_formulae_045_theorem_euler_formula_cos_sin",
  "boundaryEvidence": "Euler公式を正負の角度で使い、和と差から正弦・余弦の二式を取り出す現存一項を閉じる。直後の行列共役の三性質はこの表示を使わず、正則行列と共役写像を入力とする別枝であり、関数の表示から行列の積・単位元・合成へ入力が切り替わる。プログラミングによる検証では対象と比較入力の本文・全直接依存・種別・粒度および後続相対順を固定する。未定義入力に辺を仮設せず、複素指数等の定義と公式の追加後に配置を再判定する。",
  "readabilityStatus": "LLMによる検証でEuler表示と行列共役の三性質、および全直接入力を読んだ。現行の正弦・余弦は主値区間に限られ、全実数上の拡張・偶奇性、複素指数の定義とEuler公式の導出が不足し、定義と証明は未完である。二等式の分割と各行参照も未解決である。比較側は三性質と積の逆元公式が同居し、行列演算の根拠と各行参照、先行の加法保存を環準同型という題へ結び付ける説明が残る。本文完成とは扱わず、定義・補題の追加と主張分割後に内部依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_014c_definition_sin",
    "calc_formulae_014e_definition_cos",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "逆数の平方根と平方根の逆元",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calculation_formulae_043_claim_sqrt_of_reciprocal",
    "calculation_formulae_044_claim_reciprocal_of_sqrt"
  ],
  "input": [
    "平方根の定義・展開・二乗復元と積の符号条件、非負実数の平方根",
    "複素数と逆元、実数包含、両写像、極座標同値類、絶対値・偏角と角度切断",
    "逆数の偏角、逆正接・正弦・余弦、集合記号"
  ],
  "output": [
    "偏角による逆数の平方根の符号式",
    "平方根の逆元を逆数の平方根で表す符号式"
  ],
  "mainTheorem": "平方根の逆元と逆数の平方根の符号関係",
  "mainTheoremEntryId": "calculation_formulae_044_claim_reciprocal_of_sqrt",
  "boundaryEvidence": "逆数の平方根の公式とその証明中の非零性を、平方根の逆元の公式が使う二項の鎖で閉じる。直後のEuler表示はこの二項も平方根も使わず、指数関数と正弦・余弦の関係へ入力を切り替える。現存本文の依存境界を確定するものであり、比較側に不足する複素指数と全実数上の三角関数の定義・公式を整備した後には依存と配置を再判定する。プログラミングによる検証で対象と比較入力の本文・全直接依存・種別・粒度、内部依存・連続性・唯一の節末・後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で二項とEuler表示および直接入力の全本文を読んだ。平方根定義と入力証明の未完は両項に及ぶ。非零性と平方根1の計算の分割、零での関数値の導出、同時代入と複数演算、各適用行の参照と二重負号の説明が未解決である。比較側は全実数上の三角関数の定義域、複素指数の意味付け、Euler公式の導出と偶奇性が未整備であり、定義・証明の未完として扱う。本文完成を認めず、補完と主張分割後に内部依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_001_sqrt_nonnegative_real",
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_007_inclusion_rr_to_cc",
    "calc_formulae_014c_definition_sin",
    "calc_formulae_014d_definition_arctan",
    "calc_formulae_014e_definition_cos",
    "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "calc_formulae_019_definition_polar_equivalence_class",
    "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "calculation_formulae_027_definition_phi_polar",
    "calculation_formulae_028_definition_phi_cartesian",
    "calculation_formulae_031_definition_abs_arg",
    "calculation_formulae_036_claim_arg_of_reciprocal",
    "calculation_formulae_038_definition_sqrt_of_complex_number",
    "calculation_formulae_039_claim_sqrt_expansion_via_polar",
    "calculation_formulae_040_claim_sqrt_commutativity_condition",
    "calculation_formulae_041_claim_sqrt_squared_is_original",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "平方根の積と自乗の平方根の符号",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calculation_formulae_040_claim_sqrt_commutativity_condition",
    "calculation_formulae_041_claim_sqrt_squared_is_original",
    "calculation_formulae_042_claim_square_of_sqrt"
  ],
  "input": [
    "複素平方根の定義と極座標展開、非負実数の平方根",
    "両写像と未完の同型性、極座標同値類と積",
    "絶対値・偏角、射影、角度切断と存在一意性、複素数と集合記号"
  ],
  "output": [
    "偏角の和による平方根の積の符号条件",
    "平方根を二乗すると元に戻る性質",
    "偏角による自乗の平方根の符号式"
  ],
  "mainTheorem": "自乗の平方根から元の複素数を偏角に応じた符号で得る式",
  "mainTheoremEntryId": "calculation_formulae_042_claim_square_of_sqrt",
  "boundaryEvidence": "平方根と積の交換条件、および平方根の二乗復元を別々に示し、両枝が自乗の平方根の符号式へ合流する三項で閉じる。直後の逆数の平方根は交換条件と二乗復元を使う一方、乗法逆元・逆数の偏角・実数包含と零での三角関数値を用いた平方根1の計算を追加する。自乗の符号式から逆数の式への入力切替を境界とする。プログラミングによる検証では対象と後続比較の全直接入力の本文・全直接依存・種別・粒度、二枝の依存・連続性・唯一の節末・後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で三項と逆数平方根の全本文および入力を読んだ。全てに未完の平方根定義と同型性の影響が残る。交換条件の未整備三角公式・記号導入不足・平方根積法則・同様計算の省略、二乗復元の同時適用と実数計算の省略、符号式の各行参照を具体的な未解決とする。比較側は平方根の非零性と平方根1の計算を同居させ、逆正接・正弦・余弦の零での値の導出が未整備である。本文完成とは扱わず、定義・補題の追加と主張分割後に内部依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_001_sqrt_nonnegative_real",
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "calc_formulae_017_definition_section_of_angle_representation",
    "calc_formulae_019_definition_polar_equivalence_class",
    "calculation_formulae_022_definition_operations_on_polar_representation",
    "calculation_formulae_027_definition_phi_polar",
    "calculation_formulae_028_definition_phi_cartesian",
    "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "calculation_formulae_030_definition_first_and_second_projections",
    "calculation_formulae_031_definition_abs_arg",
    "calculation_formulae_038_definition_sqrt_of_complex_number",
    "calculation_formulae_039_claim_sqrt_expansion_via_polar",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "複素平方根の定義と極座標による展開",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calculation_formulae_038_definition_sqrt_of_complex_number",
    "calculation_formulae_039_claim_sqrt_expansion_via_polar"
  ],
  "input": [
    "非負実数の平方根、複素数と集合記号",
    "両方向の写像と極座標同値類、角度同値関係",
    "半径と角度の射影、角度切断と存在一意性"
  ],
  "output": [
    "半径の平方根と半角を使う複素平方根写像の定義（定義未完）",
    "代表元に依存せず、半径零と正を含む極座標展開式（未完の写像定義に依存）"
  ],
  "mainTheorem": "複素平方根の極座標展開と代表元独立性（未完の写像定義に依存）",
  "mainTheoremEntryId": "calculation_formulae_039_claim_sqrt_expansion_via_polar",
  "boundaryEvidence": "平方根の定義から、代表元独立性と半径零・正の展開式へ進む二項の依存鎖で閉じる。直後の積との交換条件はこの展開を使う一方、未完の同型性による積保存と極座標積、未整備の加法定理とπ移動公式を加えて二つの平方根の積を比較する。一本の平方根の展開から積の比較への入力切替を境界とする。プログラミングによる検証では対象と後続比較の全直接入力の本文・全直接依存・種別・粒度、内部依存・連続性・唯一の節末・後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で定義・展開・交換条件の全本文と全入力を読んだ。平方根と逆方向写像の定義未完が展開へ及ぶことを維持する。展開は代表元独立性と零・正の場合を含むが、主張の分割、同時代入と複数演算、各行参照が未解決である。後続比較は未完の同型性と未整備の三角公式を使うほか、半径・角度の所属と選び方、整数を導入する前の使用、非負平方根の積法則、同様計算の省略も未解決である。これらを本文完成と扱わず、定義・補題の追加と分割後に依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_001_sqrt_nonnegative_real",
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_016_definition_angle_equivalence_class",
    "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "calc_formulae_017_definition_section_of_angle_representation",
    "calc_formulae_019_definition_polar_equivalence_class",
    "calculation_formulae_027_definition_phi_polar",
    "calculation_formulae_028_definition_phi_cartesian",
    "calculation_formulae_030_definition_first_and_second_projections",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "逆数の偏角と負の角度の切断",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calculation_formulae_036_claim_arg_of_reciprocal"
  ],
  "input": [
    "複素数と極座標の逆元、極座標への写像と未完の同型性",
    "絶対値・偏角・非零性、射影と角度切断およびその存在一意性",
    "複素数と集合記号"
  ],
  "output": [
    "非零複素数の逆数の偏角を、偏角が零なら零、それ以外なら2πから偏角を引いた値として表す公式"
  ],
  "mainTheorem": "非零複素数の逆数の偏角の二場合の公式（未完の同型性に依存）",
  "mainTheoremEntryId": "calculation_formulae_036_claim_arg_of_reciprocal",
  "boundaryEvidence": "逆元保存で角度を負にし、零と正の偏角を分けて代表区間へ戻す一項で閉じる。直後の複素平方根定義は逆数の公式を使わず、非負平方根・半角・逆方向写像・極座標同値類へ入力を切り替える別枝である。平方根写像の出力は本節へ含めない。プログラミングによる検証では対象と後続比較の全直接入力の本文・全直接依存・種別・粒度、唯一の節末と後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で逆数の全証明と平方根定義および入力を読んだ。逆数の非零仮定は定義に必要である。対象は未完の同型性に依存し、逆写像の一般論の具体化、各行の参照と実数演算の分解が未解決である。比較対象の平方根は半角が[0,π)に入って現行三角関数の主値区間を超え、逆方向写像も未完であるため、定義自体が未完であることを本文と記録に明示した。定義・証明の補完や分割後には依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "calc_formulae_017_definition_section_of_angle_representation",
    "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
    "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "calculation_formulae_027_definition_phi_polar",
    "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "calculation_formulae_030_definition_first_and_second_projections",
    "calculation_formulae_031_definition_abs_arg",
    "calculation_formulae_031b_claim_abs_basic_properties",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "自乗の偏角と二倍の角度の切断",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calculation_formulae_035_claim_arg_of_square"
  ],
  "input": [
    "極座標への写像と未完の同型性、極座標の積",
    "絶対値・偏角と射影、角度切断と存在一意性",
    "複素数と集合記号"
  ],
  "output": [
    "零の場合を含め、自乗の偏角を二倍の偏角から必要に応じて2πを引く場合分けで表す公式"
  ],
  "mainTheorem": "複素数の自乗の偏角の二場合の公式（未完の同型性に依存）",
  "mainTheoremEntryId": "calculation_formulae_035_claim_arg_of_square",
  "boundaryEvidence": "極座標の積で角度を二倍し、零の場合を先に処理してから二場合の切断へ進む一項で閉じる。直後の逆数の偏角は自乗も商の偏角公式も使わず、両側の乗法逆元と逆元保存を追加入力として負の角度を直接切断する別枝である。自乗には不要な非零仮定を加えず、逆数の定義に必要な非零仮定と区別する。プログラミングによる検証では対象と後続比較の全直接入力の本文・全直接依存・種別・粒度、唯一の節末と後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で自乗と逆数の全本文および入力を読んだ。自乗の零の場合の計算は本文にあり、逆数との仮定の違いは数学的に必要である。いずれも未完の同型性に依存するため証明完成とは扱わない。逆写像の一般論を具体的計算へ開くこと、各適用行のラベル、複数の実数演算をまとめた段の分解が未解決である。定義・証明の補完と本文分割後には依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "calc_formulae_017_definition_section_of_angle_representation",
    "calculation_formulae_022_definition_operations_on_polar_representation",
    "calculation_formulae_027_definition_phi_polar",
    "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "calculation_formulae_030_definition_first_and_second_projections",
    "calculation_formulae_031_definition_abs_arg",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "積の偏角がπになるときの偏角の和",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calculation_formulae_034_claim_range_of_args_when_product_arg_is_pi"
  ],
  "input": [
    "積の偏角の二場合の公式",
    "極座標への写像、絶対値・偏角と非零性、角度切断の存在一意性",
    "複素数と集合記号"
  ],
  "output": [
    "非零複素数の積の偏角がπのとき、偏角の和は切断の二場合に従ってπまたは3πになる"
  ],
  "mainTheorem": "積の偏角がπである場合の偏角の和の二場合",
  "mainTheoremEntryId": "calculation_formulae_034_claim_range_of_args_when_product_arg_is_pi",
  "boundaryEvidence": "積の偏角公式へπの条件を代入し、固定された整数の和に応じて偏角の和をπまたは3πへ定める一項で閉じる。直後の自乗の偏角は本項も積の偏角公式も直接使わず、同型性から得る積保存と極座標積、角度切断を使って二倍の角度を直接計算する別枝である。プログラミングによる検証では対象と後続比較の全直接入力の本文・全直接依存・種別・粒度、唯一の節末と後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証でπ条件と自乗の本文および全入力を読み、公式への代入から積保存による直接計算へ入力が切り替わることを確認した。対象は積の公式を介して、自乗は直接、未完の同型性に依存するので本文完成とは扱わない。対象の固定整数による場合分けは明示されているが、実数演算の分解と各適用行のラベル不足が未解決である。自乗には零の場合の証明があり非零仮定は不要である。本文の補完・分割後には依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "calculation_formulae_027_definition_phi_polar",
    "calculation_formulae_031_definition_abs_arg",
    "calculation_formulae_031b_claim_abs_basic_properties",
    "calculation_formulae_032_claim_arg_of_product",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "商の偏角と角度の差の切断",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calculation_formulae_033_claim_arg_of_quotient"
  ],
  "input": [
    "複素数と極座標の乗法逆元、極座標の積",
    "複素数から極座標への写像と未完の同型性",
    "絶対値・偏角・非零性と射影、角度切断と存在一意性、集合記号"
  ],
  "output": [
    "非零複素数の商の偏角を、偏角の差から必要に応じて2πを足す場合分けで表す公式"
  ],
  "mainTheorem": "非零複素数の商の偏角の二場合の公式（未完の同型性に依存）",
  "mainTheoremEntryId": "calculation_formulae_033_claim_arg_of_quotient",
  "boundaryEvidence": "逆元保存で商の角度を差へ直し、代表区間への二場合の切断まで一項で閉じる。直後の積の偏角がπである条件の項は商の公式を使わず、先行する積の偏角公式へ入力を切り替え、その二場合へπを代入する別枝である。両側の乗法逆元は商の節の入力であり、後続のπ条件の直接入力には含まれない。プログラミングによる検証では対象と後続比較の全直接入力の本文・全直接依存・種別・粒度、一意な節末と後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で商とπ条件の本文および全入力を読んだ。商は逆元を扱い、π条件は積の公式を再利用することが境界の根拠である。商は未完の同型性を使い、π条件も積の公式を介して同じ未完入力に依存するので、いずれも本文完成とは扱わない。抽象的な逆写像の積・単位元保存を具体計算へ展開すること、逆元保存の各行参照、複数演算の分解が未解決である。本文分割・未完入力の補完後には依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "calc_formulae_017_definition_section_of_angle_representation",
    "calculation_formulae_022_definition_operations_on_polar_representation",
    "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
    "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "calculation_formulae_027_definition_phi_polar",
    "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "calculation_formulae_030_definition_first_and_second_projections",
    "calculation_formulae_031_definition_abs_arg",
    "calculation_formulae_031b_claim_abs_basic_properties",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "積の偏角と角度の和の切断",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calculation_formulae_032_claim_arg_of_product"
  ],
  "input": [
    "複素数から極座標同値類への写像と積の対応（同型性の証明は未完）",
    "極座標の積、射影、絶対値と偏角、絶対値の非零性",
    "角度切断とその存在一意性、複素数と集合記号"
  ],
  "output": [
    "非零複素数の積の偏角を、偏角の和から必要に応じて2πを引く場合分けで表す公式"
  ],
  "mainTheorem": "非零複素数の積の偏角の二場合の公式（未完の同型性に依存）",
  "mainTheoremEntryId": "calculation_formulae_032_claim_arg_of_product",
  "boundaryEvidence": "積保存で得る角度の和を代表区間へ戻し、二つの場合の公式まで一項で閉じる。直後の商の偏角はこの公式を直接使わず、複素数と極座標の逆元および逆元保存を追加入力にして角度の差を直接切断する。後のπ条件が積の公式を再利用することと、本項を節末とすることは両立する。プログラミングによる検証では対象と比較側の全直接入力について本文・全直接依存・種別・粒度、唯一の節末と直後の相対順を固定する。",
  "readabilityStatus": "LLMによる検証で積と商の本文および全入力を読み、和の切断と逆元を使う差の切断で入力が切り替わることを確認した。対象と商のいずれも未完の同型性を使うため、証明完成とは扱わない。逆写像が積を保つことの抽象的説明を具体計算へ展開すること、各適用行の参照、複数演算の同時適用は未解決である。外部入力の定義・主張の分割や証明補完後には依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_016b_claim_angle_section_existence_uniqueness",
    "calc_formulae_017_definition_section_of_angle_representation",
    "calculation_formulae_022_definition_operations_on_polar_representation",
    "calculation_formulae_027_definition_phi_polar",
    "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    "calculation_formulae_030_definition_first_and_second_projections",
    "calculation_formulae_031_definition_abs_arg",
    "calculation_formulae_031b_claim_abs_basic_properties",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "半径と偏角の取り出しと絶対値の性質",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calculation_formulae_030_definition_first_and_second_projections",
    "calculation_formulae_031_definition_abs_arg",
    "calculation_formulae_031b_claim_abs_basic_properties"
  ],
  "input": [
    "極座標同値類と角度同値関係、角度代表を選ぶ切断",
    "複素数から極座標同値類への写像、非負平方根",
    "複素数の加法・積・逆元と体の性質、実数包含、集合記号"
  ],
  "output": [
    "半径と角度同値類の射影、複素数の絶対値と偏角",
    "絶対値の成分表示・平方・零との同値・積・三角不等式・実数との一致"
  ],
  "mainTheorem": "成分表示から導く複素数の絶対値の六つの基本性質",
  "mainTheoremEntryId": "calculation_formulae_031b_claim_abs_basic_properties",
  "boundaryEvidence": "射影から絶対値・偏角を定め、成分計算で絶対値の性質を示す三項の依存鎖が末尾の六性質へ閉じる。直後の積の偏角はこの節の定義と非零性の性質を使う一方、極座標の積と未完の同型性、角度切断の存在一意性を新たに直接入力へ取る。成分計算の群と、逆写像の積保存から角度を計算する群の入力切替を境界とする。プログラミングによる検証は対象と後続比較の全直接入力の本文・全直接依存・種別・粒度、内部依存・連続性・節末・後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で三項の全本文と後続の積の偏角の本文を読んだ。絶対値の六性質は逆方向写像や同型性を使わない。第一射影の代表元独立性を末尾で初めて示す提示順と、第二射影の代表元独立性が未提示であること、二つずつの定義の混在、六性質と平方比較・Lagrange恒等式・二成分の不等式の同居、各適用行のラベル不足と複数演算の同時適用が未解決である。加法の定義場所の古い説明も残る。後続比較だけの入力である同型性は定義・証明未完であり、積の偏角の証明へその不足が及ぶことを区別して記録した。本文分割後は節内の依存と閉包を再判定する。",
  "externalInputEntryIds": [
    "calc_formulae_001_sqrt_nonnegative_real",
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_007_inclusion_rr_to_cc",
    "calc_formulae_016_definition_angle_equivalence_class",
    "calc_formulae_017_definition_section_of_angle_representation",
    "calc_formulae_019_definition_polar_equivalence_class",
    "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "calculation_formulae_025_claim_complex_numbers_form_a_field",
    "calculation_formulae_027_definition_phi_polar",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "複素数と極座標同値類の対応と積保存",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calculation_formulae_027_definition_phi_polar",
    "calculation_formulae_028_definition_phi_cartesian",
    "calculation_formulae_029_claim_isomorphism_of_phi_cartesian"
  ],
  "input": [
    "複素数の成分と積、極座標同値類と積、角度同値関係",
    "非負平方根の存在一意性と負数の平方根表示、逆正接",
    "主値区間上で定義された正弦・余弦と逆正接の正弦・余弦公式"
  ],
  "output": [
    "複素数から極座標同値類への場合分けによる写像",
    "極座標同値類から複素数への写像と積保存・全単射を目指す主張（定義・証明は未完）"
  ],
  "mainTheorem": "極座標同値類から複素数への対応の積保存と全単射性（証明未完）",
  "mainTheoremEntryId": "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
  "boundaryEvidence": "二方向の写像を末尾の積保存と全単射の主張が直接使う三項の依存群として配置する。直後の座標射影は三項を使わず、極座標同値類と角度同値関係だけを入力にする別枝へ切り替わる。現存三項の配置を確定するものであり、未整備の三角関数の拡張・性質を追加し、主張を分割した際には内部依存と節の閉包を再判定する。プログラミングによる検証では対象と後続比較の全直接入力の本文・全直接依存・種別・粒度、連続性・節末出力・後続相対順を固定する。",
  "readabilityStatus": "LLMによる検証で両写像と末尾の全計算を読んだ。現行の正弦・余弦は主値区間だけであり、任意角度への写像定義は未完である。全実数への拡張、周期性、加法定理、π移動公式、半径零と正を分けた代表元独立性が不足する。一方向の合成が恒等である計算だけでは単射性は導けず、全単射の証明は未完である。極座標側に加法がないため体として同型という原稿TODOは現状の目標としない。各適用行のラベル不足と主張分割も残るが、これらの定義・証明の不足を説明粒度だけの問題へ縮めない。後続射影の二定義分割と代表元独立性、入力の角度・極座標同値関係の三性質も未解決である。",
  "externalInputEntryIds": [
    "calc_formulae_000c_claim_sqrt_nonnegative_existence_uniqueness",
    "calc_formulae_001_sqrt_nonnegative_real",
    "calc_formulae_002_negative_number_to_sqrt",
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_014c_definition_sin",
    "calc_formulae_014d_definition_arctan",
    "calc_formulae_014e_definition_cos",
    "calc_formulae_015_claim_cos_arctan_sin_arctan",
    "calc_formulae_016_definition_angle_equivalence_class",
    "calc_formulae_019_definition_polar_equivalence_class",
    "calculation_formulae_022_definition_operations_on_polar_representation",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "複素数の逆元と四則演算の性質",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    "calculation_formulae_025_claim_complex_numbers_form_a_field"
  ],
  "input": [
    "実数対上の複素数の加法と積、集合記号",
    "実数の包含写像と複素数の負号"
  ],
  "output": [
    "非零複素数の乗法逆元の成分公式と商の記法",
    "複素数の加法・乗法・分配律を合わせた体の性質"
  ],
  "mainTheorem": "成分ごとの加法と複素積を備えた複素数は体をなす",
  "mainTheoremEntryId": "calculation_formulae_025_claim_complex_numbers_form_a_field",
  "boundaryEvidence": "実数対の積から非零複素数の逆元を示す項を、成分加法と分配律を合わせた体の性質の項が直接使う二項の依存鎖で閉じる。直後の複素数から極座標同値類への写像は二項を使わず、平方根・逆正接・極座標同値類へ直接入力を切り替える。後続写像の出力はこの節へ含めない。プログラミングによる検証では対象と後続比較の全直接入力について本文・全直接依存・種別・粒度を固定し、連続性・内部依存・一意な節末出力・直後の相対順を固定する。",
  "readabilityStatus": "LLMによる検証では乗法群と体の証明を全体で読み、逆元公式から加法と分配律を経た結論への接続を確認した。分配律と結合律の同時適用を同じ定理と説明する箇所、一般集合Sでの逆元一意性、独立した複数主張の混在、行末ラベル不足を具体的な未解決として残す。体の証明冒頭の古い加法説明は現行定義に合わせ、後続写像の欠落参照と逆だった題を修正した。対象の本文完成や後続写像の完成を宣言するものではない。節の外部入力の集合記号と複素数、後続比較だけで使う極座標同値類にも説明粒度の未解決が残る。",
  "externalInputEntryIds": [
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_007_inclusion_rr_to_cc",
    "calc_formulae_008_multiply_by_minus_one",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "極座標の同値類の積と逆元",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calculation_formulae_022_definition_operations_on_polar_representation",
    "calculation_formulae_023_claim_multiplicative_group_of_polar_representation"
  ],
  "input": [
    "実数の四則演算と集合記号",
    "角度の同値関係と、半径・角度の対の同値類"
  ],
  "output": [
    "半径の積と角度の和による同値類の積",
    "積の代表元独立性、結合律と単位元",
    "非零同値類の積の閉性と逆元の公式"
  ],
  "mainTheorem": "極座標同値類の積のモノイド性と非零部分の群・逆元公式",
  "mainTheoremEntryId": "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
  "boundaryEvidence": "同値類の積を定める項から、その代表元独立性、結合律、単位元、非零部分の閉性と逆元を示す項へ進む二項の依存鎖で閉じる。直後の複素数の乗法群はこの二項を使わず、実数対の複素積と実数の包含写像へ直接入力を切り替える。プログラミングによる検証では対象と後続比較に使う全直接入力の本文・直接依存・種別・粒度、二項の連続性・内部依存・節末出力、直後の相対順を固定する。",
  "readabilityStatus": "LLMによる検証では半径零と正の場合分けによる代表元独立性から逆元までの計算と、直後の複素数乗法の成分計算を読んだ。演算定義の代表元独立性が後続主張で初めて示される提示、モノイド性・非零部分の群・逆元公式の混在、一般集合Sでの逆元一意性、各適用行のラベル不足は未解決である。語の有無ではなく、具体的な半径・角度の対の計算と主張分割が残ることを理由に本文完成と区別する。外部入力の同値関係と集合記号、および比較側の複素数の記述にも説明粒度の未解決が残る。",
  "externalInputEntryIds": [
    "calc_formulae_016_definition_angle_equivalence_class",
    "calc_formulae_019_definition_polar_equivalence_class",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "逆正弦から定める正弦・余弦と逆正接",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calc_formulae_014_definition_inverse_trig_functions",
    "calc_formulae_014b_claim_arcsin_bijection",
    "calc_formulae_014c_claim_arctan_argument_in_unit_interval",
    "calc_formulae_014c_definition_sin",
    "calc_formulae_014d_definition_arctan",
    "calc_formulae_014e_definition_cos",
    "calc_formulae_015_claim_cos_arctan_sin_arctan"
  ],
  "input": [
    "実数対としての複素数、集合記号、単位円と円弧長",
    "非負実数の平方根"
  ],
  "output": [
    "逆正弦の定義と全単射性",
    "逆正弦の逆関数としての正弦と、非負平方根で定める余弦（いずれも角度区間を限定）",
    "引数の範囲を確認して定める逆正接",
    "逆正接の正弦と余弦を実数の平方根で表す二つの公式"
  ],
  "mainTheorem": "逆正接の正弦・余弦の明示公式",
  "mainTheoremEntryId": "calc_formulae_015_claim_cos_arctan_sin_arctan",
  "boundaryEvidence": "円弧長から逆正弦を定め、その全単射性から正弦、正弦から余弦を得る。一方、平方根から引数の範囲を確認して逆正接を定める。この二枝を末尾の正弦・余弦の公式で合流させ、七項の節を閉じる。直後の極座標演算は七項を使わず、極座標の同値類を追加して半径の積と角度の和を定める。プログラミングによる検証では全対象と前後比較に使う入力の本文・直接依存・種別・粒度、連続性、内部依存、唯一の節末出力と直後の相対順を固定する。",
  "readabilityStatus": "LLMによる検証では定義域を制限した各関数と二枝の合流を本文から確認した。逆正弦の性質は外部命題への一段の参照に留まり、円弧長にも外部命題の条件と内容の本文内説明が不足する。末尾公式は二主張を一項に束ね、各適用行のラベルと平方根の商の根拠も不足するため本文完成ではない。今回、引数範囲の主張と、直後の極座標演算が使う同値類への欠落参照だけを補った。節の外部入力である集合記号・複素数、および後続比較だけで使う極座標同値類にも説明粒度の未解決が残る。",
  "externalInputEntryIds": [
    "calc_formulae_001_sqrt_nonnegative_real",
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_011_definition_unit_circle",
    "calc_formulae_012_definition_arc_length",
    "calculation_formulae_definition_set_and_algebra_notation"
  ]
}, {
  "name": "非零実数対の単位円への正規化",
  "chapter": "数学的道具立て",
  "status": "構造確定・本文粒度未解決",
  "entryIds": [
    "calc_formulae_012b_claim_radial_normalization_exists_unique",
    "calc_formulae_013_definition_map_cc_to_c_unit"
  ],
  "input": [
    "実数対としての複素数、単位円、集合の記号",
    "非負実数の平方根"
  ],
  "externalInputEntryIds": [
    "calc_formulae_001_sqrt_nonnegative_real",
    "calc_formulae_006_definition_of_cc",
    "calc_formulae_011_definition_unit_circle",
    "calculation_formulae_definition_set_and_algebra_notation"
  ],
  "output": [
    "非零実数対を正の半径と単位円上の対に分ける存在一意性",
    "非零複素数を単位円上へ送る写像"
  ],
  "mainTheorem": "非零実数対の単位円への正規化の存在一意性",
  "mainTheoremEntryId": "calc_formulae_012b_claim_radial_normalization_exists_unique",
  "concludingDefinition": "正規化の存在一意性で定める単位円への写像",
  "concludingDefinitionEntryId": "calc_formulae_013_definition_map_cc_to_c_unit",
  "boundaryEvidence": "平方根と単位円から正の半径と単位円上の対の存在一意性を示し、その結果で写像を定める二項の依存鎖で閉じる。直後の逆正弦はこの二項へ依存せず、円弧長を新たに入力へ加える。円弧長はこの二項節自身の入力には含めない。プログラミングによる検証では二項の連続性、内部依存、唯一の節末出力、対象と全外部入力の本文、対象と直後の完全な直接依存、直後の本文と相対順、および比較で追加される円弧長の本文を固定する。",
  "readabilityStatus": "LLMによる検証では正の平方根で半径を定め、成分を割って単位円へ移し、一意性から写像を定める筋を本文と照合した。正規化証明には各適用行のラベル参照不足と、一行で複数の四則演算をまとめる箇所が残るため、本文完成とは扱わない。外部入力の複素数と集合記号にも説明粒度の未解決が残る。"
}, {
  name: "極座標表現の同値類",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度未解決",
  entryIds: [polarEquivalenceEntry.id],
  input: ["非負実数と実数の対、および集合の記号", "角度を 2π の整数倍の差で同一視する同値関係"],
  externalInputEntryIds: polarEquivalenceSection.externalInputEntryIds,
  output: ["半径零の全角度を同一視し、正の半径では角度の同値関係を使う極座標の同値類"],
  concludingDefinition: "半径と角度の対の同値類",
  concludingDefinitionEntryId: polarEquivalenceEntry.id,
  boundaryEvidence: "前節から角度の同値関係だけを受け取り、代表元の切断と角度表現の演算は使わない。半径を加えて半径と角度の対を同一視する定義で一項節を閉じる。直後の双曲線関数は集合記号だけを直接入力とし、本項にも角度の同値関係にも依存しない。プログラミングによる検証で、対象と全外部入力の本文、完全な直接依存、節末出力、直後の定義の本文・直接入力・相対順を固定する。",
  readabilityStatus: "LLMによる検証では、零半径で角度を区別しない場合と正半径で角度を同一視する場合を式と文章で照合した。欠けていた角度の同値関係への参照を補い、前提を先行定義から追えるようにした。対象と入力の角度同値関係では、反射性・対称性・推移性と商集合の構成を追う説明が未整備である。構造だけを確定し本文完成とは扱わない。外部入力の集合記号にも説明粒度の未解決が残る。",
}, {
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
  name: "共役写像の複素線型性",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度確認済み",
  entryIds: [genericConjugationLinearityEntry.id],
  input: [
    "正の自然数で指定した有限行列サイズ",
    "複素数と有限複素行列の和・積・スカラー倍",
    "可逆行列による共役写像",
  ],
  externalInputEntryIds: genericConjugationLinearityEntry.dependsOnEntryIds,
  output: ["一般の可逆な有限複素行列による共役写像が複素線型であること"],
  mainTheorem: "一般の可逆な有限複素行列による共役写像の複素線型性",
  mainTheoremEntryId: genericConjugationLinearityEntry.id,
  boundaryEvidence: "可逆行列と共役写像の定義を入力とし、イジング模型の記号を使わず複素線型性へ閉じる一項節である。章内依存順105に置き、直後の Pauli 行列群の節とは入力集合が切り替わる。",
  readabilityStatus: "定義、左右の分配、左右の行列積と複素スカラー倍の両立を一行一根拠で示し、Lean と Gaussian 有理数上の SageMath 厳密検査が同じ段を追う。",
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
  status: "構造確定",
  entryIds: [v1PlusHalfInvertibleEntry.id, vTwoInvertibleEntry.id, vPlusFactorsInvertibleEntry.id],
  input: [
    "偶セクターの半指数行列、第二の転送行列 V_2、および偶セクター転送行列 V^{(+)} の定義",
    "有限複素行列の指数関数の逆行列公式",
    "可逆行列の積と非零スカラー倍の可逆性",
  ],
  output: [
    "偶セクターの半指数行列が可逆であること",
    "第二の転送行列 V_2 が可逆であること",
    "偶セクター転送行列 V^{(+)} が可逆であること",
  ],
  boundaryCandidates: vPlusFactorsInvertibilityBoundaryCandidates,
  nextTickUnit: vPlusFactorsInvertibilityNextTickUnit,
  formalizationEvidence: {
    leanFiles: [vPlusFactorsInvertibilityLeanFile, vTwoInvertibilityLeanFile],
    sageMathFile: vPlusFactorsInvertibilitySageMathFile,
    currentStatus: "本文は三つの可逆性を一ブロック一主張へ分けた。V^{(+)} の可逆性は先行する二主張を直接入力に、可逆行列の積の閉性を二回、一段ずつ適用する。Lean の isUnit_V1halfPlus・isUnit_V2・isUnit_VPlus と SageMath の三つの逆行列積検査が各主張へ対応する。",
  },
  mainTheorems: [
    "偶セクターの半指数行列が可逆であること",
    "第二の転送行列 V_2 が可逆であること",
    "偶セクター転送行列 V^{(+)} が可逆であること",
  ],
  boundaryEvidence: "確定済みの正定値性・可逆性とトレース正値性の節に続き、半指数行列は指数行列の逆行列公式だけから可逆性を示す。V_2 は同じ公式と正のスカラー倍の可逆性から可逆性を示す。V^{(+)} はこの二主張を直接入力として、可逆行列の積の閉性を二回適用して可逆性へ閉じる。提示順では半指数行列による共役写像の線型性が続くが、意味的には V^{(+)} の可逆性へ依存せず、一般の共役写像の線型性、半指数行列の可逆性、半整数運動量と添字集合を入力にする。この入力集合の切り替わりにより節を閉じる。",
  readabilityStatus: "三つの可逆性は一ブロック一主張へ分かれている。V^{(+)} の可逆性は先行する半指数行列と V_2 の可逆性を用い、最初の二因子の積、次に三因子の積が可逆であることを一段ずつ示す。Lean の isUnit_VPlus は同じ三単元の積を構成し、SageMath は明示逆との積が単位行列になることを検査するため、本文の推論粒度と形式化対応は合格である。",
}, {
  name: "二つの転送因子による共役写像の線型性",
  chapter: "2次元イジングモデル",
  status: "構造確定・本文粒度確認済み",
  entryIds: [conjugationLinearityEntry.id, vTwoConjugationLinearityEntry.id],
  input: [
    "一般の可逆な有限複素行列による共役写像",
    "偶セクターの半指数行列と第二の転送行列 V_2 の可逆性",
    "半整数運動量の checkZ, checkY",
  ],
  output: [
    "偶セクターの半指数行列による共役写像が checkZ, checkY の線型結合上で複素線型であること",
    "第二の転送行列 V_2 による共役写像が checkZ, checkY の線型結合上で複素線型であること",
  ],
  formalizationEvidence: {
    leanFiles: [genericConjugationLinearityLeanFile, conjugationLinearityLeanFile],
    sageMathFiles: [genericConjugationLinearitySageMathFile, conjugationLinearitySageMathFile],
    currentStatus: "一般形は数学的道具立ての独立主張とし、左右の分配、スカラー移動、結合を一段ずつ示した。二つの特殊化は独立主張とし、それぞれ対応する行列の可逆性、半整数運動量と添字集合を直接入力にした。Lean は一般形の具体的な行列積計算、必要十分版からの特殊化関係、M と添字の本文仮定を持つ二つの特殊化を別定理で追う。SageMath は Gaussian 有理数上で一般形の六段を厳密検査し、半指数行列と V_2 への各代入を検査する。",
  },
  mainTheorems: [
    "偶セクターの半指数行列による共役写像の複素線型性",
    "第二の転送行列 V_2 による共役写像の複素線型性",
  ],
  boundaryEvidence: "一般形はイジング模型を仮定せず有限複素行列だけで意味が定まるため数学的道具立てに置く。二つの特殊化は、それぞれ対応する行列の可逆性と半整数運動量の checkZ, checkY を直接入力に持つため2次元イジングモデルに置く。各特殊化は一ブロック一主張であり、半指数行列の可逆性から V_2 の可逆性へ入力を一つだけ切り替える。直後では偶セクターの合成共役写像を定義するため入力集合が切り替わるので、この二項で節を閉じる。",
  readabilityStatus: "一般形は一ブロック一主張で、定義、左右の分配、スカラー移動、結合を一段ずつ示す。二つの特殊化も一ブロック一主張で、先行する各可逆性と一般形への代入だけを用いる。本文、Lean、SageMath の推論粒度が対応している。",
}, {
  name: "偶セクターの合成共役写像と単一共役との一致",
  chapter: "2次元イジングモデル",
  status: "構造確定・本文粒度確認済み",
  entryIds: vPlusCompositeConjugationSectionEntryIds,
  input: [
    "偶セクター転送行列 V^{(+)} と、その三つの構成因子",
    "半指数行列と第二の転送行列 V_2 の可逆性",
    "一般の可逆な有限複素行列による共役写像と、可逆行列の積の逆行列",
  ],
  externalInputEntryIds: vPlusCompositeConjugationExternalInputEntryIds,
  output: [
    "三つの構成因子による共役の合成として定めた T_{(V^{(+)})}",
    "T_{(V^{(+)})} が V^{(+)} による一つの共役写像と一致すること",
  ],
  formalizationEvidence: {
    leanFile: vPlusCompositeConjugationLeanFile,
    sageMathFile: vPlusCompositeConjugationSageMathFile,
    currentStatus: "本文は合成写像の定義と単一共役との一致を一ブロック一主張へ分け、既存の一般合成則を二回適用する。Lean の TVPlus・TVPlus_apply と TVPlus_eq_TConj・TVPlus_apply_eq_conj が二項へ対応し、SageMath は積の左右逆と二回の合成則を全行列単位上で検査する。",
  },
  concludingClaim: "偶セクターの合成共役写像は V^{(+)} による共役写像そのものである",
  concludingClaimEntryId: vPlusCompositeConjugationEqualityEntry.id,
  boundaryEvidence: "章内依存順69で、半指数行列と V_2 の可逆性、一般の T_g、V^{(+)} の三因子表示から、三つの共役の合成 T_{(V^{(+)})} を定義する。順70はこの定義と既存の一般合成則を直接入力に、半指数行列と V_2 の可逆性から積も可逆であることを確認し、一般合成則を二回適用して T_{(V^{(+)})}=T_{V^{(+)}} へ閉じる。Lean の TVPlus・TVPlus_eq_TConj と SageMath の全行列単位上の合成共役検査が同じ二項へ対応する。直後の順71は実対称生成子と正定値行列の指数関数から正定値行列 W を扱う別枝で、この二項と相互に依存せず、外部入力集合もすべて切り替わるため、順70の後で節を閉じる。生成時に二項の章配置と連続性、全直接依存、本文 fingerprint、Lean の証明本体、SageMath の実検査本体、順71との相互非依存と入力集合の切り替わりを固定検査する。",
  readabilityStatus: "順69は一つの合成写像だけを定義する。順70は構成因子と途中積の可逆性を確認した後、既に証明済みの一般合成則を二回適用して三重共役を一つの共役へまとめる。一つの主張内で一般則を重複証明せず、本文、Lean、SageMath の対応も一意なので、対象二項の説明粒度は合格である。",
}, {
  name: "対称化転送行列 W の実対称性と正定値性",
  chapter: "2次元イジングモデル",
  status: "構造確定・本文粒度確認済み",
  entryIds: [positiveDefiniteWEntry.id],
  input: [
    "対称化転送行列 W とその平方根因子の定義",
    "エルミート正定値行列の定義と、エルミート行列の指数関数の正定値性",
    "第一・第二の生成子の実対称性と、転送行列の記号",
  ],
  externalInputEntryIds: positiveDefiniteWExpectedDirectDependencies,
  output: [
    "W が実対称であること",
    "W が正定値であること",
    "W が可逆であること",
  ],
  formalizationEvidence: {
    leanFile: "lean/Ising2D/Part011/Definition001_SymmetrizedTransferMatrix.lean",
    sageMathFile: "sagemath/check/044_claim_max_eigenvalue/check_01_W_properties.sage",
    currentStatus: "本文は実対称性・正定値性・可逆性を一つの主張の中で Step 1〜3 と可逆性の段に分ける。Lean は diagExp_isSymm・diagExp_posDef・matExp_isSymm・matExp_posDef で二つの指数因子を用意し、symTransfer_isSymm・symTransfer_posDef で合同変換の段を、mulVec_eq_zero_iff_of_isUnit で可逆性の段を追う。SageMath は W の対称性・実性・最小固有値の正値性を数値で検査する。",
  },
  concludingClaim: "対称化転送行列 W は実対称正定値であり、とくに可逆である",
  concludingClaimEntryId: positiveDefiniteWEntry.id,
  boundaryEvidence: "章内依存順71は、W とその平方根因子の定義、エルミート正定値の定義、エルミート行列の指数関数の正定値性、二つの生成子の実対称性、転送行列の記号だけを直接入力に、W の実対称性・正定値性・可逆性を示す。直前の順70までの偶セクター共役写像の節とは入力集合が完全に切り替わり、相互に依存しない。直後の順72は W を受け取るが、単位球面上の上限という実数固有の道具（行列ノルムのベクトル評価と半正定値の Cauchy--Schwarz）を新たに入力へ加えるため、順71の後で節を閉じる。生成時に順71の全直接依存、本文 fingerprint、順72の依存方向と新規入力集合を固定検査する。",
  readabilityStatus: "一つの主張の中で、二つの指数因子が実対称正定値であること、合同変換で W が正定値になること、転置計算で実対称になること、核が零で可逆になることを一段ずつ示している。W = B V_2 B と B = V_1^{1/2} の根拠を定義ブロックへ接続したので、式変形の各行が定義または既証の主張を引く形になった。Lean の各補題と SageMath の検査も同じ段へ対応する。",
}, {
  name: "Rayleigh 上限の定義（実数への脱出点）",
  chapter: "2次元イジングモデル",
  status: "構造確定・本文粒度確認済み",
  entryIds: [rayleighSupEntry.id],
  input: [
    "対称化転送行列 W が実対称正定値であること",
    "数ベクトルと行列のノルムの定義",
    "集合と代数構造の記号",
  ],
  externalInputEntryIds: rayleighSupExpectedDirectDependencies,
  output: [
    "単位ベクトルにわたる二次形式の値の集合が空でなく上に有界であること",
    "その上限として定まる正の実数 c(M)",
    "任意のベクトルに対する二次形式の評価 x^T W x <= c(M) ||x||^2",
  ],
  realEscape: "単位球面上の二次形式の値の集合は有限でも可算でもなく、上限の存在は空でなく上に有界な実数集合が上限をもつという R の性質に依存する。この論文で R へ脱出する最初の箇所であり、本文にもその旨を明記する。",
  formalizationEvidence: {
    leanFile: "lean/Ising2D/NecSuf/RayleighMoments.lean",
    sageMathFile: "sagemath/check/044_claim_max_eigenvalue/check_01_W_properties.sage",
    currentStatus: "本文は、値の集合が空でないこと、成分の有限和による上界、上限の存在、任意のベクトルへの評価を一段ずつ示す。上界は各成分が |x_i| <= ||x|| = 1 を満たすことと有限和の三角不等式だけで得るので、ブロック化されていない Cauchy--Schwarz へ依存しない。",
  },
  concludingClaim: "単位球面上の二次形式の上限 c(M) が正の実数として定まる",
  concludingClaimEntryId: rayleighSupEntry.id,
  boundaryEvidence: "章内依存順72は、順71で確立した W の実対称正定値性とノルムの定義だけを直接入力に、上限 c(M) を定義する。順71までは有限個の複素行列の等式計算で閉じていたのに対し、ここで初めて実数の上限性質を使うため、入力の性質が切り替わる。直後の順73は c(M) を受け取って作用素評価へ進み、半正定値の Cauchy--Schwarz を新たな入力に加えるため、順72の後で節を閉じる。生成時に順72の全直接依存、順73の依存方向、および半正定値 Cauchy--Schwarz が順72の入力でなく順73の入力であることを固定検査する。",
  readabilityStatus: "有界性の根拠が「Cauchy--Schwarz を使うまでもなく」という散文だったため、実際に引くブロックが定まらなかった。各成分の絶対値が 1 以下であることを二段で示し、成分表示の二重和を三角不等式で押さえる形へ書き換えたので、各行が定義または初等的な不等式を一つだけ引く形になった。",
}, {
  name: "上限による作用素評価とその冪",
  chapter: "2次元イジングモデル",
  status: "構造確定・本文粒度確認済み",
  entryIds: [operatorBoundEntry.id],
  input: [
    "上限 c(M) とそこから従う二次形式の評価",
    "対称化転送行列 W の実対称正定値性",
    "半正定値双線型形式の Cauchy--Schwarz の不等式",
    "数ベクトルと行列のノルムの定義",
  ],
  externalInputEntryIds: operatorBoundExpectedDirectDependencies,
  output: [
    "全てのベクトルに対する ||Wx|| <= c(M)||x||",
    "冪についての ||W^k x|| <= c(M)^k ||x||",
  ],
  formalizationEvidence: {
    leanFile: "lean/Ising2D/NecSuf/RayleighMoments.lean",
    sageMathFile: "sagemath/check/044_claim_max_eigenvalue/check_01_W_properties.sage",
    currentStatus: "本文は ||Wx||^4 を半正定値 Cauchy--Schwarz と上限の評価で二段に押さえ、正の数で割る操作と平方の単調性を式変形へ開き、冪の主張を k についての帰納法で示す。",
  },
  concludingClaim: "上限 c(M) が W の作用素としての評価を与え、冪へ持ち上がる",
  concludingClaimEntryId: operatorBoundEntry.id,
  boundaryEvidence: "章内依存順73は、順72の上限とその二次形式評価、順71の実対称正定値性、半正定値 Cauchy--Schwarz、ノルムの定義を直接入力に、作用素評価とその冪を示す。直後の順74は、この評価を受けてトレースの挟み込みへ進み、出力がベクトルの評価から行列のトレースの評価へ切り替わる。生成時に順73の全直接依存、順74の依存方向、および両者が相互に依存しないことを固定検査する。",
  readabilityStatus: "後置きしていた半正定値 Cauchy--Schwarz と上限の評価の参照を、適用した各行の末尾へ移した。正の数で割る操作と平方根を取る操作は、含意の鎖として一行一操作へ開き、非負性の条件を根拠に明示した。帰納法も基底段と帰納段を分け、各行が定義または既証の評価を一つだけ引く。",
}, {
  name: "トレースの上からの評価とモーメント列の対数凸性",
  chapter: "2次元イジングモデル",
  status: "構造確定・本文粒度確認済み",
  entryIds: [tracePowerUpperBoundEntry.id, momentLogConvexityEntry.id],
  input: [
    "上限 c(M) とその二次形式の評価",
    "上限による作用素評価とその冪",
    "対称化転送行列 W の定義と実対称正定値性",
    "半正定値双線型形式の Cauchy--Schwarz の不等式",
  ],
  externalInputEntryIds: [...new Set([
    ...tracePowerUpperBoundExpectedDirectDependencies,
    ...momentLogConvexityExpectedDirectDependencies,
  ])].sort(),
  output: [
    "tr(W^n) <= 2^M c(M)^n",
    "単位ベクトルを固定したモーメント列の正値性",
    "モーメント列の対数凸性 m_k^2 <= m_{k-1} m_{k+1}",
  ],
  formalizationEvidence: {
    leanFile: "lean/Ising2D/NecSuf/RayleighMoments.lean",
    sageMathFile: "sagemath/check/044_claim_max_eigenvalue/check_01_W_properties.sage",
    currentStatus: "上からの評価は標準基底によるトレースの表示から偶奇に分けて各対角成分を c^n で押さえ、有限和へ持ち上げる。対数凸性は半正定値 Cauchy--Schwarz を P=W と P=I の二通りで使い、添字の偶奇で場合分けする。分割前と式変形・根拠は同じである。",
  },
  mainTheorems: [
    "トレースの上からの評価",
    "モーメント列の正値性と対数凸性",
  ],
  boundaryEvidence: "章内依存順74は順73の作用素評価とその冪だけを新しい入力に加えてトレースの上からの評価を示す。順75は同じ W の性質と半正定値 Cauchy--Schwarz だけを使い、順74には依存しない独立な準備である。順76の挟み込みはこの二項を直接入力として結論を組み立てるため、順75の後で節を閉じる。生成時に二項の章配置、全直接依存、相互非依存、および順76が両方を直接引くことを固定検査する。",
  readabilityStatus: "分割前は一ブロックに上からの評価・対数凸性・下からの評価の三主張が同居し、証明中で Step 番号によって相互参照していた。三つの主張へ分け、下からの評価が対数凸性をブロック参照で引く形にしたので、一ブロック一主張になり、どの段がどの主張の根拠かが本文だけで追える。",
}, {
  name: "トレースの挟み込み",
  chapter: "2次元イジングモデル",
  status: "構造確定・本文粒度確認済み",
  entryIds: [tracePowerSandwichEntry.id],
  input: [
    "トレースの上からの評価",
    "モーメント列の正値性と対数凸性",
    "上限 c(M) の定義",
    "半正定値双線型形式の Cauchy--Schwarz の不等式",
  ],
  externalInputEntryIds: tracePowerSandwichExpectedDirectDependencies,
  output: [
    "c(M)^n <= tr(W^n) <= 2^M c(M)^n",
  ],
  formalizationEvidence: {
    leanFile: "lean/Ising2D/NecSuf/RayleighMoments.lean",
    sageMathFile: "sagemath/check/044_claim_max_eigenvalue/check_01_W_properties.sage",
    currentStatus: "下からの評価は、対数凸性から比の単調非減少を出し、望遠鏡積で (x^T W x)^n <= m_n を得て、半正定値行列の二次形式をトレースで押さえ、最後に単位ベクトルにわたる上限を取る。上からの評価は独立した主張から引く。",
  },
  concludingClaim: "対称化転送行列の冪のトレースが上限 c(M) の冪で両側から挟まれる",
  concludingClaimEntryId: tracePowerSandwichEntry.id,
  boundaryEvidence: "分割後の本体は、上からの評価と対数凸性という二つの直前の主張、上限の定義、半正定値 Cauchy--Schwarz だけを直接入力に、両側の評価を組み立てる。直後の分配関数の挟み撃ちは、この結論に加えて分配関数とトレースの一致を新たな入力に取り、対象がトレースから分配関数へ移るため、ここで節を閉じる。生成時に本体の全直接依存、直後の項が本体と分配関数の一致の両方を引くこと、および逆向きの依存が無いことを固定検査する。",
  readabilityStatus: "後置きの散文で置かれていた対角成分の評価の根拠を、適用した行の末尾へ移した。ブロック化されていない実数ベクトルの Cauchy--Schwarz を引いていた行も、半正定値版を P=I と二つのベクトルへ適用する形へ書き換えたので、全ての不等号がブロックのある根拠を引く。",
}, {
  name: "分配関数の挟み撃ち",
  chapter: "2次元イジングモデル",
  status: "構造確定・本文粒度確認済み",
  entryIds: [partitionFunctionSandwichEntry.id],
  input: [
    "分配関数と対称化転送行列の冪のトレースの一致",
    "トレースの挟み込み",
    "パウリ行列による分配関数の表示（設定の共有）",
  ],
  externalInputEntryIds: partitionFunctionSandwichExpectedDirectDependencies,
  output: [
    "c(M)^{N_row} <= Z(J,J') <= 2^M c(M)^{N_row}",
  ],
  formalizationEvidence: {
    leanFile: "lean/Ising2D/NecSuf/RayleighMoments.lean",
    sageMathFile: "sagemath/check/044_claim_max_eigenvalue/check_01_W_properties.sage",
    currentStatus: "分配関数をトレースへ置き換え、トレースの挟み込みの下からの評価と上からの評価をそれぞれ一段で適用する。二つの鎖に分けて書いた。",
  },
  concludingClaim: "分配関数そのものが上限 c(M) の冪で両側から挟まれる",
  concludingClaimEntryId: partitionFunctionSandwichEntry.id,
  boundaryEvidence: "章内依存順77は、分配関数とトレースの一致、トレースの挟み込み、パウリ形の分配関数表示だけを直接入力に、分配関数の両側評価へ移す。これは行列のトレースについての評価を、模型の分配関数についての評価へ言い換える一歩であり、以後この結論を使う項目はすべて順77より後にある。生成時に全直接依存、章内依存順、および順77以前の項目がこの結論を引かないことを固定検査する。",
  readabilityStatus: "一文にまとめていた二段の適用を、下からの評価と上からの評価の二つの鎖へ開き、各行が定義または既証の主張を一つだけ引く形にした。",
}, {
  name: "セクターごとの上限の定義と全スピン反転行列との可換性",
  chapter: "2次元イジングモデル",
  status: "構造確定・本文粒度確認済み",
  entryIds: [sectorRayleighSupEntry.id, epsilonCommutesWithWEntry.id],
  input: [
    "単位球面上の上限 c(M) の定義",
    "全スピン反転行列の固有空間とセクター射影子",
    "クロネッカー積とパウリ行列の積",
    "対称化転送行列 W の定義と、転送行列が全スピン反転行列と可換であること",
  ],
  externalInputEntryIds: [...new Set([
    ...sectorRayleighSupExpectedDirectDependencies,
    ...epsilonCommutesWithWExpectedDirectDependencies,
  ])].sort(),
  output: [
    "セクターごとの上限 c_+(M), c_-(M) が定まること",
    "W が全スピン反転行列と可換であり、二つの固有空間を保つこと",
  ],
  realEscape: "セクターごとの上限も、単位球面上の値の集合に対する実数の上限性質を使う。脱出の性質は c(M) の定義と同じで、新しい種類の脱出は増えない。",
  formalizationEvidence: {
    leanFile: "lean/Ising2D/NecSuf/RayleighMoments.lean",
    sageMathFile: "sagemath/check/044_claim_max_eigenvalue/check_01_W_properties.sage",
    currentStatus: "定義側は、値の集合が全体の集合に含まれるので上に有界であること、および二つの固有空間それぞれに単位ベクトルをクロネッカー積で具体的に構成して空でないことを示す。可換性側は、全スピン反転行列が二つの転送因子と可換であることから五段の等式鎖で W との可換性を出し、固有空間を保つことへつなぐ。",
  },
  mainTheorems: [
    "セクターごとの上限の定義とその整合性",
    "対称化転送行列と全スピン反転行列の可換性",
  ],
  boundaryEvidence: "分割前は一ブロックに、セクター上限の定義、全スピン反転行列との可換性、セクター射影子による表示、最大値としての分解の四つが同居していた。定義と可換性は互いに依存せず、残る二主張はこの二項を直接入力に取る。二項の後で節を閉じ、残りは境界候補として次の単位へ送る。生成時に二項の章配置、全直接依存、相互非依存、および分解の主張が両方を直接引くことを固定検査する。",
  readabilityStatus: "定義と可換性がそれぞれ一ブロック一主張になり、証明中で「(1) より」と番号で指していた箇所がブロック参照へ置き換わった。分割で読む順序が変わらないよう、提示順の先行項目を宣言して本文の並びは分割前と同じ位置に保った。",
}, {
  name: "集合と代数構造の記号、そして複素数の定義",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度確認済み",
  entryIds: [setAndAlgebraNotationEntry.id, complexNumberDefinitionEntry.id],
  input: [
    "自然数・整数・実数の台集合（既知として扱う）",
  ],
  externalInputEntryIds: [],
  output: [
    "台集合と代数構造を区別する記号、および添字を省略する略記の規約",
    "順序で切り出した部分集合の記法",
    "実数の対の集合に加法と乗法を入れて定めた複素数",
  ],
  realEscape: "実数の台集合そのものは構成せず既知として扱う。この論文で扱う量の大半は複素数と有限行列で閉じるが、出発点にある実数は非可算であり、ここがその前提を置く箇所である。",
  formalizationEvidence: {
    leanFile: "lean/Ising2D/Part000",
    sageMathFile: "sagemath/_shared/defs.sage",
    currentStatus: "記号の規約は形式化の対象ではなく、Lean と SageMath ではそれぞれの言語の数値型がこの役割を担う。複素数の定義は Lean の複素数型、SageMath の Gaussian 有理数体または複素数体へ対応する。",
  },
  mainTheorems: [
    "集合と代数構造の記号の規約",
    "複素数の定義",
  ],
  boundaryEvidence: "章内依存順1は何にも依存せず、台集合と代数構造の区別、添字の省略、順序で切り出した部分集合という記号の規約だけを定める。順2はその規約の上で、実数の対に加法と乗法を入れて複素数を定義する。順3の行列の分解からは対象が数から行列へ移り、以後は行列の計算規則が続くため、順2の後で節を閉じる。生成時に二項の章配置、依存順、直接依存、および順3が複素数の定義だけを引くことを固定検査する。",
  readabilityStatus: "二項とも、抽象語彙の自動検査には引っかかっていない。説明粒度の状態表示が「展開または分割を要する」となるのは、記号の規約が後続の複素数定義を、複素数定義が後続の絶対値の性質と行列指数級数の収束を、それぞれ案内として参照しているためである。これらは判定済みの後続案内であって意味的前提ではないので、節の確定を妨げない。内容は高校生が読める粒度で、記号の規約は例つき、複素数は成分による加法と乗法の式で定義されている。",
}, {
  name: "行列の積の定義と、列ごとの作用",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度確認済み",
  entryIds: [matrixDecompositionEntry.id, columnwiseActionEntry.id],
  input: [
    "複素数の定義",
    "集合と代数構造の記号",
  ],
  externalInputEntryIds: [
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation",
  ],
  output: [
    "行列の積の成分による定義",
    "列に並べた行列への積が、列ごとの積と一致すること",
  ],
  formalizationEvidence: {
    leanFile: "lean/Ising2D/Part000",
    sageMathFile: "sagemath/_shared/defs.sage",
    currentStatus: "行列の積は Lean・SageMath の行列型が備える演算に対応する。本文側は成分による定義を持ち、列ごとの作用を成分計算の四段で示す。",
  },
  mainTheorems: [
    "行列の積の成分による定義",
    "行列の積は列ごとに作用する",
  ],
  boundaryEvidence: "章内依存順3は複素数の定義と記号の規約だけを入力に、行列の積を成分の有限和として定める。順4はその定義だけを使い、列に並べた行列への積が列ごとの積になることを成分計算で示す。順5の共役写像からは可逆行列と線型写像という新しい概念が入るため、順4の後で節を閉じる。生成時に二項の依存順、種別、順4が積の定義を引くこと、逆向きの依存が無いこと、および積の定義がラベル mat_mult を保持し続けることを固定検査する。",
  readabilityStatus: "このラベルは本文の20箇所以上から「行列の積の定義」として引かれていたのに、実体は Typst の行列構成子を使った未定義記法の未証明命題だった。引用の意味と一致するよう、成分による積の定義そのものをこのラベルの内容とし、原文が述べていた列ごとの作用は記法を定義したうえで次のブロックへ移して証明を付けた。積の定義が複素数の定義を引くのは、本文の並びでは後ろにあるが依存順では先行する前提であり、案内ではないものとして記録した。",
}, {
  name: "可逆行列による共役写像が和とスカラー倍を保つこと",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度確認済み",
  entryIds: [matrixConjugationEntry.id],
  input: [
    "複素数の定義",
    "行列の積と可逆行列",
  ],
  externalInputEntryIds: ["calc_formulae_006_definition_of_cc"],
  output: [
    "可逆行列 B による共役 A から BAB^{-1} が、和とスカラー倍を保つこと",
  ],
  formalizationEvidence: {
    leanFile: "lean/Ising2D/Part000",
    sageMathFile: "sagemath/_shared/defs.sage",
    currentStatus: "和を保つことは左右の分配則で四段、スカラー倍を保つことはスカラー倍と積の交換で四段。後の章で偶セクター転送行列へ特殊化して使う。",
  },
  concludingClaim: "可逆行列による共役は和とスカラー倍を保つ",
  concludingClaimEntryId: matrixConjugationEntry.id,
  boundaryEvidence: "章内依存順5は複素数の定義だけを外部入力に、可逆行列による共役が和とスカラー倍を保つことを示す。順6の実数から複素数への包含写像は、行列を離れて数の対応を定める別枝であり、順5に依存しない。したがって順5の後で節を閉じる。生成時に順5の直接依存、説明粒度の状態、順6との相互非依存を固定検査する。",
  readabilityStatus: "元の主張は「T_B は線型写像である」と述べており、抽象語彙の自動検査に「抽象線型写像」として引っかかっていた。この論文は抽象度の高い道具を持ち込まない方針なので、主張を「和とスカラー倍を保つ」という二つの等式へ書き換えた。証明はもともと二つを別々に示しており、書き換えで各行の根拠はそのまま使える。",
}, {
  name: "複素数に付随する基本的な定義",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度確認済み",
  entryIds: complexNumberBasicDefinitionEntryIds,
  input: [
    "複素数の定義",
    "集合と代数構造の記号",
  ],
  externalInputEntryIds: [
    "calc_formulae_006_definition_of_cc",
    "calculation_formulae_definition_set_and_algebra_notation",
  ],
  output: [
    "実数を複素数とみなす包含写像",
    "複素数の -1 倍",
    "二乗して -1 になる複素数の記号",
    "複素数の実部と虚部",
  ],
  formalizationEvidence: {
    leanFile: "lean/Ising2D/Part000",
    sageMathFile: "sagemath/_shared/defs.sage",
    currentStatus: "四つとも Lean・SageMath の複素数型が備える構成に対応する。本文側は実数の対としての定義から成分ごとに定める。",
  },
  mainTheorems: [
    "実数から複素数への包含写像",
    "複素数の -1 倍",
    "二乗して -1 になる複素数",
    "複素数の実部と虚部",
  ],
  boundaryEvidence: "章内依存順6から9は、いずれも複素数の定義と記号の規約だけを入力に取り、互いに依存しない四つの定義である。実数の対として定めた複素数に、実数の埋め込み、符号の反転、虚数単位、成分の取り出しという基本的な操作を与える一群にあたる。順10の単位円からは、複素数の絶対値と円弧という幾何の枝が始まり、以後の三角関数の定義へ続くため、順9の後で節を閉じる。生成時に四項の依存順、種別、相互非依存、および順10がこの四項に依存しないことを固定検査する。",
  readabilityStatus: "四項とも定義だけで、実数の対としての複素数から成分ごとに定めており、抽象語彙の自動検査にも引っかかっていない。この節では本文を変更していない。",
}, {
  name: "単位円と円弧",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度未解決",
  entryIds: [unitCircleEntry.id, arcLengthEntry.id],
  input: [
    "複素数の定義",
  ],
  externalInputEntryIds: ["calc_formulae_006_definition_of_cc"],
  output: [
    "絶対値が 1 の複素数の集合としての単位円",
    "単位円上の二点が定める円弧",
  ],
  realEscape: "円弧の長さは実数の量として扱う。この節では長さそのものを構成せず、後の三角関数の定義で使う対象として置く。",
  formalizationEvidence: {
    leanFile: "lean/Ising2D/Part000",
    sageMathFile: "sagemath/_shared/defs.sage",
    currentStatus: "単位円と円弧は、後の角度・三角関数の定義のための舞台であり、形式化側では複素数型の絶対値と実数の区間が対応する。",
  },
  mainTheorems: [
    "単位円の定義",
    "円弧の定義",
  ],
  boundaryEvidence: "章内依存順10は複素数の定義だけを入力に単位円を定め、順11はその単位円だけを入力に円弧を定める。二項は前提から帰結への一方向の鎖をなす。順12から始まる角度表現の枝は、記号の規約だけを入力に取り、単位円にも円弧にも依存しない別の出発点なので、順11の後で節を閉じる。生成時に二項の依存順、種別、直接依存、および順12がこの二項に依存しないことを固定検査する。",
  readabilityStatus: "LLMによる検証で円弧長を指定する外部命題の条件と内容の本文内説明が未整備と判明したため、本文完成とは扱わない。単位円は実数成分の平方和で定めるが、円弧長は外部命題への参照に留まる。この節では本文を変更していない。",
}, {
  name: "角度表現と、その代表元の取り方",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度未解決",
  entryIds: angleRepresentationEntryIds,
  input: [
    "集合と代数構造の記号",
  ],
  externalInputEntryIds: ["calculation_formulae_definition_set_and_algebra_notation"],
  output: [
    "実数を 2π の差で同一視する同値関係",
    "各実数に対して半開区間へ移す整数倍がただ一つ存在すること",
    "その整数倍を使って代表元を取る切断",
    "同値類に加法と実数倍を入れた角度表現",
  ],
  realEscape: "角度表現は実数を出発点にし、2π の差で同一視する。実数の非可算性はそのまま引き継ぐ。可算に落ちるのは、後の章で運動量を有限個の値に限るときである。",
  formalizationEvidence: {
    leanFile: "lean/Ising2D/Part000",
    sageMathFile: "sagemath/_shared/defs.sage",
    currentStatus: "存在と一意性の主張は床関数による整数の取り方に対応する。形式化側では実数型の剰余演算が同じ役割を果たす。",
  },
  mainTheorems: [
    "角度表現の同値関係",
    "半開区間へ移す整数倍の存在と一意性",
    "角度表現の切断",
    "角度表現の定義",
  ],
  boundaryEvidence: "章内依存順12は記号の規約だけを入力に同値関係を定め、順13は同じ入力で代表元を与える整数の存在と一意性を示し、順14はその主張を使って切断を定め、順15は同値関係と切断の両方を使って角度表現を定める。四項は一つのまとまりで、節内の最終出力は角度表現である。先行する同値関係は後続の極座標定義でも再利用する。順16の極座標表現の同値類は角度の同値関係だけを再利用し、代表元の切断と角度表現の演算を使わず、非負の半径を新たな入力に加えて半径と角度の対の商集合を定めるため、順15の後で節を閉じる。生成時に四項の依存順、説明粒度、角度表現が同値関係と切断の両方を引くこと、および順16が四項のうち同値関係だけを引くことを固定検査する。",
  readabilityStatus: "角度表現の定義は、同値関係と切断を記号だけで使っていて、どのブロックの記号かが本文から追えなかった。それぞれの定義への参照を入れ、依存グラフにも現れるようにした。定義の内容は変えていない。LLMによる検証で角度の同値関係の三性質の説明が不足すると判明したため、本文粒度は未解決として区別する。",
}, {
  name: "双曲線余弦と双曲線正弦",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度確認済み",
  entryIds: hyperbolicEntryIds,
  input: ["集合と代数構造の記号", "実数の指数関数"],
  externalInputEntryIds: ["calculation_formulae_definition_set_and_algebra_notation"],
  output: [
    "指数関数の和と差で定めた双曲線余弦・双曲線正弦",
    "積についての加法定理",
    "正値性と大小関係などの基本性質",
  ],
  formalizationEvidence: {
    leanFile: "lean/Ising2D/Part000",
    sageMathFile: "sagemath/_shared/defs.sage",
    currentStatus: "定義は指数関数の和と差そのもので、加法定理と基本性質は実数の四則と指数関数の正値性だけで示す。転送行列の成分計算で繰り返し使う。",
  },
  mainTheorems: [
    "双曲線余弦と双曲線正弦の定義",
    "双曲線関数の積の公式",
    "双曲線関数の基本性質",
  ],
  boundaryEvidence: "章内依存順17は記号の規約だけを入力に二つの関数を定め、順18と順19はその定義だけを使う並行した出力である。順20の平方根の存在と一意性は、この節の基本性質を入力に取りつつ、平方根という新しい対象を導入する別の枝なので、順19の後で節を閉じる。生成時に三項の依存順、説明粒度、順18と順19が互いに依存せず定義だけを引くことを固定検査する。",
  readabilityStatus: "三項とも実数の四則と指数関数だけで書かれ、抽象語彙の自動検査に引っかかっていない。基本性質の証明は 2026-09-03 に散文から含意の鎖へ整えられている。この節では本文を変更していない。",
}, {
  name: "非負実数の平方根と、負数への拡張",
  chapter: "数学的道具立て",
  status: "構造確定・本文粒度確認済み",
  entryIds: squareRootEntryIds,
  input: [
    "双曲線関数の基本性質",
    "集合と代数構造の記号",
  ],
  externalInputEntryIds: [
    "calc_formulae_000b_claim_cosh_sinh_basic_properties",
    "calculation_formulae_definition_set_and_algebra_notation",
  ],
  output: [
    "非負実数に対して平方が一致する非負実数がただ一つ存在すること",
    "平方根の記号",
    "負の実数の平方根を虚数単位で書く規約",
  ],
  realEscape: "平方根の存在は実数の連続性に依存する。有理数の範囲では平方根が存在しない場合があり、ここが可算な数の範囲から出る箇所である。",
  formalizationEvidence: {
    leanFile: "lean/Ising2D/Part000",
    sageMathFile: "sagemath/_shared/defs.sage",
    currentStatus: "存在と一意性は双曲線関数の基本性質を経由して示す。形式化側では実数型の平方根が対応する。",
  },
  mainTheorems: [
    "非負実数の平方根の存在と一意性",
    "平方根の定義",
    "負数の平方根",
  ],
  boundaryEvidence: "章内依存順20は双曲線関数の基本性質と記号の規約を入力に、非負実数の平方根の存在と一意性を示す。順21はその主張を使って記号を定め、順22はその記号を負の実数へ拡張する。三項は一方向の鎖をなす。順23の単位円への正規化は、平方根に加えて単位円を入力に取り、出力が複素数の幾何へ移るため、順22の後で節を閉じる。生成時に三項の依存順、鎖の向き、双曲線関数の基本性質を実際に使うこと、および順23が平方根を引くことを固定検査する。",
  readabilityStatus: "三項とも実数の四則と大小関係だけで書かれている。平方根の存在は実数の連続性に依存するので、脱出理由として記録した。この節では本文を変更していない。",
}];
const toolEntries = entries.filter((entry) => entry.provisionalFinalChapter === "数学的道具立て");
const groupRules: [string, RegExp][] = [
  ["三角関数の評価・有限和・積分", /^(critical_008|critical_009|critical_010|freeenergy_004)/],
  ["トレース・共役転置・正定値性", /^eigenvalues_of_V_|^maxeig_005|frobenius|exp_conjugation_proof_003/],
  ["可逆行列・線型写像との対応・共役変換", /^transfer_matrix_005|^transfer_matrix_claim_end_|^TV1_hatZ_hatY_01[015]|^TV1_hatZ_hatY_009|^TV1_hatZ_hatY_010|^TV1_hatZ_hatY_definition_pauli_group|exp_conjugation_proof_005|^calculation_formulae_046/],
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
