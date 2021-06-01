using Microsoft.EntityFrameworkCore;
using WebTuDienKHoChuru.Models.User;

#nullable disable

namespace WebTuDienKHoChuru.Models
{
	public partial class TuDienContext : DbContext
	{
		public TuDienContext()
		{
		}

		public TuDienContext(DbContextOptions<TuDienContext> options)
			: base(options)
		{
		}

		public virtual DbSet<Account> Accounts { get; set; }
		public virtual DbSet<BilingualPassage> BilingualPassages { get; set; }
		public virtual DbSet<DictType> DictTypes { get; set; }
		public virtual DbSet<Dictionary> Dictionaries { get; set; }
		public virtual DbSet<Example> Examples { get; set; }
		public virtual DbSet<KhoVietView> KhoVietViews { get; set; }
		public virtual DbSet<ChuruVietView> ChuruVietViews { get; set; }
		public virtual DbSet<Word> Words { get; set; }

		protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
		{
			//if (!optionsBuilder.IsConfigured)
			//{
			//	optionsBuilder.UseSqlServer("Server=.\\SQLExpress;Database=TuDienKHo_Viet_Churu;Trusted_Connection=True;");
			//}
		}

		protected override void OnModelCreating(ModelBuilder modelBuilder)
		{
			modelBuilder.HasAnnotation("Relational:Collation", "SQL_Latin1_General_CP1_CI_AS");

			modelBuilder.Entity<Account>(entity =>
			{
				entity.ToTable("ACCOUNT");

				entity.Property(e => e.Id)
					.ValueGeneratedOnAdd()
					.HasColumnName("ID");

				entity.Property(e => e.Address)
					.IsRequired()
					.HasMaxLength(200);

				entity.Property(e => e.Email).HasMaxLength(100);

				entity.Property(e => e.Fullname)
					.IsRequired()
					.HasMaxLength(100);

				entity.Property(e => e.Password)
					.IsRequired()
					.HasMaxLength(100);

				entity.Property(e => e.PhoneNumber).HasMaxLength(10);

				entity.Property(e => e.Role)
					.IsRequired()
					.HasMaxLength(100);

				entity.Property(e => e.Username)
					.IsRequired()
					.HasMaxLength(50);
			});

			modelBuilder.Entity<BilingualPassage>(entity =>
			{
				entity.ToTable("BILINGUAL_PASSAGE");

				entity.Property(e => e.Id).HasColumnName("ID");

				entity.Property(e => e.Destination).IsRequired();

				entity.Property(e => e.Source).IsRequired();

				entity.HasOne(d => d.DictTypeNavigation)
					.WithMany(p => p.BilingualPassages)
					.HasForeignKey(d => d.DictType)
					.HasConstraintName("FK__BILINGUAL__DictT__412EB0B6");
			});

			modelBuilder.Entity<DictType>(entity =>
			{
				entity.HasKey(e => e.DictType1)
					.HasName("PK__DICT_TYP__AE66BF5E3DA98371");

				entity.ToTable("DICT_TYPE");

				entity.Property(e => e.DictType1)
					.ValueGeneratedOnAdd()
					.HasColumnName("DictType");

				entity.Property(e => e.Description).IsRequired();
			});

			modelBuilder.Entity<Dictionary>(entity =>
			{
				entity.ToTable("DICTIONARY");

				entity.Property(e => e.Id).HasColumnName("ID");

				entity.Property(e => e.Meaning).IsRequired();

				entity.Property(e => e.WordId).HasColumnName("WordID");

				entity.HasOne(d => d.Word)
					.WithMany(p => p.Dictionaries)
					.HasForeignKey(d => d.WordId)
					.HasConstraintName("FK__DICTIONAR__WordI__3B75D760");
			});

			modelBuilder.Entity<Example>(entity =>
			{
				entity.ToTable("EXAMPLE");

				entity.Property(e => e.Id).HasColumnName("ID");

				entity.Property(e => e.Example1)
					.IsRequired()
					.HasColumnName("Example");

				entity.Property(e => e.WordId).HasColumnName("WordID");

				entity.HasOne(d => d.Word)
					.WithMany(p => p.Examples)
					.HasForeignKey(d => d.WordId)
					.HasConstraintName("FK__EXAMPLE__WordID__3E52440B");
			});

			modelBuilder.Entity<KhoVietView>(entity =>
			{
				entity.HasNoKey();

				entity.ToView("KHoViet_View");

				entity.Property(e => e.Example).IsRequired();

				entity.Property(e => e.Id).HasColumnName("ID");

				entity.Property(e => e.Meaning).IsRequired();
			});

			modelBuilder.Entity<ChuruVietView>(entity =>
			{
				entity.HasNoKey();

				entity.ToView("ChuruViet_View");

				entity.Property(e => e.Example).IsRequired();

				entity.Property(e => e.Id).HasColumnName("ID");

				entity.Property(e => e.Meaning).IsRequired();
			});

			modelBuilder.Entity<Word>(entity =>
			{
				entity.ToTable("WORD");

				entity.Property(e => e.Id).HasColumnName("ID");

				entity.Property(e => e.Word1).HasColumnName("Word");

				entity.HasOne(d => d.DictTypeNavigation)
					.WithMany(p => p.Words)
					.HasForeignKey(d => d.DictType)
					.HasConstraintName("FK__WORD__DictType__38996AB5");
			});

			OnModelCreatingPartial(modelBuilder);
		}

		partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
	}
}
