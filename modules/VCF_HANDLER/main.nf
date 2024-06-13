process VCF_HANDLER
{
  tag "${vcfs[1]}, ${vcfs[3]}"
  debug true
  publishDir params.outdir, mode:'copy'

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
  output:
    path "*.file"

// will need to see how the vcfs are passed to the process and sort how they are passed to nextflow code
  script:
    """
    echo "hello"
    echo ${vcfs[1]}
    echo ${vcfs[2]}
    echo ${vcfs[3]}
    echo ${vcfs[4]}
    bash nextflow-bin/nextflow_code.sh  ${vcfs[1]} ${vcfs[2]} ${vcfs[3]} ${vcfs[4]} $mutect2_bed $pindel_bed $mutect2_fasta $mutect2_fai $vep_docker_image $vep_plugins $vep_refs $vep_annotation $maf_file $maf_file_tbi

    """
}
