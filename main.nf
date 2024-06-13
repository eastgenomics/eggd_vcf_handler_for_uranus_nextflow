nextflow.enable.dsl=2


include { VCF_HANDLER } from './modules/VCF_HANDLER'

// run workflow

workflow{
  // create bam and bam bam.bai file pairs channel
  // 130112279-24142Q0012-24NGSHO22-8128-0-96527893_markdup_recalibrated_tnhaplotyper2.vcf.gz
  // 130112279-24142Q0012-24NGSHO22-8128-0-96527893_vs_TA2_S59_L008_tumor.flagged.vcf.gz
  //dx://project-GkYP7j04F2bPqzq0q881gZk2:/inputs/mutec2
  //dx://project-GkYP7j04F2bPqzq0q881gZk2:/inputs/pindel

  mutec2_path = "$params.mutec2_vcf_path" + "/*_markdup_recalibrated_tnhaplotyper2.vcf.{gz,gz.tbi}"
  pindel_path = "$params.pindel_vcf_path" + "/*_vs_TA2_S59_L008_tumor.flagged.vcf.{gz,gz.tbi}"

  vcf_pairs_ch = channel.fromFilePairs( ["$mutec2_path", "$pindel_path"], size: -1)

  // I want to have a channel of pairs of these
  VCF_HANDLER(vcf_pairs_ch, params.mutect2_bed, params.pindel_bed, params.mutect2_fasta, params.mutect2_fai, params.vep_docker_image, params.vep_plugins, params.vep_refs, params.vep_annotation, params.maf_file, params.maf_file_tbi)
}

