process VCF_HANDLER
{
  tag "${vcfs[0]}, ${vcfs[2]}"
  // debug true
  publishDir params.outdir, mode:'copy'
  errorStrategy 'finish'

// need to consider best error strategy - terminate (default) means if one task fails, the pipeline is immediately terminated
// finish means if a task fails the rest of the running taks will finish running, then the pipeline will terminate
// ignore means all tasks continue and then pipeline finishes successfully

  input:
    tuple val(sample_id), path(vcfs)
    val mutect2_bed
    val pindel_bed
    val mutect2_fasta
    val mutect2_fai
    val vep_docker_image
    val vep_plugins
    val vep_refs
    val vep_annotation
    val maf_file
    val maf_file_tbi
    val mutec2_vcf_path
    val pindel_vcf_path
    val python_packages
  output:
    path "out/allgenes_filtered_vcf/*"
    path "out/bsvi_vcf/*"
    path "out/text_report/*"
    path "out/excel_report/*"
    path "out/pindel_vep_vcf/*"

// will need to see how the vcfs are passed to the process and sort how they are passed to nextflow code
// check files/inputs are of expected type
  script:
    """

    echo "running tool"
    bash nextflow-bin/nextflow_code.sh  ${vcfs[0]} ${vcfs[1]} ${vcfs[2]} ${vcfs[3]} $mutect2_bed $pindel_bed $mutect2_fasta $mutect2_fai $vep_docker_image "$vep_plugins" "$vep_refs" "$vep_annotation" $maf_file $maf_file_tbi $mutec2_vcf_path $pindel_vcf_path "$python_packages"

    """
}
